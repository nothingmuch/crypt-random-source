package Crypt::Random::Source::Strong;
# ABSTRACT: Abstract base class for strong random data sources

use Any::Moose;

sub is_strong { 1 }

1;

=head1 SYNOPSIS

	use Moose;

	extends qw(Crypt::Random::Source::Strong);

=head1 DESCRIPTION

This is an abstract base class. There isn't much to describe.

=method is_strong

Returns true

=cut
