use strict;
use inc::Module::Install;

all_from 'lib/Crypt/Random/Source.pm';
repository 'https://github.com/nothingmuch/crypt-random-source';

test_requires 'Test::use::ok' => 0;
test_requires 'Test::Exception' => 0;

requires 'Any::Moose' => 0.11;
requires 'namespace::clean' => '0.08';
requires 'Module::Find' => 0;
requires 'Sub::Exporter' => 0;

makemaker_args(
    dist => { PREOP => 'pod2text lib/Crypt/Random/Source.pm > README' },
);

WriteAll;
