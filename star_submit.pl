#!/usr/bin/perl

use strict;
use warnings;

my @samples = qw(
				GS18L1
				GS18L2
				GS18L3
				GS18R1
				GS18R2
				GS18R3
				GS19L1
				GS19L2
				GS19L3
				GS19R1
				GS19R2
				GS19R3
				GS20L1
				GS20L2
				GS20L3
				GS20R1
				GS20R2
				GS20R3
				GS21L1
				GS21L2
				GS21L3
				GS21R1
				GS21R2
				GS21R3
				);

foreach (@samples) {
	my $j = 1; #forward/reverse reads
	my $command;
	while ($j <= 2){
		my $left_reads = "${_}_${j}_paired.fq.gz";
		my $right_reads = "${_}_${j}_paired.fq.gz";
		$command = "bsub -R \"rusage[mem=62000]\" -J ${_} -n 8 -W 600 -o /share/jayoder/djwcisel/star_aligned_to_genome/logs/${_}_${j}.stdout.%J -e /share/jayoder/djwcisel/star_aligned_to_genome/logs/${_}_${j}.stderr.%J \"STAR --runMode alignReads --outFileNamePrefix ${_} --runThreadN 8 --genomeDir ../genome --readFilesIn ../trimmed_reads/$left_reads ../trimmed_reads/$right_reads --readFilesCommand gunzip -c --outSAMstrandField intronMotif\"";
		$j++;
	}
	system("$command");
}
