package Crypt::Random::Source::Base::File;
# ABSTRACT: File (or device) random data sources

use Any::Moose;

use Carp qw(croak);

extends qw(Crypt::Random::Source::Base::Handle);

use IO::File;

has path => (
	is => "rw",
	required => 1,
);

sub open_handle {
	my ( $self, $mode ) = @_;

	my $file = $self->path;

	my $fh = IO::File->new;

	$fh->open($file, $mode || "r")
		or croak "open($file): $!";

	return $fh;
}

1;

=head1 SYNOPSIS

	use Moose;
	extends qw(Crypt::Random::Source::Base::File);

	has '+path' => (
		default => "/foo/bar",
	);

=head1 DESCRIPTION

This is a base class for file (or file like) random data sources.

=attr path

A required attribute, the path to the file to open.

=method open_handle

Uses L<IO::File> to open C<path> for reading.

=cut
