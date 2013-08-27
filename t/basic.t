#!/usr/bin/perl

use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/../lib";

use Test::More tests => 2;

require_ok( 'Queue' );
my $queue = Queue->new({ type => 'test' });
isa_ok($queue, 'Queue');
