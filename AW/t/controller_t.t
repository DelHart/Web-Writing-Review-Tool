use strict;
use warnings;
use Test::More;
use Data::Dumper;

eval "use Test::WWW::Mechanize::Catalyst 'AW'";
if ($@) {
    print $@;
    plan skip_all => 'Test::WWW::Mechanize::Catalyst required';
    exit 0;
}

ok( my $mech = Test::WWW::Mechanize::Catalyst->new, 'Created mech object' );

$mech->get_ok( 'http://localhost/t' );
$mech->get_ok( 'http://localhost/t/300/dispatch/get/500' );

# NOTE: tried put, but the parameters were not passing
my $resp = $mech->post ('http://localhost/t/300/dispatch/post/500', {'a' => 3, 'b' => 5} );
# print Dumper $resp;

done_testing();
