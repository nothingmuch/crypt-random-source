#!/usr/bin/perl

package Crypt::Random::Source::Weak::devurandom;
use Squirrel;

extends qw(
	Crypt::Random::Source::Weak
	Crypt::Random::Source::Base::RandomDevice
);

has path => (
	is => "rw",
	default => "/dev/urandom",
);

__PACKAGE__

__END__

=pod

=head1 NAME

Crypt::Random::Source::Weak::devurandom - 

=head1 SYNOPSIS

	use Crypt::Random::Source::Weak::devurandom;

=head1 DESCRIPTION

=cut


