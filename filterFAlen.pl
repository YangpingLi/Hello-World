#filter fastaq files for reads whose length is proper for further analysis

parse_command_line();

open FIG,"<$input";
$cnt=0;
while(<FIG>){
   chomp;
   $cnt++;
   if($cnt%2==1){$name=$_;}
   else{$len=length($_);if($len>300){print "$name\n$_\n";}}
}


sub parse_command_line {
  if(!@ARGV){usage();}
  else{
    while (@ARGV) {
	$_ = shift @ARGV;
	if    ($_ =~ /^-i$/) { $input   = shift @ARGV; }
	else {
	    print STDERR "Unknown connand line\n";
	    usage();
	}
    }
  }
}

sub usage {
    print STDERR <<EOQ; 
    perl perl filterFastalen.pl -i [-h]
    i  : fasta file      
    h  : display the help information.
EOQ
exit(0);
}
