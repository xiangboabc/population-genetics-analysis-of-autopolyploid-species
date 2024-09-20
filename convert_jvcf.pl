open I, "$ARGV[0]" or die;
print "##\n##\n";
while(<I>)
	{
	chomp;
	@ss=split /\t/,$_;
	next if(/^##/);
	if(/^#CHROM/)
		{
		delete $ss[2];
		delete $ss[5];
		delete $ss[6];
		delete $ss[7];
		delete $ss[8];
		$header=join "\t",@ss;
		@ll=split /\s+/,$header;
		$header=join "\t",@ll;
		print "$header\n";
		}
	else
		{
		next if($ss[6] ne ".");
		undef @aa;
		$ref=0;
		$alt=0;
		$miss=0;
		$ss[7]=~/DP=(\d+);?/;
		$DP=$1;
		for($i=9;$i<=$#ss;$i++)
			{
			@mm=split /:/,$ss[$i];
			$dep=$mm[2];
			if($dep>=20)
				{
				push @aa,$mm[0];
				@nn=split /\//,$mm[0];
				foreach $nn (@nn)
					{
					if($nn eq "0")
						{
						$ref++;
						}
					if($nn eq "1")
						{
						$alt++;
						}
					if($nn eq ".")
						{
						$miss++;
						}
					}
				}
			else
				{
				$a="./././././.";
				push @aa,$a;
				$miss++;
				$miss++;
				$miss++;
				$miss++;
				$miss++;
				$miss++;
				}
			}
		next if($ref==0 && $alt==0);
		@mm=sort {$a<=>$b} ($ref,$alt);
		if($mm[0]/($mm[0]+$mm[1])>=0.05 && $miss/($miss+$ref+$alt)<=0.5)
			{
			$line=join "\t",@aa;
			print "$ss[0]\t$ss[1]\t$DP\t$ss[3]\t$ss[4]\t$line\n";
			}
		}
	}	
