#!/bin/tcsh
#BSUB -n 8
#BSUB -W 30:15
#BSUB -J merge
#BSUB -o stdout.%J
#BSUB -e stderr.%J

cuffmerge -s ../genome/Llaevis.repeatMasked.fa -p 8 gtf.list
