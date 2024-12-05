#!perl

my %m;

while (<>) {
  chomp;
  last if /^$/;

  my ($a, $b) = split /\|/;
  $m{$a}{$b} = "Y";
}

my $total1 = 0;
my $total2 = 0;

while (<>) {
  chomp;
  my @l = split /,/;
  my $v = 1;
  my $i = 0;
  while ($i < $#l) {
    my ($a, $b) = @l[$i..$i+1];
    if (!$m{$a}{$b}) {
      $v = 0;
      @l[$i, $i+1] = @l[$i+1, $i];
      $i=0;
    } else {
      $i++;
    }
  }
  ($v ? $total1 : $total2) += $l[$#l/2];
}

print "Part 1: $total1\nPart 2: $total2\n";
