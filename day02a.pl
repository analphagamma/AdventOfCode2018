use strict;
use warnings;

my $filename = 'day02.txt';
open(my $fh, '<:encoding(UTF-8)', $filename)
    or die "Could not open file '$filename' $!";

my %multipliers;
my $checksum = 1;

foreach my $id (<$fh>) {
    my %count = ();
    foreach my $letter (split('', $id)) {
        if ($id =~ m/\Q$letter/) {
            $count{$letter} += 1;
        }
    }
    my @letters = reverse sort (values %count);
    if ($letters[0] != $letters[1]) {
        $multipliers{$letters[0]}++;
        $multipliers{$letters[1]}++;
    } else {
        $multipliers{$letters[0]}++;
    }
}
$checksum *= $multipliers{'2'};
$checksum *= $multipliers{'3'};
print("Checksum: $checksum");
