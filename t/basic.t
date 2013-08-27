#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;
use FindBin;
use lib "$FindBin::Bin/../lib";

use Test::More;
use feature 'say';

require_ok( 'Queue' );

my $queue = Queue->new({ type => 'test' });

isa_ok($queue, 'Queue');
is($queue->get_type(), 'test', 'type was correctly set as test');
is($queue->size(), 3, 'queue is at size 3');

my $queue_item = $queue->dequeue;

isa_ok($queue_item, 'QueueItem');
ok($queue_item->has_flag('claimed') == 1, 'relevant_id 1 has flag "claimed"');
ok($queue_item->has_flag('attempt_2') == 0, 'relevant_id 1 does not have flag "attempt_2"');
is($queue->size(), 2, 'queue is at size 2');

ok($queue->enqueue($queue_item) == 1, 'add item back to the queue');
is($queue->size(), 3, 'queue is at size 3');

$queue = Queue->new({ type => 'verification' });

is($queue->get_type(), 'verification', 'type was correctly set as verification');

require_ok ( 'QueueItem' );

done_testing();
