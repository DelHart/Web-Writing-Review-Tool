package AW::Controller::login;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

ldap::Controller::login - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;


    # Get the username and password from form
    my $username = $c->request->params->{username} || "";
    my $password = $c->request->params->{password} || "";

    # If the username and password values were found in form
    if ($username && $password) {
	my $cn = "CN=$username,OU=People,OU=SUNY Plattsburgh,DC=plattsburgh,DC=ntds";
        # Attempt to log the user in
        if ($c->authenticate( { id => $username, password => $password} )) {
            $c->log->debug("logged in with $username / $cn and $password going to people");

            $c->session->{'user'} = $username;

	    my $user = $c->model('DB')->resultset('Person')->find( {'uid' => $username});
	    $c->store_session_data ('uid', $user->get_column ('uid_num'));


            $c->response->redirect($c->uri_for('/dash'));
            return;
        } else {
            # Set an error message
            $c->log->debug("did not log in with $username / $cn and $password ");
            $c->stash->{error_msg} = "Bad username or password.";
        }
    }

    # If either of above don't work out, send to the login page
    $c->stash->{template} = 'login.tt';
    $c->forward ('AW::View::TT');

}


=head1 AUTHOR

Del Hart,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

