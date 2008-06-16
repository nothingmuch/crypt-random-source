#!/usr/bin/perl

package Crypt::Random::Source::Base;
use Squirrel;

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

__PACKAGE__

__END__

=pod

=head1 NAME

Crypt::Random::Source::Base - Abstract base class for
L<Crypt::Random::Source> classes.

=head1 SYNOPSIS

	use Squirrel;
	extends qw(Crypt::Random::Source::Base);

=head1 DESCRIPTION

This is an abstract base class.

In the future it will be a role.

=head1 METHODS

=over 4

=item get $n, %args

Gets C<$n> random bytes and returns them as a string.

This method may produce fatal errors if the source was unable to provide enough
data.

=item read $buf, $n, [ $off ]

This method is cannibalized from L<IO::Scalar>. It provides an L<IO::Handle>
work-alike.

Note that subclasses override this to operate on a real handle directly if
available.

=back

=cut


