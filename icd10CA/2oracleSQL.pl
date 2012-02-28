#!/usr/bin/perl
# Create the ICD-10-CA Table from inputted codes
# 
# Written by Eric Parapini Feb/14th/2012
sub input_loop{
	foreach(<>){
		my @all_text = split;
		my $code = shift @all_text;
		my $code_text = join(' ',@all_text);
		# Fix in case there are any apostraphes in the code_text
		$code_text =~ s/'/''/g;
		my $SQL_code = "INTO ICD_10_CA (CODE, CODE_TEXT) VALUES ('$code','$code_text')";
		print "\t" . $SQL_code . "\n";
	}
}

sub main{
	#print "INSERT ALL\n";
	&input_loop;
	#print "SELECT * FROM DUAL;";
}

&main;
