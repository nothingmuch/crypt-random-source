package Crypt::Random::Source::Base::RandomDevice;
# ABSTRACT: Base class for random devices

our $VERSION = '0.11';

use Any::Moose;

extends qw(Crypt::Random::Source::Base::File);
use namespace::autoclean;

sub rank { 100 } # good quality, pretty fast

has '+path' => (
    builder => "default_path",
);

sub available {
    -r shift->default_path;
}

sub seed {
    my ( $self, @args ) = @_;

    my $fh = $self->open_handle("w+");

    print $fh @args;

    close $fh;
}

sub default_path {
    die "abstract";
}

1;
__END__

=pod

=head1 SYNOPSIS

    use Moose;

    extends qw(Crypt::Random::Source::Base::RandomDevice);

    sub default_path { "/dev/myrandom" }

=head1 DESCRIPTION

This is a base class for random device sources.

See L<Crypt::Random::Source::Strong::devrandom> and
L<Crypt::Random::Source::Weak::devurandom> for actual implementations.

=cut

# ex: set sw=4 et:
