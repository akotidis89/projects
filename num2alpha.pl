#!/usr/bin/perl
#
#	Translates a numerical digit to its English name
#
use strict;
use warnings;

# create a hash
my %numbers = (1, 'one', 2, 'two', 3, 'three', 4, 'four', 5, 'five', 6, 'six', 7, 'seven', 8, 'eight', 9, 'nine');

# another way, more elegant way
#
# my %numbers;
# @numbers{1..9} = qw (one two three four five six seven eight nine ten);

# input from the user
print "Please give a number from 1 to 9: ";
chomp (my $a = <STDIN>);

# call a function
matching($a);

# declare a function which returns the string name to the corresponding 
# numerical value, except for 0
sub matching {
	if ($_[0] =~ /^\d$/ && $_[0] != 0) {
		return $numbers{$_[0]};
	} else {
		return $_[0];
	}
	# instead of the if statement we could do this
	# $numbers{$_[0]} || $_[0]; -> simple amazing and elegant perl code :)
} 
