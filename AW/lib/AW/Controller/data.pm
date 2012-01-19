package AW::Controller::data;
use Moose;
use namespace::autoclean;


=head1 NAME

AW::Controller::data - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

my $db = {
    'assignments' => {
        'table'     => 'AssignmentPerson',
        'cols'      => [ 'status', 'essay' ],
        'condition' => sub {
            my $id = shift;
            if ( $id =~ m/\d+/ ) {
                return { 'person' => $id };
            }
            else { return { 'person' => '0' }; }
        },
        'options' => { },
        'related' => [
            {
                'name'      => 'assignment',
                'condition' => { },
                'cols' => [ 'assignment', 'name', 'url', 'info', 'due_date', 'essay', 'revision' ],
            },
            ],
    },
    'rubric' => {
        'table'     => 'Rubric',
        'cols'      => [ 'rubric', 'name', 'info' ],
        'condition' => sub {
            my $id = shift;
            if ( $id =~ m/\d+/ ) {
                return { 'kind' => $id };
            }
            else { return { 'kind' => '0' }; }
        },
        'options' => { },
        'related' => [
            {
                'name'      => 'rubric_values',
                'condition' => { },
                'cols' => [ 'value', 'name', 'information' ],
            },
            ],
    },
# data from a single review
    'review' => {
        'table'     => 'CurrentReview',
        'cols'      => [ 'essay', 'essay_rev', 'create_date', 'sufficiency', 'focus', 'evidence', 'presentation', 'insight', 'quantity', 'overall', 'comment' ],
        'condition' => sub {
            my $essay = shift;
            my $id = shift;
            if ( $id =~ m/\d+/ ) {
                return { 'essay' => $essay, 'reviewer' => $id };
            }
            else { return { 'reviewer' => '0' }; }
        },
        'options' => { },
        'related' => [
            ],
    },
# all reviews available to a person
    'reviews' => {
        'table'     => 'CurrentReview',
        'cols'      => [ 'essay', 'essay_rev', 'create_date' ],
        'condition' => sub {
            my $id = shift;
            if ( $id =~ m/\d+/ ) {
                return { 'reviewer' => $id };
            }
            else { return { 'reviewer' => '0' }; }
        },
        'options' => { 'order_by' => 'essay' },
        'related' => [
            ],
    },
    'essay' => {
        'table'     => 'CurrentEssay',
        'cols'      => [ 'essay', 'revision', 'title', 'status', 'approach', 'counter' ],
        'condition' => sub {
            my $id = shift;
            if ( $id =~ m/\d+/ ) {
                return { 'essay' => $id };
            }
            else { return { 'essay' => '0' }; }
        },
        'options' => { },
        'related' => [
            ],
    },
};


sub get_data  {
    my $c = shift;
    my $objname = shift;
    my @args = @_;

    my $cfg   = $db->{$objname};
    my $table = $cfg->{'table'};
    my $cond  = &{ $cfg->{'condition'} }(@args);
    my @cols  = @{ $cfg->{'cols'} };
    my @rels  = @{ $cfg->{'related'} };

    my $results = [];

    my @list =
      $c->model('DB')->resultset($table)->search( $cond, $cfg->{'options'} );
    foreach my $row (@list) {
        my $data = {};
        foreach my $col (@cols) {
            $data->{$col} = $row->get_column($col);
        }    # col

        foreach my $r (@rels) {
            my @rrow = ();
            my @a =
              $row->search_related( $r->{'name'}, $r->{'condition'},
                $r->{'options'} );
            foreach my $rowa (@a) {
                my $rdata = {};
                foreach my $rcol ( @{ $r->{'cols'} } ) {
                    $rdata->{$rcol} = $rowa->get_column($rcol);
                }    # col
                push @rrow, $rdata;
            }    # related row
            $data->{ $r->{'name'} } = \@rrow;
        }    # related

        push @$results, $data;
    }    # foreach

    return $results;
}    # get_data


=head1 AUTHOR

del

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;

__END__ 

my $db = {
    'course' => {
        'table'     => 'Course',
        'cols'      => [ 'course', 'name' ],
        'condition' => sub {
            my $id = shift;
            if ( $id =~ m/\d+/ ) {
                return { 'course' => $id, 'active' => 'true' };
            }
            else { return { 'active' => 'true' }; }
        },
        'options' => { 'order_by' => 'name' },
        'related' => [
            {
                'name'      => 'prereqs',
                'condition' => { 'amount' => { '>' => 0 } },
                'options' => {},
                'cols'      => [ 'prereq', 'amount', 'note' ],
            },
            {
                'name'      => 'provides',
                'condition' => {},
                'options' => {},
                'cols'      => ['requirement'],
            },
            {
                'name'      => 'offered',
                'condition' => { 'num' => { '>' => 0 } },
        	'options' => { 'order_by' => 'semester' },
                'cols'      => ['semester'],
            },
        ],
    },
    'semester' => {
        'table'     => 'Semester',
        'cols'      => [ 'semester', 'year', 'season' ],
        'condition' => sub {
            my $id = shift;
            if ( $id =~ m/\d+/ ) { return { 'semester' => $id }; }
            else                 { return {}; }
        },
        'options' => { 'order_by' => 'semester' },
        'related' => [
            {
                'name'      => 'courses',
                'condition' => { 'num' => { '>' => 0 } },
                'cols' => [ 'course', 'num' ],
            },
        ],
    },
    'person' => {
        'table'     => 'Person',
        'cols'      => [ 'uid_num', 'uid', 'sur_name', 'given_name' ],
        'condition' => sub {
            my $id = shift;
            return { 'uid' => $id }; 
        },
        'options' => {  },
        'related' => [
            {
                'name'      => 'plans',
                'condition' => {  },
                'cols' => [ 'course', 'semester' ],
            },
            {
                'name'      => 'plan_infos',
                'condition' => {  },
                'cols' => [ 'notes', 'change_time' ],
            },
        ],
    },
};

