package Legion::Web;

use strict;
use warnings;

use Catalyst::Runtime 5.80;

# Set flags and add plugins for the application
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a Config::General file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root
#                 directory

use parent qw/Catalyst/;
use Catalyst qw(
    -Debug
    Session
    Session::Store::FastMmap
    Session::State::Cookie
    ConfigLoader
    Static::Simple
);

our $VERSION = '0.01';

__PACKAGE__->config->{static}->{ignore_extensions} = [];
__PACKAGE__->config->{session} = { flash_to_stash => 1 };


# Start the application
__PACKAGE__->setup();


=head1 NAME

Legion::Web - Catalyst based application

=head1 SYNOPSIS

    script/legion_web_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<Legion::Web::Controller::Root>, L<Catalyst>

=head1 AUTHOR

Orlando Vazquez

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
