##reads align
bwa mem -t 50 -M  reference.fasta sample_1.fq.gz sample_2.fq.gz|samtools view --threads 50 -bS - -o sample.bam
samtools flagstat --threads 50 sample.bam >sample.bam.flgstat
samtools sort --threads 50 sample.bam -o sample.sorted.bam
