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
	my $sam = "${_}.sam";
	$command = "bsub -J ${_} -n 1 -W 600 -o /share/jayoder/djwcisel/no_soft-clipping/logs/${_}.stdout.%J -e /share/jayoder/djwcisel/no_soft-clipping/logs/${_}.stderr.%J \"awk 'BEGIN {OFS="\t"} {split($6,C,/[0-9]*/); split($6,L,/[SMDIN]/); if (C[2]=="S") {$10=substr($10,L[1]+1); $11=substr($11,L[1]+1)}; if (C[length(C)]=="S") {L1=length($10)-L[length(L)-1]; $10=substr($10,1,L1); $11=substr($11,1,L1); }; gsub(/[0-9]*S/,"",$6); print}' $sam > /share/jayoder/djwcisel/no_soft-clipping/${sam}.noS.sam\"";
	system("$command");
}
