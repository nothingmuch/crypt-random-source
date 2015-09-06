package Crypt::Random::Source::Strong;
# ABSTRACT: Abstract base class for strong random data sources

our $VERSION = '0.11';

use Any::Moose;
use namespace::autoclean;

sub is_strong { 1 }

1;
__END__

=pod

=head1 SYNOPSIS

    use Moose;

    extends qw(Crypt::Random::Source::Strong);

=head1 DESCRIPTION

This is an abstract base class. There isn't much to describe.

=method is_strong

Returns true

=cut

# ex: set sw=4 et:
