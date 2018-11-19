#从总的fastq文件中提取list文件所含的序列名字的序列输出
parse_command_line();

open LIST,"<$list";
open FIG,"<$input";
open OUT,">$list.fastq";
%hash=();
while(<LIST>){
              s/\r//g;
              chomp;
              s/>//;
              $hash{$_}++;
}
@test=keys %hash;
while (($key,$value)=each %hash){
while(<FIG>){
             s/\r//g;
             chomp;
             if(/HWI/){
                     s/@//;
                     @_=split(/\s+/);
                     if(exists $hash{"$_[0]"}){print OUT "@"."$_\n";$jud=1;}
                     else{$jud=0;}
             }
             elsif($jud==1){print OUT "$_\n";}
             else{;}
}
}

sub parse_command_line {
  if(!@ARGV){print STDERR "usage: perl getFQseq.pl -l list -r reference.fastq\n";}
  else{
    while (@ARGV) {
	$_ = shift @ARGV;
	if    ($_ =~ /^-l$/) { $list   = shift @ARGV; }
	elsif ($_ =~ /^-r$/) { $input  = shift @ARGV; }
	else {
	    print STDERR "usage: perl getFQseq.pl -l list -r reference.fasta\n";
	}
    }
  }
}
