#!perl

# Part 1: Given standard in with lines containing two numbers separated by some number of spaces,
# get the difference between the two lowest digits in each column, plus the difference between
# the second lowest digits in each column, etc.

my @a; # First column numbers
my @b; # Second column numbers

while (<>) { # For each line from standard in
  chomp; # Remove the newline character at the end of the line (if present)
  my ($a, $b) = /^(\d*)\s+(\d*)$/; # Get the two collections of digits surrounding some number of spaces
  push @a, $a; # Store the first number in the first column array
  push @b, $b; # Store the second number in the second column array
  # print "[$_] => [$a, $b]\n";
}

# Sort both arrays so they're in numerical order
@a = sort @a;
@b = sort @b;

# For each index in the two arrays (which have the same size), get the distance between the two digits in that index
my $total = 0;
foreach (0..$#a) {
  $total += abs($a[$_] - $b[$_]);
}

print "Part 1 Total: $total\n";

# Part 2: For each number that appears in the first column,
# multiply that number by the number of times it appears inithe second column.

# Turn a second column of [1, 2, 2, 2, 5, 7, 7] into {1 => 1, 2 => 3, 5 => 1, 7 => 2}
my %counts;
foreach (@b) {
  $counts{$_}++;
}

# For each number that appears in the first column,
# find out how many times it appears in the second column and multiply those together.
my $total2 = 0;
foreach (@a) {
  $total2 += $_ * $counts{$_};
}

print "Part 2 Total: $total2\n";
