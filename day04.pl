use strict;
use warnings;

use Time::Local;

my $filename = 'day04.txt';
open(my $fh, '<:encoding(UTF-8)', $filename)
    or die "Could not open file '$filename' $!";

my @events = sort(<$fh>);

my @all_guards;
my %guard_activity = (
                      id => 0,
                      wake_time => 0
                      );
my @times;
foreach (@events)  {
    my @event = split '\[(.*?)\]', $_;

    # getting the timestamp
    my ($year,$mon,$mday,$hour,$min,$sec) = split(/[\s:-]+/, $event[1]);
    my $timestamp = timelocal($sec,$min,$hour,$mday,$mon-1,$year);
    print("Time: $timestamp -> ");
    # time passed
    my $prev_time = pop(@times);
    $prev_time = $timestamp if (!$prev_time);
    
    # check to find guard id or record activity
    if ($event[2] =~ /wakes up/) {
        print("Guard wakes up\n");
    } elsif ($event[2] =~ /falls asleep/) {
        print("Guard falls asleep\n");
    } elsif ($event[2] =~ m/(?<=Guard #)\d+/) {
        print("The id is $&\n");
    } else {
        print("\n");
    }
        

    
}
