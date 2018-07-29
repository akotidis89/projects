#!/usr/bin/perl

#
#	Description: A simple contact manager
#	Author:      Anestis Kotidis
#	Date:        25/07/2018
#

use warnings;
use strict;

#
#	Define some variables
#
my ($firstname, $surname, $address, $city, $state, $zip);
my $file = "names.dat";


#
#	This is the main menu of the program that keeps repeating
#
MAIN:while (1) {

print `clear`;	
print <<"EOF";
\t\tWelcome to Contact Manager

\t1. Create a new record
\t2. View records
\t3. Search record
\t4. Delete record

Please make a selection [1-4] or press Q to quit the program: 
EOF

my $choice = <STDIN>;
chomp $choice;

if ($choice eq '1') {
	&create && next MAIN;
} elsif ($choice eq '2') {
	&view && next MAIN;
} elsif ($choice eq '3') {
	&search && next MAIN;
} elsif ($choice eq '4') {
	&delete && next MAIN;
} elsif ($choice =~ /q/i) {
	&quit;
} else {
	&retry && next MAIN;
}

}

#
#	Define the subroutine for creating a record
#
sub create {
	&clear;
	print "\n\nYou are about to create a new record\n";
	print "Please complete the appropriate fields\n\n";

	print "First Name: "; $firstname = <STDIN>;
	print "   Surname: "; $surname   = <STDIN>;
	print "   Address: "; $address   = <STDIN>;
	print "      City: "; $city      = <STDIN>;
	print "     State: "; $state     = <STDIN>;
	print "       Zip: "; $zip       = <STDIN>;
	
	chomp($firstname, $surname, $address, $city, $state, $zip);
	
	my @details = ($firstname, $surname, $address, $city, $state, $zip);
	my $output = join ":", @details;
	
	open NAMES, ">> $file" or die "Can't open $file: $!";
	print NAMES $output, "\n";
	close NAMES;
	
	print "\n\nA new record has been created.\n";
	print "Thank you for your input\n\n\n";
	
	print "Press any key to continue: ";
	<STDIN>;
	return;
	
}

#
#	Simple subroutine to clear screen
#
sub clear {
	print `clear`;
}

#
#	Define subroutine for formatting output of records
#
sub view {
	
&clear;
$= = 10;
my $i = 1;

format STDOUT_TOP =
Page @<
     $%
     
 No   First Name   Surname      Address        City         State        Zip
+------------------------------------------------------------------------------+
.
	
format STDOUT =
 @<<  @<<<<<<<<<   @<<<<<<<<<<< @<<<<<<<<<<<<< @<<<<<<<<<<< @<<<<<<<<<<< @<<<<<
$i++,$firstname, $surname,    $address,       $city,       $state,        $zip
.

open NAMES, $file or die "Can't open $file: $!";
my @lines = <NAMES>;
close NAMES;

foreach (@lines) {
	chomp;
	($firstname, $surname, $address, $city, $state, $zip) = split /:/;
	write;
} 

print "\n\nPress <ENTER> to continue: ";
<STDIN>;

return;

}


#
#	Search the data for a record
#
sub search {
	&clear;
	print "\nPlease enter the search pattern: ";
	chomp(my $pattern = <STDIN>);
	my @match;
	
	open RECORDS, $file or die "The file $file can't be opened: $!";
	my @lines = <RECORDS>;
	close RECORDS;
	
	foreach (@lines) {
		push @match if /$pattern/;
	}
	
	foreach (@match) {
		print;
	}
	
	return;
}


#
#	Subroutine to delete a record
#
sub delete {
	&clear;
	print "\nNot implemented yet\n\n";
	print "Press <ENTER> to continue: ";
	<STDIN>;
	return 0;
}


#
#	What happens when we enter sth invalid?
#
sub retry {
	&clear;
	print "\n\nYour input is invalid. Press <ENTER> to continue ";
	<STDIN>;
	return;
}


#
#	Subroutine to exit the program
#
sub quit {
	print "\n\nThe program is exiting..\n";
	sleep 1;
	exit 0;
}
