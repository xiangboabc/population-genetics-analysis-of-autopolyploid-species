##call SNP
## call SNP for each sample and each chromosome
gatk HaplotypeCaller -R reference.fasta -I sample.sorted.bam -ERC GVCF  --sample-ploidy 6 -L Chr1 -O sample_Chr1.g.vcf
## combind all samples with the same chromosome
gatk GenomicsDBImport --reader-threads 7 -V sample_Chr1.g.vcf -V 523_Chr1.g.vcf -V A1905_Chr1.g.vcf -V daja_Chr1.g.vcf -V GN0442_Chr1.g.vcf -V M11_Chr1.g.vcf -V M9_Chr1.g.vcf -V MZ9_Chr1.g.vcf -V T089_Chr1.g.vcf -V T251_Chr1.g.vcf --genomicsdb-workspace-path my_database_Chr1 -L Chr1
## generate the SNP vcf file for each chromosome
gatk GenotypeGVCFs -R reference.fasta -V gendb://my_database_Chr1 -allow-old-rms-mapping-quality-annotation-data -O SNP_Chr1.vcf
## filtering SNP based on SNP quality, excessive heterozygosity SNP sites, missing rate, and maf
perl filter_SNP.pl /sharedata/home/xbzhang/ganshu/gvcf_306/vcf_file/SNP_Chr1.vcf|perl convert_jvcf.pl -|perl filter_heter.pl - >SNP_filter_Chr1.vcf

## filtering SNPs with excessive high reads coverage
perl select_DP.pl SNP_filter_Chr1.vcf >SNP_filter_Chr1_DP.vcf


