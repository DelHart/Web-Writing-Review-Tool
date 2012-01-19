package AW::Controller::instructor;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

AW::Controller::instructor - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->stash->{'template'} = 'instructor.tt';
    $c->forward('TT');
}

# return a list of the current assignments
sub list : Chained('/') PathPart('instructor/list')  Args(0) {
    my ( $self, $c ) = @_;

    my $user = $c->stash->{'uid'};

    my @raw =  $c->model('DB')->resultset ('Assignment')->all();
    my $ap = [];
    
    foreach my $r (@raw) {
	my $data = {};
	foreach my $attr (qw (assignment due_date name group url essay)) {
	    $data->{$attr} = $r->get_column($attr);
	}
	push @$ap, $data;
    } # foreach 

    $c->stash->{'results'} = $ap;
    $c->forward('JSON');
} # list

# return a list of the current assignments
sub alist : Chained('/') PathPart('instructor/assignment')  Args(1) {
    my ( $self, $c, $aid ) = @_;

    my $user = $c->stash->{'uid'};

    my @raw =  $c->model('DB')->resultset ('AssignmentPerson')->search ({'assignment' => $aid}, {'order_by' => 'person'});
    my $ap = [];
    
    foreach my $r (@raw) {
	my $data = {};
	foreach my $attr (qw (assignment person status essay)) {
	    $data->{$attr} = $r->get_column($attr);
	}
	push @$ap, $data;
    } # foreach 

    $c->stash->{'results'} = $ap;
    $c->forward('JSON');
} # assignment list



=head1 AUTHOR

del,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
