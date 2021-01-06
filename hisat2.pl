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
	my $command;
	$command = "bsub -R \"rusage[mem=62000]\" -J ${_} -n 8 -W 600 -o /share/jayoder/djwcisel/hisat2_aligned_to_genome/logs/${_}.stdout.%J -e /share/jayoder/djwcisel/hisat2_aligned_to_genome/logs/${_}.stderr.%J \"hisat2 -p 8 -x ../genome/Llaevis.repeatMasked.fa -1 ../trimmed_reads/${_}_1_paired.fq.gz -2 ../trimmed_reads/${_}_2_paired.fq.gz -U ../trimmed_reads/${_}_1_unpaired.fq.gz,../trimmed_reads/${_}_2_unpaired.fq.gz -S ${_}.sam\"";
	system("$command");
}

