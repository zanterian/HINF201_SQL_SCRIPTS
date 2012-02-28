#!/usr/bin/perl
# This is just a little script to extract all of the ICD-10-CA codes from any messed up file
# that is piped to it
# 
# Written by Eric Parapini Feb/14th/2012
sub input_loop{
	foreach(<>){
		# Regular Expression to match the following syntax:
		# <ICD-10-CA CODE> <Description>
		# Then prints it out to the screen for later parsing 
		if(m/^([A-Z]\d{2,}.\d{1,})(\s.+)/i){
			print;
		}
	}
}

sub main{
	&input_loop;
}

&main;
