#!/bin/bash

set -euo pipefail

../minimap2 --zmw-hit-only --eqx -Y -ax map-pb fake.ccs.fasta 25.fastq | samtools view -b -F 4 | samtools sort > tmp.bam 

pbbamify fake.ccs.fasta median.bam --input tmp.bam --output pb.tmp.bam   



../minimap2 --zmw-hit-only --eqx -Y -ax map-pb fake.ccs.fasta 25.fastq | samtools view -b -F 4 | samtools sort | pbbamify fake.ccs.fasta median.bam  >  pb.pipe.bam 
