package QueueItem;

use warnings;
use strict;

use Data::Dumper;

sub new {
    my ($class, $args) = @_;

    my $self = bless({
        type => $args->{'type'} || 'default',
        relevant_id => $args->{'relevant_id'} || undef, 
    });

    return $self;
}

sub get_type { shift->{'type'} }
sub get_id { shift->{'relevant_id'} }

sub flags {
    my $self = shift;
    return $self->_get_flags($self->get_id);
}
sub has_flag {
    my $self = shift;
    my $flag = shift;
    return defined $self->flags->{$flag};
}

sub can_assign {
    my $self = shift;
    return $self->has_flag('claimed') ? 0 : 1;
}

sub _get_flags {
    my $self = shift;
    my $id   = shift;
    my $flags = {
        1 => {
            claimed => 'matt',
            viewing => 'matt',
            attempt_1 => 'uncontacted',
        },
        2 => {
            claimed => 'jvp',
            attempt_1 => 'uncontacted',
        },
        3 => {
            viewing => 'joe',
            attempt_1 => 'uncontacted',
        },  
        4 => {
            attempt_1 => 'attempted',
            attempt_2 => 'uncontacted',
        },
        5 => {
            attempt_1 => 'attempted',
            attempt_2 => 'attempted',
            attempt_3 => 'uncontacted',
        },
    };
    return $flags->{$id};
}

1;
