package AW::Controller::dash;
use AW::Controller::data;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

AW::Controller::dash - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 index

=cut

sub index : Path : Args(0) {
    my ( $self, $c ) = @_;

    $c->stash->{'template'} = 'dash.tt';
    $c->forward ($c->view('TT'));
}

# find out what assignments someone has

sub assignment : Chained('/') PathPart('assignment') Args(1) {
    my $self = shift;
    my $c    = shift;
    my $arg  = shift;
    #my $uid = $c->get_session_data ('test_user') || $c->get_session_data ('uid');
    my $uid =  $c->get_session_data ('uid');

    #$c->log->debug ('test data is ' . $c->get_session_data ('test_user') . " stash data is " . $c->get_session_data ('uid') . " \n");
    $c->log->debug ('uid is ' . $uid . "\n");

    my $list = AW::Controller::data::get_data( $c, 'assignments', $uid );
    my @sorted = sort { $a->{'assignment'}->[0]->{'due_date'} <=> $b->{'assignment'}->[0]->{'due_date'}} @$list;
    $c->stash->{'results'}  = \@sorted;
    $c->stash->{'orig'} = $list;
    $c->forward( $c->view('JSON') );

}    # assignment

sub reviews : Chained('/') PathPart('reviews') Args(1) {
    my $self = shift;
    my $c    = shift;
    my $arg  = shift;
    #my $uid = $c->get_session_data ('test_user') || $c->get_session_data ('uid');
    my $uid =  $c->get_session_data ('uid');

    #$c->log->debug ('test data is ' . $c->get_session_data ('test_user') . " stash data is " . $c->get_session_data ('uid') . " \n");
    $c->log->debug ('uid is ' . $uid . "\n");

    my $list = AW::Controller::data::get_data( $c, 'reviews', $uid );
    $c->stash->{'results'}  = $list;
    $c->forward( $c->view('JSON') );

}    # reviews

sub rubrics : Chained('/') PathPart('rubric') Args(1) {
    my $self = shift;
    my $c    = shift;
    my $kind = shift;
    
    my $list = AW::Controller::data::get_data( $c, 'rubric', $kind );
    $c->stash->{'results'}  = $list;
    $c->forward( $c->view('JSON') );
    
} # rubrics


=head1 AUTHOR

del

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
