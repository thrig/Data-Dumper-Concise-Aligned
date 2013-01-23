package Data::Dumper::Concise::Compact;

use 5.010000;
use Scalar::Util qw/reftype/;
use Text::Wrap qw/wrap/;

our $VERSION = '0.01';

BEGIN { @ISA = qw(Exporter) }
@EXPORT = qw(Dumper DumperObject);

sub DumperObject {
  my $dd = Data::Dumper->new( [] );
  $dd->Terse(1)->Indent(0)->Useqq(1)->Deparse(1)->Quotekeys(0)->Sortkeys(1);
}

{
  my $prefix = '';

  sub Dumper {
    my $str_buf;
    for my $o (@_) {
      if ( defined reftype $o) {
        $str_buf .=
          wrap( $prefix, $prefix, DumperObject->Values( [$o] )->Dump ) . "\n";
      } else {
        $prefix = $o;
        $prefix .= ' ' unless $prefix =~ m/\s$/;
      }
    }
    return $str_buf;
  }
}

1;
__END__

=head1 NAME

Data::Dumper::Concise::Compact - Even less indentation and string passing

=head1 SYNOPSIS

  use Data::Dumper::Concise::Compact;
  warn Dumper "This", \@something, "That", \@otherthing;

=head1 DESCRIPTION

Like L<Data::Dumper::Concise> except with even less indentation, and
string passing such that strings are printed with a trailing space, and
each other object passed is printed with a trailing newline. Used in
particular to look at data that needs to be shown in as compact a manner
as possible for easy vertical comparison, hence C<Indent(0)>:

  S [[2,2,1,2,2,2,1],[1,2,2,2,1,2,2]]
  D [[2,1,2,2,2,2,1],[2,2,1,2,2,1,2]]

Could possibly be done via C<DumperF> of L<Data::Dumper::Concise>, but
that's more typing, and not exactly the string vs. record newline
handling I wanted.

=head1 AUTHOR

Jeremy Mates, E<lt>jmates@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2013 by Jeremy Mates

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.16.1 or,
at your option, any later version of Perl 5 you may have available.

=cut
