#!/bin/bash

set -euo pipefail

../minimap2 --zmw-hit-only --eqx -Y -ax map-pb fake.ccs.fasta median.fastq | samtools view -b -F 4 | samtools sort | pbbamify fake.ccs.fasta median.bam  >  pb.pipe.bam 

../minimap2 --eqx -Y -ax map-pb fake.ccs.fasta median.fastq | samtools view -b -F 4 | samtools sort | pbbamify fake.ccs.fasta median.bam  >  pb.keep.all.pipe.bam 

for f in pb.pipe.bam pb.keep.all.pipe.bam; do 
	echo $f
	samtools view $f | awk '{print $1"\t"$3}' | sort | uniq  > $f.summary
	samtools view -c $f
done 

diff pb.pipe.bam.summary pb.keep.all.pipe.bam.summary  > diff.sum


