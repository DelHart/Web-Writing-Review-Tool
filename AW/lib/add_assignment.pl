#!/usr/bin/env perl

use strict;
use warnings;

use Getopt::Long;
use Class::C3;
use Pod::Usage;
use WDB;

our $DEFAULT_GROUP = 1;

=head1 NAME

add_assignment - put a new assignment into the database

=head1 SYNOPSIS

add_assignment.pl 

=head1 OPTIONS

=over 4

=back

=head1 DESCRIPTION

This script pull data from the database and distribute it into feedback files for each student.

=cut

my ( $cn, $debug, $help, $file );

GetOptions(
    'debug'      => \$debug,
    'help'       => \$help,
    'course=s'   => \$cn,
    'userfile=s' => \$file
) || pod2usage(2);

pod2usage(1) if $help;

my $user     = $ENV{'DBUSER'};
my $password = $ENV{'DBPASS'};

my $schema =
  WDB->connect( 'dbi:Pg:dbname=writing;host=137.142.101.21', $user, $password );

print "Enter assignment name\n";
my $name = <STDIN>;
chomp $name;

print "Enter assignment description\n";
my $info = <STDIN>;
chomp $info;

my $a = $schema->resultset('Assignment')->create(
    {
        name     => $name,
        info     => $info,
        due_date => 100,
    }
);

my $aid = $a->get_column('assignment');

# now go through all of the students and add the assignment to their list
my @members =
  $schema->resultset('GroupMember')->search( { club => $DEFAULT_GROUP } );
for my $mem (@members) {

    my $person = $mem->get_column('person');
    my $ap =
      $schema->resultset('AssignmentPerson')
      ->create( { assignment => $aid, person => $person, status => 0 } );
}

