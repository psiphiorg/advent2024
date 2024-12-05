#!perl

my $count1 = 0;
my $count2 = 0;

# Given an input file containing a series of space-delimited numbers, then that
# into an array.  If the line is "safe", then count it as safe for parts 1 and 2.
# If the line isn't safe but can be altered by removing one number from the list,
# then count it as safe for part 2.

while (<>) {
  chomp;
  my @a = split / /;
  $count1++ if is_safe(@a);
  $count2++ if is_safe(@a) || is_safe_altered(@a);
}

print "Safe lines: $count1 / $count2\n";

# A line is "safe" if both conditions is true:
# 1. The line always increases or always decreases (never stays the same)
# 2. Any two consecutive digits are 1, 2, or 3 apart from one another

sub is_safe(@) {
  my $inc = 0;
  my $dec = 0;
  my $same = 0;

  my $last = shift; # Get the first digit from the line and store that as "last", which we will
                    # compare against.  This also removes it from the list so we don't double-count.
  foreach (@_) { # Loop over the remaining digits
    $inc++ if $_ > $last; # If the new number is bigger than the last, then we have an increase
    $dec++ if $_ < $last; # If the new number is smaller than the last, then we have a decrease
    $same++ if $_ == $last; # If the two numbers are the same, we have a same
    return 0 if abs($_ - $last) > 3; # If the two numbers are farther apart than 3, then the line is not safe
    $last = $_; # Replace the last digit with this one so we will compare against it next time
  }

  # If we're still close, we don't stay the same, and either we only increase or only decrease, then this is good.
  return !$same && ($inc xor $dec);
}

# A line is "safe if altered" if removing a single number could be result in a line that is "safe".

sub is_safe_altered(@) {
  for my $i (0..$#_) { # For each position in the original array (zero-based)
    my @temp = (@_); # Make a copy of the original array
    splice @temp, $i, 1; # Remove the element in position i
    return 1 if is_safe(@temp); # If we find one safe pattern, then skip checking all other alterations
  }
}
