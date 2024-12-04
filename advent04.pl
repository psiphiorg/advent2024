#!perl

my @a;

my $row = 0;
while (<>) {
  chomp;
  my $col = 0;
  foreach my $a (split //) {
    $a[$row][$col] = $a;
    $col++;
  }
  $row++;
}

my $total1 = count1(@a);
my $total2 = count2(@a);

print "Part 1: $total1\nPart 2: $total2\n";

sub count1(@) {
  my $count = 0;
  foreach my $x (0..139) {
    foreach my $y (0..139) {
      $count++ if $x >= 3   && $y >= 3   && "XMAS" eq ($_[$x][$y] . $_[$x-1][$y-1] . $_[$x-2][$y-2] . $_[$x-3][$y-3]);
      $count++ if $x >= 3   && $y <= 136 && "XMAS" eq ($_[$x][$y] . $_[$x-1][$y+1] . $_[$x-2][$y+2] . $_[$x-3][$y+3]);
      $count++ if $x <= 136 && $y >= 3   && "XMAS" eq ($_[$x][$y] . $_[$x+1][$y-1] . $_[$x+2][$y-2] . $_[$x+3][$y-3]);
      $count++ if $x <= 136 && $y <= 136 && "XMAS" eq ($_[$x][$y] . $_[$x+1][$y+1] . $_[$x+2][$y+2] . $_[$x+3][$y+3]);
      $count++ if $x >= 3                && "XMAS" eq ($_[$x][$y] . $_[$x-1][$y]   . $_[$x-2][$y]   . $_[$x-3][$y]  );
      $count++ if $x <= 136              && "XMAS" eq ($_[$x][$y] . $_[$x+1][$y]   . $_[$x+2][$y]   . $_[$x+3][$y]  );
      $count++ if              $y >= 3   && "XMAS" eq ($_[$x][$y] . $_[$x][$y-1]   . $_[$x][$y-2]   . $_[$x][$y-3]  );
      $count++ if              $y <= 136 && "XMAS" eq ($_[$x][$y] . $_[$x][$y+1]   . $_[$x][$y+2]   . $_[$x][$y+3]  );
    }
  }
  return $count;
}

sub count2(@) {
  my $count = 0;
  foreach my $x (1..138) {
    foreach my $y (1..138) {
      my $pos = $_[$x-1][$y-1] . $_[$x][$y] . $_[$x+1][$y+1];
      my $neg = $_[$x-1][$y+1] . $_[$x][$y] . $_[$x+1][$y-1];

      $count++ if ($pos eq "MAS" or $pos eq "SAM") && ($neg eq "MAS" or $neg eq "SAM");
    }
  }
  return $count;
}
