# DESeq Lepidobatrachus laevis SIM2 Manuscript

Steps used to get from raw RNAseq to cuffdiff
bsub commands run on NCSU HPC
R and other commands run on local machine

## Trim reads

```` 
>> bsub < trim.pl
````

## Align reads to genome

````
>> bsub < hisat2.pl
````

## Remove soft-clipping from hisat alignment sam files

````
>> bsub < remove_soft-clipping.pl
````

## Sort SAM files using samtools

````
>> samtools_sort.pl
````

## Run DESeq using CuffDiff

````
>> bsub < cuffdiff.csh
````

## Run cufflinks to generate genomic coordinates (gff or gtf) of predicted genes

````
>> bsub < cufflinks.pl
````

## Cuffmerge to get a single gtf file

````
>> bsub < cuffmerge.csh
````

## GFFRead to get transcript sequences from predicted genes

````
>> bsub < gffread.csh
````

The resulting transcripts files were assigned human gene symbols by parsing tblastn searches

````
>> wget ftp://ftp.ensembl.org/pub/release-102/fasta/homo_sapiens/pep/Homo_sapiens.GRCh38.pep.all.fa.gz
>> gunzip Homo_sapiens.GRCh38.pep.all.fa.gz
>> makeblastdb -in Homo_sapiens.GRCh38.pep.all.fa.gz -dbtype prot
>> tblasn --query merged_noS_cufflinks.fa -db Homo_sapiens.GRCh38.pep.all.fa --max_target_seqs 1 --evalue 1e-8 > merged_noS_against_human_all.bls
>> blastparse.pl merged_noS_against_human_all.bls > gene_annotation.tsv
````

## R scripts used to analyze cuffdiff data with cummeRbund

Heatmap.R
venn_diagram.R
supplemental_table_maker.R

