use strict;
use warnings;

my %claim_areas;
my $overlaps;

my $filename = 'day03.txt';
open(my $fh, '<:encoding(UTF-8)', $filename)
    or die "Could not open file '$filename' $!";

while (<$fh>) {
    my %claim = parse_claim($_);
    foreach my $x ($claim{x_pos}+1..$claim{x_pos}+$claim{x_size}) {
        foreach my $y ($claim{y_pos}+1..$claim{y_pos}+$claim{y_size}) {
            $claim_areas{"$x,$y"}++;
        }
    }
}

foreach (sort(keys %claim_areas)) {
    if ($claim_areas{$_} >= 2) {
        $overlaps++;
    }
}
print("Number of overlaps: $overlaps");

sub parse_claim {
    my @claim_input = split ' ', $_[0];

    $claim_input[0] =~ m/(?<=#)\d+/;
    my $id = $&;
    $claim_input[2] =~ m/\d+,\d+/;
    my @pos = split(',', $&);
    my @area = split('x', $claim_input[3]);

    return (
        id     => $id,
        x_pos  => $pos[0],
        y_pos  => $pos[1],
        x_size => $area[0],
        y_size => $area[1]
        )
}
