use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'Catalyst::Test', 'AW' }
BEGIN { use_ok 'AW::Controller::editor' }

ok( request('/editor')->is_success, 'Request should succeed' );
done_testing();
