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

my $grandTotal = 0;

 MAIN: {
	 open FH, $infile;

	 while (<FH>) {
		 chomp;

		 my @items = split //;
		 my $leftEnd = ($#items-1)/2;

		 my @left = @items[0..$leftEnd],
			 @right = @items[$leftEnd+1..$#items];

		 my $hashLeft = getMembers(@left),
			 $hashRight = getMembers(@right);

		 foreach (keys %$hashLeft) {
			 $grandTotal += getPriority($_) if $hashRight->{$_};
		 }
	 }

	 print "Total priority count is $grandTotal\n";
}
