use strict;
use warnings;
use Test::More;

unless ( eval q{use Test::WWW::Mechanize::Catalyst 'AW'; 1} ) {
    plan skip_all => 'Test::WWW::Mechanize::Catalyst required';
    print @!;
    exit 0;
}

ok( my $mech = Test::WWW::Mechanize::Catalyst->new, 'Created mech object' );


done_testing();
