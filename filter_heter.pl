open I, "$ARGV[0]" or die;
$file=<I>;
print "$file";
$file=<I>;
print "$file";
$file=<I>;
print "$file";
while(<I>)
	{
	chomp;
	@ss=split;
	$H=0;
	$ALL=0;
	for($i=4;$i<=$#ss;$i++)
		{
		$a=0;
		$b=0;
		@mm=split /\//,$ss[$i];
		foreach $mm (@mm)
			{
			if($mm==0)
				{
				$a++;
				}
			if($mm==1)
				{
				$b++;
				}
			}
		if(($a>=2 && $a<=4) ||  ($b>=2 && $b<=4))
			{
			$H++;
			}
		$ALL++;
		}
	next if($H/$ALL>0.8);
	print "$_\n";
	}
