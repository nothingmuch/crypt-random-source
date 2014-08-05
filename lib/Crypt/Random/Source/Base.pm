package Crypt::Random::Source::Base;
# ABSTRACT: Abstract base class for L<Crypt::Random::Source> classes

use Any::Moose;

sub available { 0 }

sub rank { 0 }

sub seed { }

sub get { die "abstract" }

# cannibalized from IO::Scalar
sub read {
    my $self = $_[0];
    my $n    = $_[2];
    my $off  = $_[3] || 0;

    my $read = $self->get($n);
    $n = length($read);
    ($off ? substr($_[1], $off) : $_[1]) = $read;
    return $n;
}

sub get_data {
    my ( $self, %params ) = @_;

    if ( my $n = $params{Length} ) {
        return $self->get($n);
    } else {
        my $size = $params{Size};

        if (ref $size && ref $size eq "Math::Pari") {
            $size = Math::Pari::pari2num($size);
        }

        return $self->get( int($size / 8) + 1 );
    }
}

1;
__END__

=pod

=head1 SYNOPSIS

    use Moose;
    extends qw(Crypt::Random::Source::Base);

=head1 DESCRIPTION

This is an abstract base class.

In the future it will be a role.

=method get $n, %args

Gets C<$n> random bytes and returns them as a string.

This method may produce fatal errors if the source was unable to provide enough
data.

=method read $buf, $n, [ $off ]

This method is cannibalized from L<IO::Scalar>. It provides an L<IO::Handle>
work-alike.

Note that subclasses override this to operate on a real handle directly if
available.

=method seed @stuff

On supporting sources this method will add C<@stuff>, whatever it may be, to
the random seed.

Some sources may not support this, so be careful.

=method available

This is a class method, such that when it returns true calling C<new> without
arguments on the class should provide a working source of random data.

This is use by L<Crypt::Random::Source::Factory>.

=method rank

This is a class method, with some futz value for a ranking, to help known good
sources be tried before known bad (slower, less available) sources.

=method get_data %Params

Provided for compatibility with L<Crypt::Random>

=cut

# ex: set sw=4 et:
