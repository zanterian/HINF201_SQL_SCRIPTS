#!/usr/bin/perl
sub full_month{

}
sub thirty_month{
	
}
sub feb{

}
sub leap_year{
	
}

sub main{
	for($year=1972;$year<2015;$year++){
		for($month=1;$month<=12;$month++){
			if($month==1 || $month==3 || $month==5 || $month==7 || $month==8 || $month==10 || $month==12){
				&full_month($year,$month);
			}
			elsif($month==2 || $month==4 || $month==6 || $month==9 || $month==11){
				&thirty_month($year,$month);
			}
			elsif$month==2){
				if($year % 4){
					&leap_year($year,$month);
				}else{
					&feb($year,$month);
				}
			}
		}
	}
}
&main;
