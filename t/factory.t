#!/usr/bin/perl

use strict;
use warnings;

use Test::More 'no_plan';

use ok 'Crypt::Random::Source::Factory';

{
    my $f = Crypt::Random::Source::Factory->new;

    ok( $f->weak_source, "got a weak source" );

    ok( !$f->weak_source->is_strong, "weak is weak" );

    isa_ok( $f->get_weak, "Crypt::Random::Source::Weak" );

    SKIP: {
        skip "need a strong source", 2
            unless eval {
                require Crypt::Random::Source::Strong::devrandom;
                Crypt::Random::Source::Strong::devrandom->available;
            };

        ok( $f->strong_source, "got a strong source" );
        isa_ok( $f->get_strong, "Crypt::Random::Source::Strong" );
    }

    isa_ok( $f->get, "Crypt::Random::Source::Base" );
}

# ex: set sw=4 et:
