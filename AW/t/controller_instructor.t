use strict;
use warnings;
use Test::More;


use Catalyst::Test 'AW';
use AW::Controller::instructor;

ok( request('/instructor')->is_success, 'Request should succeed' );
done_testing();
