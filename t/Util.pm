package t::Util;
use strict;
use warnings;
use utf8;

{
    package Bar;
    sub new {
        my ($class, $args) = @_;
        bless {%$args}, $class;
    }
    sub name { $_[0]->{name} }
}

{
    package Foo;
    sub new {
        my $class = shift;
        bless {@_}, $class;
    }
    sub bar { $_[0]->{bar} }
}

1;

