package Crypt::Random::Source;
# ABSTRACT: Get weak or strong random data from pluggable sources

our $VERSION = '0.12';

use strict;
use 5.008;
use warnings;

use Sub::Exporter -setup => {
    exports  => [qw(
        get get_weak get_strong
        factory
    )],
    groups => { default => [qw(get get_weak get_strong)] },
};

use Crypt::Random::Source::Factory;

our ( $factory, $weak, $strong, $any );

# silence some stupid destructor warnings
END { undef $weak; undef $strong; undef $any; undef $factory }

sub factory    ()    { $factory ||= Crypt::Random::Source::Factory->new }
sub _weak      ()    { $weak    ||= factory->get_weak }
sub _strong    ()    { $strong  ||= factory->get_strong }
sub _any       ()    { $any     ||= factory->get }

sub get        ($;@) {    _any->get(@_) }
sub get_weak   ($;@) {   _weak->get(@_) }
sub get_strong ($;@) { _strong->get(@_) }

# silence some stupid destructor warnings
END { undef $weak; undef $strong; undef $any; undef $factory }

1;
__END__

=pod

=head1 SYNOPSIS

    use Crypt::Random::Source qw(get_strong);

    # get 10 cryptographically strong random bytes from an available source
    my $bytes = get_strong(10);

=head1 DESCRIPTION

This module provides implementations for a number of byte oriented sources of
random data.

See L<Crypt::Random::Source::Factory> for a more powerful way to locate
sources, and the various sources for specific implementations.

=head1 EXPORTS

=over 4

=item get

=item get_weak

=item get_strong

These functions delegate to a source chosen by an instance of
L<Crypt::Random::Source::Factory>, calling get

=back

=head1 SEE ALSO

L<Crypt::Random>, L<Crypt::Util>

=cut

# ex: set sw=4 et
