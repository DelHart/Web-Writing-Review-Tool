package AW::Controller::editor;
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

    $c->stash->{'template'} = 'editor.tt';
    $c->forward('TT');
}

# create a new essay and link it to the appropriate assignment
sub create : Chained('/') PathPart('essay/create')  Args(1) {
    my ( $self, $c, $aid ) = @_;

    my $uid = $c->get_session_data ('uid') ;
    #my $uid = $c->get_session_data ('test_user') || $c->get_session_data ('uid') ;

    $c->log->debug ("user id is $uid\n");

    my $ap = $c->model('DB')->resultset ('AssignmentPerson')->find ({ assignment => $aid, person => $uid });

    # check to see if an essay is defined
    my $essay = $ap->get_column ('essay');
    if (! defined $essay) {
	my $essay_id = $aid * 1000 + $uid;
        my $newessay = $c->model('DB')->resultset('Essay')->create ({ author => $uid, assignment => $aid, essay => $essay_id });
        $essay = $newessay->get_column ('essay');
        $ap->set_column ('essay', $essay);
        $ap->update;
    }
        
    $c->stash->{'essay'} = $essay;
    $c->stash->{'template'} = 'editor.tt';
    $c->forward('TT');
} # create

# start editing
sub edit : Chained('/') PathPart('edit')  Args(1) {
    my ( $self, $c, $eid ) = @_;

    # check that the user is allowed to edit this file
    my $uid = $c->get_session_data ('uid') ;
    my $ap = $c->model('DB')->resultset ('AssignmentPerson')->find ({ person => $uid, essay => $eid });

    if (defined $ap) {
	$c->stash->{'essay'} = $eid;
	$c->stash->{'template'} = 'editor.tt';
	$c->forward('TT');
    }
    else {
	$c->stash->{'msg'} = "Edit operation could not find essay $eid for user $uid";
	$c->stash->{'template'} = 'error.tt';
	$c->forward('TT');
    }
} # edit

# essay handling
sub essay : Chained('/') PathPart('essay')  Args(1) {
    my ( $self, $c, $eid ) = @_;

    my $uid =  $c->get_session_data ('uid') ;
    #my $uid = $c->get_session_data ('test_user') || $c->get_session_data ('uid') ;
    
    my $essay = $c->model('DB')->resultset ('CurrentEssay')->find ({ essay => $eid });

    if ($c->req->method eq 'POST') {
	# TODO: check that the new version is written by the old user author


	$c->log->debug ("json is " . $c->req->params->{'json'} . "\n");
        my $json = decode_json $c->req->params->{'json'};
        # change meta data and update the revision number
        # also common would be just incrementing the revision number
        # to reflect changing data
        my $rev = $essay->get_column('revision') + 1;
        my $title = $json->{'title'} || $essay->get_column('title');
        my $counter = $json->{'counter'} || $essay->get_column ('counter');
        my $status = $json->{'status'} || 0;
        my $approach = $json->{'approach'} || $essay->get_column('approach');
        my $assignment = $essay->get_column ('assignment');
        my $new_essay = $c->model('DB')->resultset ('Essay')->create ( {
            essay => $eid,
            revision => $rev,
            author => $uid,
            title => $title,
            counter => $counter,
            status => $status,
            approach => $approach,
            assignment => $assignment
                
                                                                       });

        warn "looking for $uid and $assignment\n";
        my $ap = $c->model('DB')->resultset('AssignmentPerson')->find ({ person => $uid, assignment => $assignment});
        $ap->set_column ('status', $status);
        $ap->update;

        my $pars = $json->{'pars'};
        if (defined $pars) {
            # need to save the paragraphs
            # create the paragraph object, then create the essay_par object
            foreach my $p (@$pars) {
                warn "this is what I got" . Dumper $p;
                my $old_par = $c->model('DB')->resultset ('CurrentParagraph')->find ( { essay => $eid, paragraph => $p->{'id'} });
               my $p_rev = 1;
                if (defined $old_par) {
                    $p_rev = $old_par->get_column ('revision') + 1;
                }
                my $new_par = $c->model('DB')->resultset ('Paragraph')->create ( {
                    essay => $eid,
                    paragraph => $p->{'id'},
                    revision => $p_rev,
                    words   => $p->{'words'},
                    idea => $p->{'idea'},
                                                                           });

                my $essay_par = $c->model('DB')->resultset ('EssayPars')->create ({
                    essay => $eid,
                    essay_rev => $rev,
                    paragraph => $p->{'id'},
                    paragraph_rev => $p_rev,
                    num => $p->{'position'}
                                                                            });

		# now add the logging info
		my $log_info = $c->model('DB')->resultset('Log')->create ({
			essay => $eid,
			essay_rev => $rev,
			kind => 0,
			id => $p->{'id'},
			id_rev => $p_rev,
			keys => $p->{'keys'},
			times  => $p->{'times'},
});

            } # foreach paragraph

        }

        my $erefs = $json->{'refs'};
        if (defined $erefs) {
            # need to save the references
            # create the eref object, then create the essay_eref object
            foreach my $e (@$erefs) {
                warn "this is what I got" . Dumper $e;
                my $old_ref = $c->model('DB')->resultset ('CurrentEref')->find ( { essay => $eid, eref => $e->{'id'} });
                my $e_rev = 1;
                if (defined $old_ref) {
                    $e_rev = $old_ref->get_column ('revision') + 1;
                }
                my $new_ref = $c->model('DB')->resultset ('Eref')->create ( {
                    essay => $eid,
                    eref => $e->{'id'},
                    revision => $e_rev,
                    utility   => $e->{'utility'},
                    url   => $e->{'url'},
                    nickname => $e->{'name'},
                                                                           });

                my $essay_eref = $c->model('DB')->resultset ('EssayEref')->create ({
                    essay => $eid,
                    essay_rev => $rev,
                    eref => $e->{'id'},
                    eref_rev => $e_rev,
                                                                            });

            } # foreach reference

        }
        $c->stash->{'message'} = 'updated essay ' . $eid;
    } # if data was sent to us
    elsif ($c->req->method eq 'GET') {
        
        my $msg = { title => $essay->get_column ('title'),
                    approach => $essay->get_column ('approach'),
                    status => $essay->get_column ('status'),
                    counter => $essay->get_column ('counter')
                     };

        my @pars = $essay->pars; 
        my $mpars = [];
        foreach my $par (@pars) {
            my $par_id = $par->get_column('paragraph');
            my $par_rev = $par->get_column('paragraph_rev');
	    my $p = $c->model('DB')->resultset('Paragraph')->find ( { 'paragraph' => $par_id, 'revision' => $par_rev, 'essay' => $eid });
            #my $p = $par->par();
            push @$mpars, { id => $p->get_column ('paragraph'), idea => $p->get_column ('idea'), words => $p->get_column ('words'), position => $par->get_column ('num') };
        }
        $msg->{'pars'} = $mpars;

        my @refs = $essay->erefs; 
        my $mrefs = [];
        foreach my $ref (@refs) {
            #my $r = $ref->eref();
		my $eref_id = $ref->get_column ('eref');
		my $eref_rev = $ref->get_column ('eref_rev');
	        my $r = $c->model('DB')->resultset('Eref')->find ( { 'eref' => $eref_id, 'revision' => $eref_rev, 'essay' => $eid } );
            push @$mrefs, { id => $r->get_column ('eref'), url => $r->get_column ('url'), utility => $r->get_column ('utility'), name => $r->get_column ('nickname') };
        }
        $msg->{'refs'} = $mrefs;

        $c->stash->{'essay'} = $msg;

    }

    $c->forward('JSON');

} # edit


=head1 AUTHOR

del,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
