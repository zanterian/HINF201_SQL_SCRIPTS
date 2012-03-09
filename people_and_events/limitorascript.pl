#!/usr/bin/perl
# 
# 
#
$OUTPUT_FILE_NAME = 'Fill_Database';
 
sub file_generation{
	my $file_name = shift;
	my $f_count = shift;
	my $i = 1;
	$file_name .= $f_count . '.sql';
	open OUTPUT,">",$file_name;
	foreach(@_){
		print OUTPUT $_;
		$i++;
	}
}

sub input_loop{
	my @sql_block, $f_count, $count;
	$count = 0;
	$f_count = 0;
	foreach(<>){
		if($count == 4500){
			&file_generation($OUTPUT_FILE_NAME,$f_count,@sql_block);
			$count = 0;
			$f_count++;
			undef @sql_block;
		}
		push @sql_block,$_;
		$count++;
	}	
	&file_generation($OUTPUT_FILE_NAME,$f_count,@sql_block);
}

sub main{
	&input_loop;
}

&main
