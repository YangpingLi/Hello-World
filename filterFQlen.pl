#filter fastq files for reads whose length is proper for further analysis
use strict;
use warnings;
parse_command_line();

open FIG,"<$input";
$cnt=0;
while(<FIG>){
   $cnt++;
   chomp;
   if($cnt%4==1){$name=$_;}
   elsif($cnt%4==2){$len=length($_);
   if($len>$min && $len<$max){print "$name\n$_\n";}}
   else{;}
}


sub parse_command_line {
  if(!@ARGV){usage();}
  else{
    while (@ARGV) {
	$_ = shift @ARGV;
	if    ($_ =~ /^-i$/) { $input   = shift @ARGV; }
	elsif ($_ =~ /^-min$/) { $min  = shift @ARGV; }
	elsif ($_ =~ /^-max$/) { $max  = shift @ARGV; }
	else {
	    print STDERR "Unknown connand line\n";
	    usage();
	}
    }
  }
}

sub usage {
    print STDERR <<EOQ; 
    perl perl filterFQlen.pl -i -min -max [-h]
    i  : fastq file           
    min  : min length
	max  : max length
    h  : display the help information.
EOQ
exit(0);
}
