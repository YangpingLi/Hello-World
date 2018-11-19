#!/usr/bin/env perl

parse_command_line();

open DB,"<$data";
while(<DB>){
   chomp;
   @_=split(/\t/);
   $info{$_[0]}=$_;
}
close DB;
open FIG,"<$input";
while(<FIG>){
   chomp;
   chop;
   @_=split(/\t/);
   print "$_\t$info{$_[$num]}\n";
}

sub parse_command_line {
    if(!@ARGV){usage();}
    else{
    while (@ARGV) {
	$_ = shift @ARGV;
	if    ($_ =~ /^-d$/) { $data   = shift @ARGV; }
	elsif ($_ =~ /^-i$/) { $input  = shift @ARGV; }
	elsif ($_ =~ /^-n$/) { $num  = shift @ARGV; }
	else {
	    usage();
	}
    }
    }
}

sub usage {
    print STDERR <<EOQ; 
    perl combine.pl -d -i -n [-h]   
    d  : database file, index by first colum 
    i  : input file
    n  : get index according to the nst colum, start with 0 (0,1,2,3...)
    h  : display the help information.
EOQ
exit(0);
}
