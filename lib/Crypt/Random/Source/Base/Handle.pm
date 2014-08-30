package Crypt::Random::Source::Base::Handle;
# ABSTRACT: L<IO::Handle> based random data sources

use Any::Moose;

use Errno qw(EWOULDBLOCK);

use Carp qw(croak);
use IO::Handle;
use namespace::autoclean;

extends qw(Crypt::Random::Source::Base);

has allow_under_read => (
    isa => "Bool",
    is  => "rw",
    default => 0,
);

has reread_attempts => (
    is => "rw",
    default => 1,
);

has handle => (
    is => "rw",
    predicate  => "has_handle",
    clearer    => "clear_handle",
    lazy_build => 1,
);

sub blocking { shift->handle->blocking(@_) }
sub read { shift->handle->read(@_) }
sub opened { shift->handle->opened(@_) }

sub DEMOLISH {
    my $self = shift;
    $self->close;
}

sub _build_handle {
    my ( $self, @args ) = @_;
    $self->open_handle;
}

sub open_handle {
    die "open_handle is an abstract method";
}

sub get {
    my ( $self, $n, @args ) = @_;

    croak "How many bytes would you like to read?" unless $n;

    return $self->_read($self->handle, $n, @args);
}

sub _read {
    my ( $self, $handle, $n, @args) = @_;

    my $buf;
    my $got = $self->read($buf, $n);

    if ( defined($got) && $got == $n || $! == EWOULDBLOCK ) {
        return $buf;
    } else {
        croak "read error: $!" unless defined $got;
        return $self->_read_too_short($buf, $got, $n, @args);
    }
}

sub _read_too_short {
    my ( $self, $buf, $got, $req, %args ) = @_;

    if ( $self->allow_under_read ) {
        return $buf;
    } else {
        if ( ($self->reread_attempts || 0) >= ($args{reread_attempt} || 0) ) {
            croak "Source failed to read enough bytes (requested $req, got $got)";
        } else {
            return $buf . $self->_read( $req - $got, reread_attempt => 1 + ( $args{reread_attempt} || 0 ) );
        }
    }
}

sub close {
    my $self = shift;

        # During global destruction, $self->handle can be undef already,
        # so we need to also check if it is defined.
    if ( $self->has_handle and $self->handle ) {
        $self->handle->close; # or die "close: $!"; # open "-|" returns exit status on close
        $self->clear_handle;
    }
}

1;
__END__

=pod

=head1 SYNOPSIS

    use Moose;
    extends qw(Crypt::Random::Source::Base::Handle);

    sub open_handle {
        # invoked as needed
    }


    # this class can also be used directly
    Crypt::Random::Source::Base::Handle->new( handle => $file_handle );


    # it supports some standard methods:

    $p->blocking(0);

    $p->read( my $buf, $n ); # no error handling here

=head1 DESCRIPTION

This is a concrete base class for all L<IO::Handle> based random data sources.

It implements error handling

=attr handle

An L<IO::Handle> or file handle to read from.

=attr blocking

This is actually handled by C<handle>, and is documented in L<IO::Handle>.

=attr allow_under_read

Whether or not under reading is considered an error.

Defaults to false.

=attr reread_attempts

The number of attempts to make at rereading if the handle did not provide
enough bytes on the first attempt.

Defaults to 1.

Only used if C<allow_under_read> is enabled.

=method get

See L<Crypt::Random::Source::Base/get>.

When C<blocking> or C<allow_under_read> are set to a true value this method may
return fewer bytes than requested.

=method read

This delegates directly to C<handle>.

It B<DOES NOT> provide the same validation as C<get> would have, so no checking
for underreads is done.

=method close

Close the handle and clear it.

=method _read

C<< $self->handle->read >> but with additional error checking and different
calling conventions.

=method _read_too_short

Called by C<_read> when not enough data was read from the handle. Normally it
will either die with an error or attempt to reread. When C<allow_under_read> is
true it will just return the partial buffer.

=method open_handle

Abstract method, should return an L<IO::Handle> to use.

=cut

# ex: set sw=4 et:
