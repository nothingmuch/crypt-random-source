#!/usr/bin/perl

package Crypt::Random::Source::Weak::devurandom;
use Any::Moose;

extends qw(
	Crypt::Random::Source::Weak
	Crypt::Random::Source::Base::RandomDevice
);

sub default_path { "/dev/urandom" }

__PACKAGE__

__END__

=pod

=head1 NAME

Crypt::Random::Source::Weak::devurandom - 

=head1 SYNOPSIS

	use Crypt::Random::Source::Weak::devurandom;

=head1 DESCRIPTION

=cut


