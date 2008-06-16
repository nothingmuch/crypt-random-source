#!/usr/bin/perl -w

use strict;

use ExtUtils::MakeMaker;

require 5.008;

WriteMakefile(
	NAME         => '',
	VERSION_FROM => '',
	INSTALLDIRS  => 'site',
	SIGN         => 1,
	PL_FILES     => { },
	PREREQ_PM    => {
		'Test::use::ok' => 0,
	},
);

