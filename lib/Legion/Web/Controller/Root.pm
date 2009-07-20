package Legion::Web::Controller::Root;

use strict;
use warnings;

use Digest::SHA1 qw( sha1_hex );
use IO::All;
use DBI;
use TheSchwartz::Simple;

use parent 'Catalyst::Controller';

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config->{namespace} = '';

=head1 NAME

Legion::Web::Controller::Root - Root Controller for Legion::Web

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=cut

=head2 index

=cut

sub index :Path Args(0) {
    my ( $self, $c ) = @_;
    
    my $schema = $c->model('DB::Source');
    my @sources = $schema->all;

    $c->stash->{sources} = \@sources;
    $c->stash->{template} = 'submit.tt2';
}

sub render : Local Args(0) {
    my ($self, $c) = @_;

    my $dbh = DBI->connect($c->config->{theschwartz_dsn})
        or die "Couldn't connect to the TheSchwartz DB";

    my $sources_rs = $c->model('DB::Source');
    my $source_id = $c->req->params->{source_id};
    my $source = $sources_rs->find($source_id);

    my $schwartz = TheSchwartz::Simple->new([$dbh]);
    $schwartz->insert(
        'Legion::Worker::FrameMaker',
        {
            source_id   => $source_id,
            frame_first => 1,
            frame_last  => 250
        }
    );

    $c->flash->{message} = "Render job created for " . $source->filename;
    $c->res->redirect($c->uri_for('/'));
}

sub delete_source : Local Args(0) {
    my ($self, $c) = @_;

    my $sources_rs  = $c->model('DB::Source');
    my $source_id   = $c->req->params->{source_id};
    my $source      = $sources_rs->find($source_id);
    my $sha1        = $source->sha1;
    my $filename    = $source->filename;
    my $storage_dir = $c->config->{storage};
    $source->delete;

    my $storage_filename = "$storage_dir/$sha1";
    unlink $storage_filename
        or die "Couldn't delete source $filename";

    $c->flash->{message}
        = "Source $filename successfully deleted";
    $c->res->redirect($c->uri_for('/'));
}

sub files : Local Args(0) {
    my ($self, $c) = @_;

    # copy file upload file to the storage directory
    my $storage_dir;
    if (!-d ($storage_dir = $c->config->{storage})) {
        mkdir $storage_dir
            or die "Error creating $storage_dir! $!";
    }

    my $file = $c->req->upload("file")
        or die "Error, source file not uploaded";
    my $filename = $file->filename;

    my $sha1 = Digest::SHA1->new;
    $sha1->addfile($file->fh);
    my $digest = $sha1->hexdigest;
    $file->copy_to("$storage_dir/$digest");

    my $schema = $c->model('DB::Source');
    $schema->create(
        { filename => $filename, sha1 => $digest, filesize => $file->size });

    $c->stash->{message} = "$filename successfully uploaded";
    $c->res->redirect($c->uri_for('/'));
}

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

Orlando Vazquez

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
