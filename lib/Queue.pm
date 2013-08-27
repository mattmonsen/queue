package Queue;

use warnings;
use strict;

use FindBin;
use lib "$FindBin::Bin/../lib";

use Data::Dumper;
use QueueItem;
use feature 'say';

sub new {
    my ($class, $args) = @_;
    my $self = bless({
        type => $args->{'type'} || 'default',
    });

    $self->init();

    return $self;
}

sub init {
    my $self = shift;
    my $ids = $self->get_ids;
    for my $id (@$ids) {
        push @{ $self->{'queue'} }, QueueItem->new({ type => $self->get_type, relevant_id => $id });
    }
}

sub dequeue {
    my $self = shift;
    return shift @{ $self->{'queue'} };
}

sub enqueue {
    my $self       = shift;
    my $queue_item = shift;
    $queue_item = QueueItem->new({ type => $self->get_type, relevant_id => $queue_item }) unless ref $queue_item eq 'QueueItem';
    push @{ $self->{'queue'} }, $queue_item;
    return 1;
}

sub size { scalar @{ shift->{'queue'} } }

sub get_type {
    my $self = shift;
    return $self->{'type'};
}

sub get_ids {
    my $self = shift;
    my $type = $self->get_type;
    return $self->_ids_by_type->{$type};
}

sub _ids_by_type {
    my $self = shift;
    return {
        test         => [1, 2, 3],
        verification => [4, 5],
    };        
}

1;
