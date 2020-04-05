#!/bin/bash

set -euo pipefail

../minimap2 --zmw-hit-only --eqx -Y -ax map-pb fake.ccs.fasta median.fastq | samtools view -b -F 4 | samtools sort | pbbamify fake.ccs.fasta median.bam  >  pb.pipe.bam 

../minimap2 --eqx -Y -ax map-pb fake.ccs.fasta median.fastq | samtools view -b -F 4 | samtools sort | pbbamify fake.ccs.fasta median.bam  >  pb.2.pipe.bam 

for f in pb.pipe.bam pb.2.pipe.bam; do 
	echo $f
	samtools view $f | awk '{print $1"\t"$3}' | sort | uniq  > $f.summary
done 

diff pb.pipe.bam.summary pb.2.pipe.bam.summary  > diff.sum


