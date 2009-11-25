#!/usr/bin/perl

package Crypt::Random::Source::Weak;
use Moose;

sub is_strong { 0 }

__PACKAGE__

__END__

=pod

=head1 NAME

Crypt::Random::Source::Weak - Abstract base class for weak random data
sources

=head1 SYNOPSIS

	use Moose;

	extends qw(Crypt::Random::Source::Weak);

=head1 DESCRIPTION

This is an abstract base class. There isn't much to describe.

=head1 METHODS

=over 4

=item is_strong

Returns false

=back

=cut

