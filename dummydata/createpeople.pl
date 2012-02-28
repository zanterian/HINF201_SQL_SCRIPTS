#!/usr/bin/perl
# Decide how many doctors to create here
$AMOUNT_OF_DOCTORS = 8;
$AMOUNT_OF_PATIENTS = 1500;
$NAME_FILE = 'firstnames';
$SURNAME_FILE = 'surnames';
########################################
sub gen_d_id{
	my $d_id = 'D';
	$d_id .= int(rand(999));
}

sub gen_first_name{
	open NAMES, "< $NAME_FILE";
	my @names = <NAMES>;
	my $name = @names[int(rand($#names))];
	chomp($name);
	close NAMES;	
	return $name;
}

sub gen_last_name{
	open SURNAMES, "< $SURNAME_FILE";
	my @surnames = <SURNAMES>;
	my $surname = @surnames[int(rand($#surnames))];
	chomp($surname);
	close SURNAMES;
	return $surname;
}

sub gen_d_employed_date{
	my $d_employed_date, $year, $month, $day;
	$year = int(rand(40)) + 1972;
	$month = int(rand(11)) + 1;
	$day = int(rand(27)) + 1;
	$d_employed_date = "to_date('$day/$month/$year', 'dd/mm/yyyy')";
}



sub create_doctors{
	my @init, $i, $SQL_string, $d_id, $d_name, $d_employed_date,@d_ids;
	$SQL_string = 'INSERT INTO Doctor (d_id, d_name, d_employed_date) VALUES (';
	
	for($i=0;$i<$AMOUNT_OF_DOCTORS;$i++){	
		$d_id = &gen_d_id;
		push @d_ids, $d_id;
		$d_name = &gen_first_name;
		$d_employed_date = &gen_d_employed_date;
		push (@init, $SQL_string.$d_id."','".$d_name."',".$d_employed_date."');");
	}
	
	# Print out the Doctors
	foreach(@init){
		print;print"\n";
	}
	return @d_ids;
}
###################################### PATIENTS STUFF
sub gen_p_id{
	int(rand(9999999999));
}
sub gen_p_d_id{
	my @d_ids = @_;
	return @d_ids[int(rand($#d_ids))];
}

sub create_patients{
	my @d_ids,@init, $SQL_String, $p_id, $p_middle_name, $p_last_name, $p_d_id, $maybe_middle;
	$SQL_String = 'INSERT INTO Patient (p_id, p_first_name, p_middle_name, p_last_name, p_d_id) VALUES (';
	$p_middle_name = '';
	for($i=0;$i<$AMOUNT_OF_PATIENTS;$i++){
		$maybe_middle = int(rand(100));
		$p_id = &gen_p_id;
		$p_first_name = &gen_first_name;
		if($maybe_middle>20){
			$p_middle_name = &gen_first_name;
		}
		$p_last_name = &gen_last_name;
		$p_d_id = &gen_p_d_id;
		push (@init, $SQL_string."$p_id, '$p_first_name', '$p_middle_name', '$p_last_name', '$p_d_id');");
	}
	
	foreach(@init){
		print;print"\n";
	}
	
}


sub main{
	print "/* Doctor Insertions */\n";
	my @p_d_ids = &create_doctors;
	print "/* Patient Insertions */\n";
	&create_patients(@p_d_ids);
}
&main;
