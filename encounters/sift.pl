#!/usr/bin/perl

sub main{
	foreach(<>){
		if(m/([A-Z])?(\d{5}).*((\.+)\s(\d{1,})\.(\d{2}))(?:.*)/){
			s/(\.){2,}/ /g;
			print;	
		}
	}
}
&main;
