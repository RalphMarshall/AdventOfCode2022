#!/usr/bin/perl

open(FH, '<', 'DayOneCalories.txt') or die "Unable to open file: $!\n";

my $maxCals = 0;
my $currCals = 0;

for (<FH>) {
	if (/\d+/) {
		chomp;
		$currCals += $_;
	} else {
		if ($currCals > $maxCals) {
			print "Latest total $currCals BEATS $maxCals\n";
			$maxCals = $currCals;
		} else {
			print "Latest total $currCals < $maxCals\n";
		}
		$currCals = 0;
	}
}

print "Largest number of calories is $maxCals\n";
