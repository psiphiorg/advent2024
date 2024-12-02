#!perl

my $count1 = 0;
my $count2 = 0;

while (<>) {
  chomp;
  my @a = split / /;
  $count1++ if is_safe(@a);
  $count2++ if is_safe(@a) || is_safe_altered(@a);
}

print "Safe lines: $count1 / $count2\n";

sub is_safe(@) {
  my $inc = 0;
  my $dec = 0;
  my $same = 0;
  my $close = 1;

  my $last = shift;
  foreach (@_) {
    $dec++ if $_ > $last;
    $inc++ if $_ < $last;
    $same++ if $_ == $last;
    $close = 0 if abs($_ - $last) > 3;
    $last = $_;
  }

  my $retval = $close && !$same && ($inc xor $dec);

  return $retval;
}

sub is_safe_altered(@) {
  my @temp = (@_);
  for my $i (0..$#_) {
    @temp = (@_);
    splice @temp, $i, 1;
    return 1 if is_safe(@temp);
  }
}
