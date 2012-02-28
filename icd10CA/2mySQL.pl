#!/usr/bin/perl
# 
# Written by Eric Parapini Feb/14th/2012
sub make_code_text{
	my $code_text = shift(@_);
	foreach(@_){
		$code_text .= ' ' . $_;
	}
	$code_text =~ s/'/''/g;
	return $code_text;
}

sub input_loop{
	foreach(<>){
		my @all_text = split;
		my $code = shift @all_text;
		my $code_text = &make_code_text(@all_text);
		my $SQL_Output = "INSERT INTO codes ( code_type, code, modifier, code_text ) VALUES ( 2, '$code', '', '$code_text' );";
		print $SQL_Output . "\n";
	}
}

sub main{
	&input_loop;
}

&main;
