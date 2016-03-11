package Crypt::Random::Source::Strong;
# ABSTRACT: Abstract base class for strong random data sources

our $VERSION = '0.13';

use Moo;
use namespace::clean;

sub is_strong { 1 }

1;
__END__

=pod

=head1 SYNOPSIS

    use Moo;
    extends qw(Crypt::Random::Source::Strong);

=head1 DESCRIPTION

This is an abstract base class. There isn't much to describe.

=method is_strong

Returns true

=cut

# ex: set sw=4 et:
