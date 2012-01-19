package AW;
use Moose;
use namespace::autoclean;

use Catalyst::Runtime 5.80;

# Set flags and add plugins for the application
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a Config::General file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root
#                 directory

#    Session::Store::File
use Catalyst qw/
    -Debug
    Authentication
    ConfigLoader
    Static::Simple

    Session
    Session::Store::FastMmap
    Session::State::Cookie
/;

extends 'Catalyst';

our $VERSION = '0.01';
$VERSION = eval $VERSION;

# Configure the application.
#
# Note that settings in aw.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with an external configuration file acting as an override for
# local deployment.

__PACKAGE__->config(
    name => 'AW',
    # Disable deprecated behavior needed by old applications
    disable_component_resolution_regex_fallback => 1,
      'authentication' => {
         default_realm => "AW",
         realms => {
           AW => {
             credential => {
               class => "Password",
               password_field => "password",
               password_type => "self_check",
             },
             store => {
               binddn              => "adm-hartdr",
               bindpw              => $ENV{'LDAPPASS'},
               class               => "LDAP",
               ldap_server         => '137.142.201.1',
               ldap_server_options => { timeout => 30 },
               #role_basedn         => "ou=groups,ou=OxObjects,dc=yourcompany,dc=com",
               #role_field          => "uid",
               #role_filter         => "(&(objectClass=posixGroup)(memberUid=%s))",
               #role_scope          => "one",
               #role_search_options => { deref => "always" },
               #role_value          => "dn",
               #role_search_as_user => 0,
               start_tls           => 0,
               start_tls_options   => { verify => "none" },
               entry_class         => "Net::LDAP::Entry",
               use_roles           => 0,
               user_basedn         => "ou=People,ou=SUNY Plattsburgh,dc=plattsburgh,dc=ntds",
		# better for open ldap
               #user_field          => "uid",
               #user_filter         => "(&(objectClass=user)(uid=%s))",
               #user_scope          => "one",
               user_field          => "samaccountname",
               user_filter         => "(sAMAccountName=%s)",
               user_scope          => "sub",
               user_search_options => { deref => "always" },
               user_results_filter => sub { return shift->pop_entry },
             },
           },
         },
       },
);

# Start the application
__PACKAGE__->setup();

=head1 NAME

AW - Catalyst based application

=head1 SYNOPSIS

    script/aw_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<AW::Controller::Root>, L<Catalyst>

=head1 AUTHOR

del,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
