package AW::Controller::t;
use Moose;
use namespace::autoclean;
use Data::Dumper;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

AW::Controller::t - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

use visit to wrap calls to regular invokations

$c->visit( $action [, \@captures, \@arguments ] )
$c->visit( $class, $method, [, \@captures, \@arguments ] )

=head1 METHODS

=cut

=head2 index

=cut

sub index : Path : Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched AW::Controller::t in t.');
}    # index

sub t : Chained('/') PathPart('t') CaptureArgs(1) {
    my ( $self, $c, $userid ) = @_;

    $c->store_session_data ('test_user', $userid);

}    # t

sub resend : Chained('t') PathPart('dispatch') {
    my $self   = shift;
    my $c      = shift;
    my @args   = @_;
    my $action = shift;
    $action =~ s|-|/|g;

    warn("forwarding to @_\n");
    $c->visit( $action, @args );

}    # t

sub stopresend : Chained('t') PathPart('stop') {
    my $self   = shift;
    my $c      = shift;
    my @args   = @_;
    my $action = shift;
    $action =~ s|-|/|g;

    $c->store_session_data ('test_user', undef);

    $c->visit ('/dash/index');

}    # t

=head1 AUTHOR

laptop,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

