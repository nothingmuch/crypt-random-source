#!/usr/bin/perl

package Crypt::Random::Source::Base::Proc;
use Any::Moose;

extends qw(Crypt::Random::Source::Base::Handle);

use IO::Handle;

use 5.008;

has command => ( is => "rw", required => 1 );

sub open_handle {
	my $self = shift;

	my $cmd = $self->command;
	my @cmd = ref $cmd ? @$cmd : $cmd;

	open my $fh, "-|", @cmd
		or die "open(@cmd|): $!";

	bless $fh, "IO::Handle";

	return $fh;
}

__PACKAGE__

__END__

=pod

=head1 NAME

Crypt::Random::Source::Base::Proc - Base class for helper processes (e.g.
C<openssl>)

=head1 SYNOPSIS

	use Moose;

	extends qw(Crypt::Random::Source::Base::Proc);

	has '+command' => ( default => ... );

=head1 DESCRIPTION

This is a base class for using command line utilities which output random data
on STDOUT as L<Crypt::Random::Source> objects.

=head1 METHODS

=over 4

=item command

An array reference or string that is the command to run.

=back

=over 4

=item open_handle

Opens a pipe for reading using C<command>.

=back

=cut


