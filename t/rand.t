use strict;
use warnings;

use Test::More 'no_plan';

use ok 'Crypt::Random::Source::Weak::rand';

{
    ok( Crypt::Random::Source::Weak::rand->available, "rand is always available" );

    my $p = Crypt::Random::Source::Weak::rand->new;

    isa_ok( $p, "Crypt::Random::Source::Weak::rand" );
    isa_ok( $p, "Crypt::Random::Source::Weak" );

    my $buf = $p->get(1000);

    is( length($buf), 1000, "got 1000 bytes" );

    cmp_ok( $buf, "ne", $p->get(length($buf)), "not equal to more randomness" );
}

# ex: set sw=4 et:
