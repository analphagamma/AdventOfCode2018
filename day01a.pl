use strict;
use warnings;

my $filename = 'day01.txt';
open(my $fh, '<:encoding(UTF-8)', $filename)
    or die "Could not open file '$filename' $!";

my $freq = 0;
while (<$fh>) {
    $freq += $_;
}
print("Frequency: $freq");
