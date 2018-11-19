#从总的fasta文件中提取list文件所含的序列名字的序列输出
parse_command_line();

open LIST,"<$list";
open FIG,"<$input";
open OUT,">$list.fasta";
%hash=();
while(<LIST>){
              s/>//;
			  s/\r//g;
              chomp;

		print "$_\n";
              $hash{$_}++;
}
@test=keys %hash;
while (($key,$value)=each %hash){
   while(<FIG>){
             chomp;
			 s/\r//g;
             if(/>/){
                     @_=split(/>|\s+/);
                     if(exists $hash{"$_[1]"}){print OUT "$_\n";$jud=1;}
                     else{$jud=0;}
             }
             elsif($jud==1){print OUT "$_\n";}
             else{;}
   }
}

sub parse_command_line {
    if(!@ARGV){usage();}
    else{
    while (@ARGV) {
	$_ = shift @ARGV;
	if    ($_ =~ /^-l$/) { $list   = shift @ARGV; }
	elsif ($_ =~ /^-r$/) { $input  = shift @ARGV; }
	else {
	    usage();
	}
    }
    }
}

sub usage {
    print STDERR <<EOQ; 
    perl getseq.pl -l -r [-h]   
    l  : list file
    r  : input file
    h  :display the help information.
EOQ
exit(0);
}
