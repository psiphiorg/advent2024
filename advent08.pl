#!perl

use strict;

my @a;
my %c;

my $row = 0;
while (<>) {
  chomp;
  my $col = 0;
  foreach my $a (split //) {
    $a[$row][$col] = $a;
    if ($a ne ".") {
      push @{$c{$a}}, [$row, $col];
    }
    $col++;
  }
  $row++;
}

my $l = $#a;

my %antinode1;
my %antinode2;

foreach my $key (keys %c) {
  my @b = @{$c{$key}};
  foreach my $x (0..$#b) {
    my ($x0, $x1) = ($b[$x][0], $b[$x][1]);
    $antinode2{"$x0, $x1"}++;
    foreach my $y (0..$#b) {
      next if $x == $y;
      my ($y0, $y1) = ($b[$y][0], $b[$y][1]);
      my ($z0, $z1) = ($x0*2-$y0, $x1*2-$y1);
      next if ($z0 < 0 or $z1 < 0 or $z0 > $l or $z1 > $l);
      $antinode1{"$z0, $z1"}++;
      $antinode2{"$z0, $z1"}++;
      while (1) {
        ($z0, $z1) = ($z0 + $x0 - $y0, $z1 + $x1 - $y1);
        last if ($z0 < 0 or $z1 < 0 or $z0 > $l or $z1 > $l);
        $antinode2{"$z0, $z1"}++;
      }
    }
  }
}

my @c = keys %antinode1;
print "Part 1: ", (scalar @c), "\n";

@c = keys %antinode2;
print "Part 2: ", (scalar @c), "\n";
