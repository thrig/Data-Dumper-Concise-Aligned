#!perl

use strict;
use warnings;

use Test::More tests => 2;
BEGIN { use_ok('Data::Dumper::Concise::Aligned') }

can_ok( 'Data::Dumper::Concise::Aligned', qw/DumperA DumperObject/ );
