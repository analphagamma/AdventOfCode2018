use strict;
use warnings;

my %claim_areas;
my $overlaps;

my $filename = 'day03.txt';
    open(my $fh, '<:encoding(UTF-8)', $filename)
    or die "Could not open file '$filename' $!";

my @all_claims; # contains all claims in a hash form
while (<$fh>) {
    my %claim = parse_claim($_); # create a claim by parsing one line of the input string
    my @tiles; # keeping track of all the tiles this claim covers
    foreach my $x ($claim{x_pos}+1..$claim{x_pos}+$claim{x_size}) {
        foreach my $y ($claim{y_pos}+1..$claim{y_pos}+$claim{y_size}) {
            $claim_areas{"$x,$y"}++;
            push(@tiles, "$x,$y"); # add tile to tile list
        }
    }
    $claim{tiles} = \@tiles; # assign tiles array reference to claim hash
    push(@all_claims, \%claim); # add the claim to the claims list
}
# check which tiles are used more than once
foreach (sort(keys %claim_areas)) {
    if ($claim_areas{$_} >= 2) {
        $overlaps++;
    }
}
print("Number of overlaps: $overlaps\n");

# check which ids consist of only tiles that are used only once
foreach (@all_claims) {
    my %cl = %$_;
    foreach my $tilelist($cl{tiles}) {
        my $tile_is_reused = 0;
        foreach my $tile (@{$tilelist}) {
        if ($claim_areas{$tile} >= 2) {
            $tile_is_reused = 1;
            last;
            }
        }
    if ($tile_is_reused != 1) {
        print("Unused tile: $cl{id}\n");
        exit;
        }
    }
}

sub parse_claim {
    my @claim_input = split ' ', $_[0];

    $claim_input[0] =~ m/(?<=#)\d+/;
    my $id = $&;
    $claim_input[2] =~ m/\d+,\d+/;
    my @pos = split(',', $&);
    my @area = split('x', $claim_input[3]);

    return (
    id => $id,
    x_pos => $pos[0],
    y_pos => $pos[1],
    x_size => $area[0],
    y_size => $area[1],
    tiles => []
    )
}
