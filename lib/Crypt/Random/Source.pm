#!/usr/bin/perl

package Crypt::Random::Source;

use strict;
use warnings;

our $VERSION = "0.01_01";

__PACKAGE__

__END__

=pod

=head1 NAME

Crypt::Random::Source - Get random weak or strong random data.

=head1 SYNOPSIS

	use Crypt::Random::Source;

=head1 DESCRIPTION

This module provides implementations for a number of byte oriented sources of
random data.

It will also provide a factory with fallback support and an easy api before
0.01.

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
