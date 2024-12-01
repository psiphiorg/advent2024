#!perl

my @a;
my @b;

while (<>) {
  chomp;
  my ($a, $b) = /^(\d*)\s*(\d*)$/;
  push @a, $a;
  push @b, $b;
  # print "[$_] => [$a, $b]\n";
}

@a = sort @a;
@b = sort @b;

my $total = 0;
foreach (0..$#a) {
  $total += abs($a[$_] - $b[$_]);
}

print "Part 1 Total: $total\n";

my %counts;

foreach (@b) {
  $counts{$_}++;
}

my $total2 = 0;

foreach (@a) {
  $total2 += $_ * $counts{$_};
}

print "Part 2 Total: $total2\n";
