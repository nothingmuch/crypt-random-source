#!/usr/bin/perl

package Crypt::Random::Source::Strong::devrandom;
use Squirrel;

extends qw(
	Crypt::Random::Source::Strong
	Crypt::Random::Source::Base::RandomDevice
);


sub default_path { "/dev/random" }

__PACKAGE__

__END__

=pod

=head1 NAME

Crypt::Random::Source::Strong::devrandom - 

=head1 SYNOPSIS

	use Crypt::Random::Source::Strong::devrandom;

=head1 DESCRIPTION

=cut


