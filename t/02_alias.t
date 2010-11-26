use strict;
use warnings;
use Test::More;
use t::Util;

{
    package MyApp;
    use Class::Mixin::Container 'register', 'get' => { -as => 'component' };
    sub new {
        my $class = shift;
        bless {@_}, $class;
    }
    __PACKAGE__->register("Bar1" => sub {
        my $self = shift;
        Bar->new(+{name => "Bar1"});
    });
    __PACKAGE__->register("Foo1" => sub {
        my $self = shift;
        Foo->new(bar => $self->component('Bar1'));
    });
}

my $app = MyApp->new();
my $foo = $app->component("Foo1");
isa_ok $foo, 'Foo';
isa_ok $foo->bar, 'Bar';
is $foo->bar->name, "Bar1";

done_testing;

