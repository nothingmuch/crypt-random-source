package Crypt::Random::Source::Base::Proc;
# ABSTRACT: Base class for helper processes (e.g. C<openssl>)

our $VERSION = '0.14';

use Moo;

extends qw(Crypt::Random::Source::Base::Handle);

use Capture::Tiny 0.08 qw(capture);
use File::Spec;
use IO::File 1.14;
use Types::Standard qw(Str);
use namespace::clean;

use 5.008;

has command => ( is => "rw", required => 1 );
has search_path => ( is => 'rw', isa => Str, lazy => 1, builder => 1);

# This is a scalar so that people can customize it (which they would
# particularly need to do on Windows).
our $TAINT_PATH =
    '/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin';

sub _build_search_path {
    # In taint mode it's not safe to use $ENV{PATH}.
    if (${^TAINT}) {
        return $TAINT_PATH;
    }
    return $ENV{PATH};
}

sub open_handle {
    my $self = shift;

    my $cmd = $self->command;
    my @cmd = ref $cmd ? @$cmd : $cmd;
    my $retval;
    local $ENV{PATH} = $self->search_path;
    my ($stdout, $stderr) = capture { $retval = system(@cmd) };
    chomp($stderr);
    if ($retval) {
        my $err = join(' ', @cmd) . ": $! ($?)";
        if ($stderr) {
            $err .= "\n$stderr";
        }
        die $err;
    }
    warn $stderr if $stderr;

    my $fh = IO::File->new(\$stdout, '<');

    return $fh;
}

1;
__END__

=pod

=head1 SYNOPSIS

    use Moo;
    extends qw(Crypt::Random::Source::Base::Proc);

    has '+command' => ( default => ... );

=head1 DESCRIPTION

This is a base class for using command line utilities which output random data
on STDOUT as L<Crypt::Random::Source> objects.

=attr command

An array reference or string that is the command to run.

=method open_handle

Opens a pipe for reading using C<command>.

=cut

# ex: set sw=4 et:
