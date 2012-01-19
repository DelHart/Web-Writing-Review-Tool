#!/usr/bin/env perl

use strict;
use warnings;
use autodie;

use Getopt::Long;
use Class::C3;
use Pod::Usage;
use WDB;
use Data::Dumper;

=head1 NAME

add_assignment - put a new assignment into the database

=head1 SYNOPSIS

add_assignment.pl 

=head1 OPTIONS

=over 4

=back

=head1 DESCRIPTION


=cut

my ( $cn, $debug, $help, $file );

GetOptions(
    'debug'     => \$debug,
    'help'      => \$help,
    'userfile=s' => \$file
) || pod2usage(2);

pod2usage(1) if $help;


my $user     = $ENV{'DBUSER'};
my $password = $ENV{'DBPASS'};

my $schema = WDB->connect( 'dbi:Pg:dbname=writing;host=137.142.101.21',
    $user, $password );

open my $infile, "<", $file;

while (my $data = <$infile>) {

# CRN:Course:Last Name:First Name:Confidential:Grade:Banner ID:Email:Street1:Street2:City:State:Zip:Phone
my @fields = split (/:/, $data);
next if ($fields[0] eq 'CRN');
print Dumper @fields;

	my $uid = $fields[7];
	$uid =~ s/\@.*//;

my $p = $schema->resultset('Person')->find_or_create ( {
    'uid'  => $uid
                                                   });
	$p->set_columns ({'sur_name' => $fields[2], 'given_name' => $fields[3], 'mail_addr' => $fields[7], 'banner_num'=>$fields[6] });
	$p->update();


} # while
