#!/usr/bin/perl

package Crypt::Random::Source::Weak::rand;
use Squirrel;

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

__PACKAGE__

__END__

=pod

=head1 NAME

Crypt::Random::Source::Weak::rand - Use C<rand> to create random bytes.

=head1 SYNOPSIS

	use Crypt::Random::Source::Weak::rand;

	my $p = Crypt::Random::Source::Weak::rand->new;

	$p->get(1024);

=head1 DESCRIPTION

This is a weak source of random data, that uses Perl's builtin C<rand>
function.

=head1 METHODS

=over 4

=item seed @blah

Sets the random seed to a checksum of the stringified values of C<@blah>.

There is no need to call this method unless you want the random sequence to be
identical to a previously run, in which case you should seed with the same
value.

=item get $n

Produces C<$n> random bytes.

=back

=cut


