#!/usr/bin/perl 

#
#	Program with similar operation of mv file1 file2 for renaming a 
#+	file.
#

use strict;
use warnings;

my ($file1, $file2) = @ARGV;

# Just renaming if the second argument is a regular file
rename ($file1, $file2) if ! -d $file2; 

# what happens when second argument is a directory?
if (-d $file2) {
	open(FILE1, $file1) || die "$!";
	open(FILE2, ">$file2/$file1");
	foreach (<FILE1>) {
		print FILE2 $_;
	}
	close FILE1 || die "$!";
	unlink $file1 || die "$!";
	close FILE2 || die "$!";
}
