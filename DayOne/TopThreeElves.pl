#!/usr/bin/perl

open(FH, '<', 'DayOneCalories.txt') or die "Unable to open file: $!\n";

my $maxCals = 0;
my $currCals = 0;

my @subtotals;

for (<FH>) {
	if (/\d+/) {
		chomp;
		$currCals += $_;
	} else {
		push @subtotals, $currCals;
		$currCals = 0;
	}
}

my @topThree = (sort { $b <=> $a } @subtotals)[0..2],
	$topTotal = 0;
map { $topTotal += $_ } @topThree;

print "Top three elves: ", join(", ", @topThree), ". Total = $topTotal\n";
