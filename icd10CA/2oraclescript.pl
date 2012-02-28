#!/usr/bin/perl
sub input_loop{
	foreach(<>){
		my @all_text = split;
		my $code = shift @all_text;
		my $code_text = join(' ',@all_text);
		$code_text =~ s/'/''/g;
		my $SQL_code = "INSERT INTO ICD_10_CA (CODE, CODE_TEXT) VALUES ('$code','$code_text');";
		print $SQL_code . "\n";
	}
}


sub main{
	&input_loop;
}
&main;
