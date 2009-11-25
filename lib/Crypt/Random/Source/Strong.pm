#!/usr/bin/perl

package Crypt::Random::Source::Strong;
use Moose;

sub is_strong { 1 }

__PACKAGE__

__END__

=pod

=head1 NAME

Crypt::Random::Source::Strong - Abstract base class for strong random data
sources

=head1 SYNOPSIS

	use Moose;

	extends qw(Crypt::Random::Source::Strong);

=head1 DESCRIPTION

This is an abstract base class. There isn't much to describe.

=head1 METHODS

=over 4

=item is_strong

Returns true

=back

=cut

