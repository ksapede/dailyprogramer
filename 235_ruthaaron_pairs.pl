use strict;

open (INPUT, "ra_pairs");
foreach my $line (<INPUT>) {
	if ($line !~ /\(/) {next;}

	$line =~ s/[()\s\n]//g;
	my ($f,$s) = split(/,/,$line);

	print "($f, $s) ";
	if (is_ruthaaron_pair($f,$s)) {print "VALID\n";}
	else {print "NOT VALID\n"}
}

sub is_prime($) {
	my $number = shift;
	#print "is $number prime?\n";
	return 1 if ($number <= 3);
	return 0 if ($number % 2 == 0);
	
	#check odd numbers
	for(my $i = 2; $i< $number; $i++) {
		#print "checking $i\n";
		return 0 if ($number % $i == 0);
	}
	return 1;

}
sub get_unique_factorization($) {
	my $number = shift;
	my $factors_href = shift;
	#print "Checking $number\n";#, sqrt is ".sqrt($number). "n";
	#die;

	foreach my $n (2 .. $number-1) {
		if ($number % $n == 0) {
			
			if (is_prime($n)) {
				#print "$n is a factor\n";
				$factors_href->{$n} = $n;

			}
			else {
				#print " and is not prime\n";
				get_unique_factorization($n, $factors_href);
			}

		}

	}
	my @factors = keys %{$factors_href};
	return \@factors;

}

sub add_factors($) {
	my $factors = shift;
	my $total = 0;
	foreach my $n (@{$factors}) {
		#print "$n\n";
		$total += $n;
	}
	return $total;

}

sub is_ruthaaron_pair($$) {
	my $first = shift;
	my $second = shift;
	if (add_factors(get_unique_factorization($first)) == add_factors(get_unique_factorization($second))) {
		return 1;
	}
	else {
		return 0;
	}
}