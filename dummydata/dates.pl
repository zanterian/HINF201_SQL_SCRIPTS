#!/usr/bin/perl
sub full_month{
	my $year = @_[0];
	my $month = @_[1];
	for($day=1;$day<=31;$day++){
		push @insert_statements, $SQL_string_start."$day/$month/$year".$SQL_string_end;
	}
}
sub thirty_month{
	my $year = @_[0];
	my $month = @_[1];
	for($day=1;$day<=30;$day++){
		push @insert_statements, $SQL_string_start."$day/$month/$year".$SQL_string_end;
	}
}
sub feb{
	my $year = @_[0];
	my $month = @_[1];
	for($day=1;$day<=28;$day++){
		push @insert_statements, $SQL_string_start."$day/$month/$year".$SQL_string_end;
	}
}
sub leap_year{
	my $year = @_[0];
	my $month = @_[1];
	for($day=1;$day<=29;$day++){
		push @insert_statements, $SQL_string_start."$day/$month/$year".$SQL_string_end;
	}
}

sub main{
	@insert_statements;
	$SQL_string_start = 'INSERT INTO Time (t) VALUES (to_date(\'';
	$SQL_string_end = '\',\'dd/mm/yyyy\'));';
	for($year=1972;$year<2015;$year++){
		for($month=1;$month<=12;$month++){
			if($month==1 || $month==3 || $month==5 || $month==7 || $month==8 || $month==10 || $month==12){
				&full_month($year,$month);
			}
			elsif($month==4 || $month==6 || $month==9 || $month==11){
				&thirty_month($year,$month);
			}
			elsif($month==2){
				if(($year % 4)==0){
					&leap_year($year,$month);
				}
				else{
					&feb($year,$month);
				}
			}
		}
	}
	foreach(@insert_statements){
		print;print"\n";
	}
}
&main;
