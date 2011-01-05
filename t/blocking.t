#!/usr/bin/perl

use strict;
use warnings;

use Test::More 'no_plan';

use 5.008;

use IO::Handle;
use IO::Select;

use ok 'Crypt::Random::Source::Base::Handle';

{
    my ( $reader, $writer ) = map { IO::Handle->new } 1 .. 2;

    defined ( my $child = open my $fh, "-|" ) or die "open: $!";

    if ($child) {
        my $p = Crypt::Random::Source::Base::Handle->new( handle => $fh );

        $p->blocking(0);

        if ( IO::Select->new( $fh )->can_read(1) ) {
            is( $p->get(5), "foo", "underread due to blocking" );
            is( $p->get(5), '', "underread due to blocking" );
        }

        kill TERM => $child;
    } else {
        STDOUT->autoflush(1);

        print "foo";

        sleep 10;

        print "bar";

        exit;
    }
}

# ex: set sw=4 et:
