#!/usr/bin/env perl
use Test::Most;

BEGIN { use_ok('Google::Tasks') }
diag( "Testing Google::Tasks $Google::Tasks::VERSION, Perl $], $^X" );
done_testing();
