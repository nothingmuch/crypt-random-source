package Crypt::Random::Source::Strong::devrandom;
# ABSTRACT: A strong random data source using F</dev/random>

our $VERSION = '0.13';

use Moo;

extends qw(
    Crypt::Random::Source::Strong
    Crypt::Random::Source::Base::RandomDevice
);

use namespace::clean;

sub default_path { "/dev/random" }

1;
__END__

=pod

=head1 SYNOPSIS

    use Crypt::Random::Source::Strong::devrandom;

=cut

# ex: set sw=4 et:
