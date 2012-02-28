#!/usr/bin/perl
# Splits the output and sorts it
# into a set of files of the correct
#
sub file_generation{
	my $file_name = shift;
	my $f_count = shift;
	$file_name .= $f_count.'.sql';
	#`touch $file_name`;
	open OUTPUT,">", $file_name;
	print OUTPUT "INSERT ALL\n";
	foreach(@_){
		print OUTPUT $_;
	}
	print OUTPUT "SELECT * FROM DUAL;\n";
	close OUTPUT;
}
 
sub input_loop{
	my @sql_block, $file_name, $f_count, $count;
	$count = 0;
	$file_name = 'ICD10CABlock';
	$f_count = 0;
	foreach(<>){
		if($count == 1500){
			&file_generation($file_name,$f_count,@sql_block);
			$count = 0;
			$f_count++;
			undef @sql_block;
		}
		push @sql_block,$_;
		$count++;
	}
	&file_generation($file_name,$f_count,@sql_block);
}

sub main{
	&input_loop;
}

&main;
