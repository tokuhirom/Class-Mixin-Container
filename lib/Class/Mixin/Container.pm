package Class::Mixin::Container;
use strict;
use warnings;
use 5.008001;
our $VERSION = '0.01';
use Sub::Exporter -setup => {
    exports => [
        qw/register get/
    ],
};
use Scalar::Util ();
use Carp         ();

my $MAP;

# class method
sub register {
    my ($class, $name, $code) = @_;
    $MAP->{$class}->{$name} = $code;
}

# instance method
sub get {
    my ($self, $name) = @_;
    if (my $code = $MAP->{ref($self)}->{$name}) {  # from class
        return $code->($self);
    } else {
        Carp::croak("$name is not registereed for " . ref($self));
    }
}

1;
__END__

=encoding utf8

=head1 NAME

Class::Mixin::Container - Minimalistic container mixin

=head1 SYNOPSIS

    # make your container class
    package MyApp;
    use Class::Mixin::Container qw/register get/;

    sub new {
        my $class = shift;
        my %args = @_ == 1 ? %{$_[0]}  : @_;
        bless { %args }, $class;
    }

    __PACKAGE__->register(cookie_jar => sub {
        $self->cookie_jar
    });

    __PACKAGE__->register('LWP::UserAgent' => sub {
        my $self = shift;
        LWP::UserAgent->new(cookie_jar => $self->cookie_jar);
    });

    # in your application
    package main;

    my $container = MyApp->new;
    my $ua = $container->get('LWP::UserAgent');

=head1 DESCRIPTION

Class::Mixin::Container is a minimalistic container stuff.

This module is Mixin class.

It is useful to create web application framework.

=head1 COOKBOOK

=head2 HOW DO YOU USE SINGLETON?

The great L<Class::Singleton> is available on CPAN.

    package MyApp;
    use base qw/Class::Singleton/;
    use Class::Mixin::Container qw/register get/;

    sub _new_instance { bless { }, shift }

    package main;
    
    my $app = MyApp->instance;
    $app->register('Foo' => sub { Foo->new });
    ...
    my $foo = $app->get('Foo');

=head2 HOW DO YOU RESOLVE METHOD NAME CONFLICTION?

You can alias to import the method name.

    use Class::Mixin::Container 'register', 'get' => { -as => 'component' };

For more details, please look the L<Sub::Exporter> documents.

=head1 AUTHOR

Tokuhiro Matsuno E<lt>tokuhirom AAJKLFJEF GMAIL COME<gt>

=head1 SEE ALSO

=head1 LICENSE

Copyright (C) Tokuhiro Matsuno

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
