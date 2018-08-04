#!/usr/bin/perl

#
#	Use real names from /etc/passwd instead of usernames in the output of
#+	who command and pass it to less
#

use strict;
use warnings;

# open filehandle to read /etc/passwd and store its lines
open PASS, "/etc/passwd" or die $!;
my @passwd = <PASS>;
close PASS;

my %pass;

# create a hash with keys the usernames and values the corresponding real ones
foreach (@passwd) {
	my ($user, $real) = ( split /:/ )[0, 4];
	$real = (split /,/, $real)[0];
	$pass{$user} = $real;
}

# open filehandles for the commands who and less
open WHO, "who |" or die $!;
open LESS, "| less" or die $!;

# for every line of who, substitute username with real ones and then print
# in less output
foreach (<WHO>) {
	s/^(\S+)/$pass{$1}/;
	print LESS;
}	

# close the command filehandles
close WHO;
close LESS;
