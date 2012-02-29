#!/usr/bin/perl
sub gen_sql{
	print "INSERT INTO Encounter (e_id, e_type, e_price) VALUES ('@_[0]','@_[1]',@_[2]);\n";
}

sub input_loop{
	foreach(<>){
		chomp;
		my @all_text = split;
		my $e_id = shift @all_text;
		my $e_price = pop @all_text;
		my $e_type = join(' ', @all_text);
		$e_type =~ s/'/''/g;
		&gen_sql($e_id,$e_type,$e_price);
	}
}

sub main{
	&input_loop;
}
&main;
