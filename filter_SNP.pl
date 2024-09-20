open I, "$ARGV[0]" or die;
while(<I>)
	{
	chomp;
	@ss=split /\t/,$_;
	if(/^#/)
		{
		print "$_\n";
		}
	else
		{
		next if(length($ss[3])>1 || length($ss[4])>1);
		$ss[7]=~/QD=(.+?);/;
		$QD=$1;
		$QUAL=$ss[5];
		$ss[7]=~/FS=(.+?);/;
                $FS=$1;
		$ss[7]=~/MQ=(.+?);/;
		$MQ=$1;
		$ss[7]=~/MQRankSum=(.+?);/;
		$MQRankSum=$1;
		$ss[7]=~/ReadPosRankSum=(.+?);/;
		$ReadPosRankSum=$1;
		if($QD<5)
			{
			$ss[6]=$ss[6].";"."QD5";
			}
		if($QUAL<30)
			{
			$ss[6]=$ss[6].";"."QUAL30";
			}
		if($FS>60)
			{
			$ss[6]=$ss[6].";"."FS60";
			}
		if($MQ<40)
			{
			$ss[6]=$ss[6].";"."MQ40";
			}
		if($MQRankSum<-10)
			{
			$ss[6]=$ss[6].";"."MQRankSum-10";
			}
		if($ReadPosRankSum<-8)
			{
			$ss[6]=$ss[6].";"."ReadPosRankSum-8";
			}
		$ss[6]=~s/^\.;//g;
		$line=join "\t",@ss;
		print "$line\n";
		}
	}
