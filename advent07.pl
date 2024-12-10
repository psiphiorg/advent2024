#!perl

my $total1 = 0;
my $total2 = 0;

while (<>) {
  chomp;
  my ($a, $b) = /^(\d+): (.*)$/;
  my @l = split / /, $b;

  $total1 += $a if canCalc1($a, @l);
  $total2 += $a if canCalc2($a, @l);
}

print "Part 1: $total1\nPart 2: $total2\n";

sub canCalc1($@) {
  my ($a, @l) = @_;
  my @prev = ();
  my @curr = ();
  foreach my $x (@l) {
    if (!@prev) {
      push @curr, $x;
    } else {
      foreach my $y (@prev) {
        push @curr, $x+$y, $x*$y;
      }
    }
    @prev = sort @curr;
    @curr = ();
  }
  foreach (@prev) {
    if ($_ == $a) {
      return 1;
    }
  }
  return 0;
}

sub canCalc2($@) {
  my ($a, @l) = @_;
  my @prev = ();
  my @curr = ();
  foreach my $x (@l) {
    if (!@prev) {
      push @curr, $x;
    } else {
      foreach my $y (@prev) {
        push @curr, $y+$x, $y*$x, $y.$x;
      }
    }
    @prev = sort @curr;
    @curr = ();
  }
  foreach (@prev) {
    if ($_ == $a) {
      return 1;
    }
  }
  return 0;
}
