#!/usr/bin/perl

#
#	Printing information from /etc/passwd to output
#

use strict;
use warnings;

# define some variables
my ($username, $uid, $gcos, $real);

# open filehandle for /etc/passwd
open(PASS_FILE, "/etc/passwd");

# Looping through the contents of /etc/passwd
while (<PASS_FILE>) {
	chomp;
	($username, $uid, $gcos) = (split /:/)[0, 2, 4];
	# this is for dropping all extra commas
	($real) = split /,/, $gcos;
	write STDOUT;
}

close PASS_FILE; 

# Some nice formatting output..
format STDOUT =
@<<<<<<<<  @<<<< @<<<<<<<<<<<<<<<
$username, $uid, $real
.
 
format STDOUT_TOP =
Username   UID   Real Name
==============================
.
