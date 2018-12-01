use strict;
use warnings;

my $filename = 'day01.txt';
open(my $fh, '<:encoding(UTF-8)', $filename)
    or die "Could not open file '$filename' $!";

my @changes;
while (<$fh>) {
    push(@changes, $_);
    }
my $cur_freq;
my %freqs;
my $duplicate_freq;
while (1) {
    foreach (@changes) {
        $cur_freq += $_;;
        if (!$freqs{$cur_freq}) {
            $freqs{$cur_freq} = 1;
        } else {
            print("Duplicate item: $cur_freq\n");
            exit
        }
    }
}
