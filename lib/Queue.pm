package Queue;

use warnings;
use strict;

sub new {
    my ($class, $args) = shift;
    my $self = bless({
        type => $args->{'type'} || 'default',
    });

    return $self;
}

1;
