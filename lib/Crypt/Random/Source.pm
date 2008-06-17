#!/usr/bin/perl

package Crypt::Random::Source;

use strict;
use warnings;

use Sub::Exporter -setup => {
	exports  => [qw(
		get get_weak get_strong
		factory
	)],
	groups => { default => [qw(get get_weak get_strong)] },
};

our $VERSION = "0.03";

use Crypt::Random::Source::Factory;

our ( $factory, $weak, $strong, $any );

# silence some stupid destructor warnings
END { undef $weak; undef $strong; undef $any; undef $factory }

sub factory    ()    { $factory ||= Crypt::Random::Source::Factory->new }
sub _weak      ()    { $weak    ||= factory->get_weak }
sub _strong    ()    { $strong  ||= factory->get_strong }
sub _any       ()    { $any     ||= factory->get }

sub get        ($;@) {    _any->get(@_) }
sub get_weak   ($;@) {   _weak->get(@_) }
sub get_strong ($;@) { _strong->get(@_) }

# silence some stupid destructor warnings
END { undef $weak; undef $strong; undef $any; undef $factory }

__PACKAGE__

__END__

=pod

=head1 NAME

Crypt::Random::Source - Get random weak or strong random data.

=head1 SYNOPSIS

	use Crypt::Random::Source qw(get_strong);

	# get 10 cryptographically strong random bytes from an available source
	my $bytes = get_strong(10);

=head1 DESCRIPTION

This module provides implementations for a number of byte oriented sources of
random data.

See L<Crypt::Random::Source::Factory> for a more powerful way to locate
sources, and the various sources for specific implementations.

=head1 EXPORTS

=over 4

=item get

=item get_weak

=item get_strong

These functions delegate to a source chosen by an instance of
L<Crypt::Random::Source::Factory>, calling get

=back

=head1 SEE ALSO

L<Crypt::Random>, L<Crypt::Util>

=head1 VERSION CONTROL

This module is maintained using Darcs. You can get the latest version from
L<http://nothingmuch.woobling.org/code>, and use C<darcs send> to commit
changes.

=head1 AUTHOR

Yuval Kogman E<lt>nothingmuch@woobling.orgE<gt>

=head1 COPYRIGHT

	Copyright (c) 2008 Yuval Kogman. All rights reserved
	This program is free software; you can redistribute
	it and/or modify it under the same terms as Perl itself.

=cut
