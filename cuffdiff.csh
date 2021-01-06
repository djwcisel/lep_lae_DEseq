#!/bin/tcsh
#BSUB -n 16
#BSUB -W 900
#BSUB -J cuffdiff
#BSUB -o stdout.%J
#BSUB -e stderr.%J
#BSUB -R rusage[mem=62000]

cuffdiff -p 16 -L GS18L,GSL18R,GS19L,GS19R,GS20L,GS20R,GS21L,GS21R /share/jayoder/djwcisel/cufflinks_output/merged_asm/transcripts.gtf /share/jayoder/djwcisel/samtools_sort/GS18L1.sam,/share/jayoder/djwcisel/samtools_sort/GS18L2.sam,/share/jayoder/djwcisel/samtools_sort/GS18L3.sam, /share/jayoder/djwcisel/samtools_sort/GS18R1.sam,/share/jayoder/djwcisel/samtools_sort/GS18R2.sam,/share/jayoder/djwcisel/samtools_sort/GS18R3.sam, /share/jayoder/djwcisel/samtools_sort/GS19L1.sam,/share/jayoder/djwcisel/samtools_sort/GS19L2.sam,/share/jayoder/djwcisel/samtools_sort/GS19L3.sam, /share/jayoder/djwcisel/samtools_sort/GS19R1.sam,/share/jayoder/djwcisel/samtools_sort/GS19R2.sam,/share/jayoder/djwcisel/samtools_sort/GS19R3.sam, /share/jayoder/djwcisel/samtools_sort/GS20L1.sam,/share/jayoder/djwcisel/samtools_sort/GS20L2.sam,/share/jayoder/djwcisel/samtools_sort/GS20L3.sam, /share/jayoder/djwcisel/samtools_sort/GS20R1.sam,/share/jayoder/djwcisel/samtools_sort/GS20R2.sam,/share/jayoder/djwcisel/samtools_sort/GS20R3.sam, /share/jayoder/djwcisel/samtools_sort/GS21L1.sam,/share/jayoder/djwcisel/samtools_sort/GS21L2.sam,/share/jayoder/djwcisel/samtools_sort/GS21L3.sam, /share/jayoder/djwcisel/samtools_sort/GS21R1.sam,/share/jayoder/djwcisel/samtools_sort/GS21R2.sam,/share/jayoder/djwcisel/samtools_sort/GS21R3.sam
