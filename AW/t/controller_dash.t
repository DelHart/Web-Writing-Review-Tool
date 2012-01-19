use strict;
use warnings;
use Test::More;
use Data::Dumper;
use JSON;

unless ( eval q{use Test::WWW::Mechanize::Catalyst 'AW'; 1} ) {
    plan skip_all => 'Test::WWW::Mechanize::Catalyst required';
    print @!;
    exit 0;
}

ok( my $mech = Test::WWW::Mechanize::Catalyst->new, 'Created mech object' );

$mech->get_ok('http://localhost/dash');

# check empty response list
my $resp = $mech->get('http://localhost/t/-2/dispatch/-dash-assignment/list');
ok( $resp, "Empty list test response" );
my $json = from_json( $resp->content );
is( $json->{'uid'},           -2, 'checking uid' );
is( $#{ $json->{'results'} }, -1, 'checking result length' );

# check empty response list
$resp = $mech->get('http://localhost/t/-1/dispatch/-dash-assignment/list');
ok( $resp, "One element list test response" );
$json = from_json( $resp->content );
is( $#{ $json->{'results'} }, 0, 'checking result length' );

print Dumper $json;

done_testing();

