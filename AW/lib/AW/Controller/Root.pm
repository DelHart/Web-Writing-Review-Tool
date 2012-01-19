package AW::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config( namespace => '' );

=head1 NAME

AW::Controller::Root - Root Controller for AW

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

The root page (/)

=cut

sub index : Path : Args(0) {
    my ( $self, $c ) = @_;

    # Hello World
    $c->response->redirect($c->uri_for('/login'));
}

=head2 default

Standard 404 error page

=cut

sub default : Path {
    my ( $self, $c ) = @_;

    $c->log->debug ("page not found, in default");
    $c->response->redirect($c->uri_for('/login'));
}

=head2 end

Attempt to render a view, if needed.


sub end : ActionClass('RenderView') {
}

=cut
sub auto : Private {
    my ($self, $c) = @_;

    # Allow unauthenticated users to reach the login page.  This
    # allows anauthenticated users to reach any action in the Login
    # controller.  To lock it down to a single action, we could use:
    #   if ($c->action eq $c->controller('Login')->action_for('index'))
    # to only allow unauthenticated access to the C<index> action we
    # added above.
    if ($c->controller eq $c->controller('login')) {
        $c->log->debug('***Root:: appears to be the login page');
        return 1;
    }
    if ($c->controller eq $c->controller('t')) {
        $c->log->debug('***Root:: appears to be the debug page');
        return 1;
    }
    
    $c->log->debug('***Root:: checking for the user');
    # If a user doesn't exist, force login
    if (!$c->user_exists) {
        # Dump a log message to the development server debug output
        $c->log->debug('***Root::auto User not found, forwarding to /login');
        # Redirect the user to the login page
        $c->response->redirect($c->uri_for('/login'));
        # Return 0 to cancel 'post-auto' processing and prevent use of application
        return 0;
    }
    
    $c->log->debug('***Root:: user is ' . $c->user);
    # User found, so return 1 to continue with processing after this 'auto'
    return 1;
}

=head1 AUTHOR

del,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;

