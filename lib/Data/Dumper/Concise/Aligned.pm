package Data::Dumper::Concise::Aligned;

use 5.010000;
use strict;
use warnings;
use Scalar::Util qw/reftype/;
use Text::Wrap qw/wrap/;

our $VERSION = '0.24';
our @ISA;

require Exporter;
require Data::Dumper;

BEGIN { @ISA = qw/Exporter/ }
our @EXPORT = qw/DumperA DumperObjectA/;

sub DumperObjectA {
  my $dd = Data::Dumper->new( [] );
  $dd->Terse(1)->Indent(0)->Useqq(1)->Deparse(1)->Quotekeys(0)->Sortkeys(1);
}

sub DumperA {
  my $str_buf;
  my $prefix = '';
  for my $o (@_) {
    if ( defined reftype $o) {
      $str_buf .=
        wrap( $prefix, $prefix, DumperObjectA->Values( [$o] )->Dump ) . "\n";
    } else {
      $prefix = $o;
      $prefix .= ' ' unless $prefix =~ m/\s$/;
    }
  }
  return $str_buf;
}

1;
__END__

=head1 NAME

Data::Dumper::Concise::Aligned - even less indentation plus string prefix

=head1 SYNOPSIS

  use Data::Dumper::Concise::Aligned;
  warn DumperA This => \@something, That => \@otherthing;

=head1 DESCRIPTION

Like L<Data::Dumper::Concise> except with even less indentation, and
string prefixing of the wrapped-as-necessary output. Used in particular
to look at data that needs to be shown in as compact a manner as
possible for easy vertical comparison, for example:

  S [[2,2,1,2,2,2,1],[1,2,2,2,1,2,2]]
  D [[2,1,2,2,2,2,1],[2,2,1,2,2,1,2]]

This could possibly be done via C<DumperF> of
L<Data::Dumper::Concise>, but that's more typing, and not exactly the
string prefix handling I wanted.

In C<vi> type editors, an C<ab> configuration along the lines of the
following can expand out to include the desired Dumper routine:

  ab PUDD use Data::Dumper::Concise; warn Dumper
  ab PUCC use Data::Dumper::Concise::Aligned; warn DumperA

=head1 AUTHOR

thrig - Jeremy Mates (cpan:JMATES) C<< <jmates at cpan.org> >>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2013,2015 by Jeremy Mates

This module is free software; you can redistribute it and/or modify it
under the Artistic License (2.0).

=cut
