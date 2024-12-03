#!perl

my $total1 = 0;
my $total2 = 0;
my $toggle = 1;

while (<STDIN>) {
  chomp;
  my (@a) = /(mul\(\d+,\d+\)|do\(\)|don't\(\))/g;
  foreach (@a) {
    $toggle = 1, next if /do\(\)/;
    $toggle = 0, next if /don't\(\)/;

    my ($a, $b) = /mul\((\d+),(\d+)\)/;
    $total1 += $a * $b;
    $total2 += $a * $b * $toggle;
  }
}

print "Part 1: $total1\nPart 2: $total2\n";
