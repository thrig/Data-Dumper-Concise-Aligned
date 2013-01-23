#!perl

use strict;
use warnings;

use Test::More tests => 2;
BEGIN { use_ok('Data::Dumper::Concise::Compact') }

can_ok( 'Data::Dumper::Concise::Compact', qw/DumperC DumperObject/ );
