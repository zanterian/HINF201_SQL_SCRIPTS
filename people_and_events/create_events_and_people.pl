#!/usr/bin/perl
# CONFIGURATION VARIABLES
$CLINIC_OPENING_YEAR = 1972;
$AMOUNT_OF_DOCTORS = 4;
$AMOUNT_OF_PATIENTS = 250;
$AMOUNT_OF_VISITS = 2400;
# File names
$NAME_FILE = 'firstnames';
$SURNAME_FILE = 'surnames';
$ENCOUNTER_FILE = 'PracticeGuidelines';
#####################################################################
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
sub gen_employed_date{
	my $year = int(rand(40)) + $CLINIC_OPENING_YEAR;
	my $month = int(rand(11)) + 1;
	if($month < 10){
		$month = "0"."$month";
	}
	my $day = int(rand(27)) + 1;
	return "to_date('$day/$month/$year', 'dd/mm/yyyy')";
}
sub gen_date{
	my $year = int(rand(100)) + 1915;
	my $month = int(rand(11)) + 1;
	my $day = int(rand(27)) + 1;
	return "to_date('$day/$month/$year','dd/mm/yyyy')";
}
sub create_doctors{
	my @init, $i, $SQL_string, $d_id, $d_name, $d_employed_date,@d_ids;
	$SQL_string = 'INSERT INTO Doctor (d_id, d_name, d_employed_date) VALUES ('."'";
	
	for($i=0;$i<$AMOUNT_OF_DOCTORS;$i++){	
		$d_id = &gen_d_id;
		push @d_ids, $d_id;
		$d_name = &gen_first_name;
		$d_employed_date = &gen_employed_date;
		push (@init, $SQL_string.$d_id."','".$d_name."',".$d_employed_date.");");
	}
	
	# Print out the Doctors
	foreach(@init){
		print;print"\n";
	}
	return @d_ids;
}
###################################### PATIENTS STUFF ###############
sub gen_p_id{
	int(rand(9999999999));
}
sub gen_p_d_id{
	my @d_ids = @_;
	return @d_ids[int(rand($#d_ids))];
}
sub create_patients{
	my @d_ids,@init, $SQL_String, $p_id, $p_middle_name, $p_last_name, $p_d_id, $maybe_middle, @p_ids;
	$SQL_String = 'INSERT INTO Patient (p_id, p_first_name, p_middle_name, p_last_name, p_d_id) VALUES (';
	$p_middle_name = '';
	for($i=0;$i<$AMOUNT_OF_PATIENTS;$i++){
		$maybe_middle = int(rand(100));
		$p_id = &gen_p_id;
		push @p_ids, $p_id;
		$p_first_name = &gen_first_name;
		if($maybe_middle>20){
			$p_middle_name = &gen_first_name;
		}else{
			$p_middle_name = '';
		}
		$p_last_name = &gen_last_name;
		$p_d_id = &gen_p_d_id;
		push (@init, $SQL_String."$p_id, '$p_first_name', '$p_middle_name', '$p_last_name', '$p_d_id');");
	}
	
	foreach(@init){
		print;print"\n";
	}
	return @p_ids;
	
}
####################################### PATIENT_ADDITIONAL ##########
sub gen_ph_number{
	my $part1 = int(rand(899))+100;
	my $part2 = int(rand(899))+100;
	my $part3 = int(rand(899))+100;
	return "$part1"."$part2"."$part3";
}

sub create_additional_info{
	my @init;
	my $SQL_String = 'INSERT INTO Patient_Additional (pa_p_id, pa_bd, pa_add1, pa_add2, pa_ph) VALUES (';
	foreach(@_){
		my $pa_p_id = $_;
		my $pa_bd = &gen_date;
		my $pa_ph = &gen_ph_number;
		push (@init, $SQL_String . "$pa_p_id,$pa_bd,'','',$pa_ph);");
	}
	foreach(@init){
		print;print"\n";
	}
}
# ADDING ENCOUNTERS HERE
sub gen_encounter_sql{
	print "INSERT INTO Encounter (e_id, e_type, e_price) VALUES ('@_[0]','@_[1]',@_[2]);\n";
}
sub create_encounters{
	my @e_ids;
	open ENCOUNTERS, "< $ENCOUNTER_FILE";
	foreach(<ENCOUNTERS>){
		chomp;
		my @all_text = split;
		my $e_id = shift @all_text;
		my $e_price = pop @all_text;
		my $e_type = join(' ',@all_text);
		$e_type =~ s/'/''/g;
		push @e_ids, $e_id;
		&gen_encounter_sql($e_id,$e_type,$e_price);
	}
	close ENCOUNTERS;
	return @e_ids;
}
#####################################################################
# will return the time to the gen_encounter_date
sub gen_time{
	my $hour = int(rand(9)) + 9;
	my $minute = int(rand(59));
	if($minute < 10){
		$minute = '0'."$minute";
	}
	return "$hour".':'."$minute";
}
# encounter string: to_date('','yyyy/mm/dd:hh24:mm')
sub gen_encounter_date{
	my $year = int(rand(40)) + $CLINIC_OPENING_YEAR;
	my $month = int(rand(11)) + 1;
	if($month < 10){
		$month = "0"."$month";
	}
	my $day = int(rand(27)) + 1;
	if($day < 10){
		$day = "0" . "$day";
	}
	my $time = &gen_time;
	return "to_date('$year/$month/$day:$time','yyyy/mm/dd:hh:mm')";
}
# Add patient visits here
sub create_patient_visits{
	my @init;
	my ($d_ids,$p_ids,$e_ids) = @_;
	my $SQL_String = 'INSERT INTO Patient_Visit (pv_id, pv_e_id, pv_p_id, pv_d_id, pv_t) VALUES(';
	for($i = 0; $i<$AMOUNT_OF_VISITS;$i++){
		my $t = &gen_encounter_date;
		my $e_id = $e_ids->[int(rand(@$e_ids))];
		my $p_id = $p_ids->[int(rand(@$p_ids))];
		my $d_id = $d_ids->[int(rand(@$d_ids))];
		push @init, $SQL_String . "$i,'$e_id',$p_id,'$d_id',$t);";
	}
	foreach(@init){
		print;print "\n";
	}
}	
#####################################################################
# Main method
sub main{
	print "/* Doctor Insertions */\n";
	my @p_d_ids = &create_doctors;
	print "/* Patient Insertions */\n";
	my @p_ids = &create_patients(@p_d_ids);
	print"/* Patient_Additional Insertions */\n";
	&create_additional_info(@p_ids);
	print"/* Encounter Insertions */\n";
	my @e_ids = &create_encounters;
	&create_patient_visits(\@p_d_ids,\@p_ids,\@e_ids);
}
#####################################################################
# Main Function
&main;
