#!/bin/tcsh
#BSUB -n 1
#BSUB -W 900
#BSUB -J gffread
#BSUB -o stdout.%J
#BSUB -e stderr.%J

gffread /share/jayoder/brent/noS_cufflinks_output/merged_asm/merged.gtf -g /share/jayoder/brent/genome/Llaevis.repeatMasked.fa -w merged_noS_cufflinks.fa
