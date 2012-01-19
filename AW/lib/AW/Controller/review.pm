package AW::Controller::review;
use Moose;
use JSON;
use Data::Dumper;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

AW::Controller::editor - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->stash->{'template'} = 'review.tt';
    $c->forward('TT');
}


# start editing
sub review : Chained('/') PathPart('view/review')  Args(1) {
    my ( $self, $c, $eid ) = @_;

	# TODO: consider acl issues

	$c->stash->{'essay'} = $eid;
	$c->stash->{'template'} = 'review.tt';
	$c->forward('TT');

} # review

# start editing
sub reviewdata : Chained('/') PathPart('review')  Args(1) {
    my ( $self, $c, $eid ) = @_;

    # from web to model
    my $view_mapping = { 
        'overall quality' => 'overall',
    };
    map { $view_mapping->{$_} = $_; } qw (evidence sufficiency insight comment presentation);

    my @copy_fields = qw (review reviewer essay essay_rev focus quantity);
        

    my $uid = $c->get_session_data ('uid') ;

    if ($c->req->method eq 'POST') {
        my $review = $c->model('DB')->resultset ('CurrentReview')->find ({ essay => $eid, reviewer => $uid });
        return unless defined $review;    # if review is not defined then the user probably should not
                                          # be reviewing this
        my $json = decode_json $c->req->params->{'json'};
        my $data->{'revision'} = $review->get_column ('revision') || 1;
        $data->{'revision'}++;
        map { $data->{$_} = $review->get_column ($_) } @copy_fields;
        map { $data->{$view_mapping->{$_}} = $json->{$_} || $review->get_column ($view_mapping->{$_}); } keys %$view_mapping;
        $c->model('DB')->resultset ('Review')->create ($data);

    } # POST

    my $list = AW::Controller::data::get_data( $c, 'review', $eid, $uid );
    $c->stash->{'review'} = $list;
    $c->forward('JSON');

} # reviewdata


=head1 AUTHOR

del,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
