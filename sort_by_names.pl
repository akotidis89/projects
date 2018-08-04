#!/usr/bin/perl

#
#	Extract logins and real users and sort them according to real ones
#

use strict;
use warnings;

# open filehandle for the passwd file and store its values to a variable
open PASS, "/etc/passwd" or die "/etc/passwd can't be opened: $!";
my @pass = <PASS>;
close PASS;

# create a hash with user-name as key value pairs
my %names;
foreach (@pass) {
	my ($user, $name) = (split /:/)[0, 4];
	$name = (split /,/, $name)[0];
	$names{$user} = $name;
}

# sort array of keys according to subroutine by_names
my @sortedkeys = sort by_names keys (%names);

# printing output
foreach (@sortedkeys) {
	print "$_ with real name $names{$_}\n";
}

# declare the sorting subroutin
sub by_names {
	# alphabetical sorting of real names, but if real names are the same,
	# then sorting alphabetically the corresponding login users
	($names{$a} cmp $names{$b}) || ($a cmp $b);
}
