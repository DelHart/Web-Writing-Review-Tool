#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'Catalyst::Test', 'AW' }

ok( request('/')->is_success, 'Request should succeed' );
ok( request('/t')->is_success, 'Request should succeed' );

done_testing();
