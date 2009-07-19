package Legion::Web::Controller::Root;

use strict;
use warnings;
use parent 'Catalyst::Controller';
use Digest::SHA1 qw( sha1_hex );
use IO::All;

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

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    # Hello World
    #$c->response->body( $c->welcome_message );
    my @files;
    my $storage_dir = $c->config->{storage};
    my $files = [];
    
    for my $file (<$storage_dir/*>) {
        my $sha1 = $file =~ /\.sha1$/
            ? ''
            : io($file . ".sha1")->slurp;

        push @$files, {
            filename => $file,
            sha1 => $sha1
        };
    }
    $c->stash->{files} = $files;
    $c->stash->{template} = 'submit.tt2';
}

sub files :Local Args(0) {
    my ($self, $c) = @_;

    # copy file upload file to the storage directory
    my $storage_dir;
    if (! -d ($storage_dir = $c->config->{storage})) {
        mkdir $storage_dir
            or die "Error creating $storage_dir! $!";
    }

    my $file = $c->req->upload("file")
        or die "Error, source file not uploaded";

    $file->copy_to("$storage_dir/" . $file->filename);

    # sanitize this
    my $output_filename = "$storage_dir/" . $file->filename . ".sha1";

    my $sha1 = Digest::SHA1->new;
    $sha1->addfile($file->fh);
    io($output_filename)->write($sha1->hexdigest);

    $c->stash->{message} = $file->filename . ' successfully uploaded';
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
