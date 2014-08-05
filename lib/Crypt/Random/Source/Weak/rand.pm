package Crypt::Random::Source::Weak::rand;
# ABSTRACT: Use C<rand> to create random bytes

use Any::Moose;

use bytes;

extends qw(
    Crypt::Random::Source::Weak
    Crypt::Random::Source::Base
);

sub rank { -100 } # slow fallback

sub available { 1 }

sub seed {
    my ( $self, @args ) = @_;
    srand( unpack("%L*", @args) );
}

sub get {
    my ( $self, $n ) = @_;
    pack "C*", map { int rand 256 } 1 .. $n;
}

1;
__END__

=pod

=head1 SYNOPSIS

    use Crypt::Random::Source::Weak::rand;

    my $p = Crypt::Random::Source::Weak::rand->new;

    $p->get(1024);

=head1 DESCRIPTION

This is a weak source of random data, that uses Perl's builtin C<rand>
function.

=method seed @blah

Sets the random seed to a checksum of the stringified values of C<@blah>.

There is no need to call this method unless you want the random sequence to be
identical to a previously run, in which case you should seed with the same
value.

=method get $n

Produces C<$n> random bytes.

=cut

# ex: set sw=4 et:
