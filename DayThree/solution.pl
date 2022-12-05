#!/usr/bin/perl -w

my $infile = "./Input.txt";

sub getMembers(@) {
	my %retval;
	foreach my $a (@_) {
		$retval{$a} = 1;
	}

	return \%retval;
}

my $lowStart = ord('a'),
	$upStart = ord('A');

sub getPriority($) {
	my $ord = ord($_[0]);

	return (1 + $ord - $lowStart) if ($ord >= $lowStart);
	return 27 + $ord - $upStart;
}

sub findCommon(@) {
	my @hashes = ();

	foreach my $aref (@_) {
		push(@hashes, getMembers(@$aref));
	}

	my $firstHash = pop @hashes;
	foreach my $nextHash (@hashes) {
		foreach (keys %$firstHash) {
			delete $firstHash->{$_} unless $nextHash->{$_};
		}
	}

	# In theory there should be exactly one value left
	return (keys %$firstHash)[0];
}

 MAIN: {
	 open FH, $infile;

	 my $grandTotal = 0;
	 my @allPacks = ();

	 while (<FH>) {
		 chomp;

		 my @items = split //;
		 push @allPacks, \@items;

		 my $leftEnd = ($#items-1)/2;

		 my @left = @items[0..$leftEnd],
			 @right = @items[$leftEnd+1..$#items];

		 my $commonItem = findCommon(\@left, \@right);
		 $grandTotal += getPriority($commonItem);
	 }

	 print "Total priority count is $grandTotal\n";

	 my $badgeTotal = 0;
	 while (@allPacks) {
		 my @nextGroup = @allPacks[0..2];
		 @allPacks = @allPacks[3..$#allPacks];

		 my $badge = findCommon(@nextGroup);
		 $badgeTotal += getPriority($badge);
	 }

	 print "Badge total is $badgeTotal\n";
}
