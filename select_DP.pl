open I, "$ARGV[0]" or die;
while(<I>)
	{
	chomp;
	@ss=split;
	if($ss[2]<56673)
		{
		print "$_\n";
		}
	}
