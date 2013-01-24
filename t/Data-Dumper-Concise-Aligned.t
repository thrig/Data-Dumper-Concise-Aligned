#!perl

use strict;
use warnings;

use Test::More tests => 3;
BEGIN { use_ok('Data::Dumper::Concise::Aligned') }

can_ok( 'Data::Dumper::Concise::Aligned', qw/DumperA DumperObjectA/ );

my @intervals = ( [ 2, 2, 1, 2, 2, 2, 1 ], [ 1, 2, 2, 2, 1, 2, 2 ] );
is(
  DumperA( M => \@intervals ),
  "M [[2,2,1,2,2,2,1],[1,2,2,2,1,2,2]]\n",
  'prefixed output'
);
