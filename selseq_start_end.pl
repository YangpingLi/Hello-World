#!/usr/bin/perl 
command_line();
open IN,"<$test_in";
open FL,"<$test_fl";
open OUT,">$test_out";

while(<FL>){
s/\r//g;
chomp;
s/>//;
@_=split(/\t/);
@m_name=split(/\s+/,$_[0]);
$name{$m_name[0]}++;
$stt=$_[1]-1;
$ful{$m_name[0]}{$stt}=$_[0];
$len{$m_name[0]}{$stt}=$_[2]-$_[1]+1;

}

while(<IN>){
s/\r//g;
   chomp;
   if ($_=~/\A>/){
      @seqname=split(/\>|\s+/,$_);
       if (exists $name{$seqname[1]}){
       $key=1;
       $keyname=$seqname[1];
       }
       else{$key=0;}       
   }
   elsif($_=~/\A[a-zA-Z]/ and $key==1){$tex{$keyname}=$tex{$keyname}."$_";}
     
     
}

@key_name=keys %name;
for ($i=0;$i<@key_name;$i++){
  @key_start=sort{$a<=>$b} keys %{@len{$key_name[$i]}};
 for($iii=0;$iii<@key_start;$iii++){
  
  $seq=substr($tex{$key_name[$i]},$key_start[$iii],$len{$key_name[$i]}{$key_start[$iii]});
  $key_star=$key_start[$iii]+1;
  $key_en=$len{$key_name[$i]}{$key_start[$iii]}+$key_start[$iii];
  print OUT ">$ful{$key_name[$i]}{$key_start[$iii]} start=$key_star end=$key_en\n";
  for($ii=0;$ii<length $seq; $ii+=70){
    $ucc=uc(substr($seq,$ii,70));
    print OUT "$ucc\n";
  }
 }
}







##############################################################################################################3
sub command_line(){
	  while(@ARGV){
	  	    $_=shift @ARGV;
	  	    if ($_ =~/-i$/){$test_in=shift @ARGV;}  
                  elsif($_ =~/-l$/){$test_fl=shift @ARGV;}
                  elsif($_ =~/-o$/){$test_out=shift @ARGV;}           
 	  	    else{print "help:  -i inputfile.fasta -l listfile -o outputfile\n";exit(0);}
	  }
}
