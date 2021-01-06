library("cummeRbund")
library("dplyr")

annot<-read.table("path_to_file", sep="\t", header=F, na.string="-")  #read in table 

cuff <- readCufflinks() #read in data file
gene.diff <- diffData(genes(cuff)) #Extract differential expression data from variable cuff

colnames(annot) <- c("gene_id", "transcript_id", "gene_symbo", "evalue") #add column names to variable annot

sorted <- annot[order(annot$evalue),] #sort annot by evalue

unified_annot <- sorted[!duplicated(sorted$gene_id),c(1,3)]

#Create tables with data from individual stages
GS18L <- gene.diff[gene.diff$sample_1=="GS18L",]
GS18LvGS18R <- GS18L[GS18L$sample_2=="GS18R",]

GS19L <- gene.diff[gene.diff$sample_1=="GS19L",]
GS19LvGS19R <- GS19L[GS19L$sample_2=="GS19R",]

GS20L <- gene.diff[gene.diff$sample_1=="GS20L",]
GS20LvGS20R <- GS20L[GS20L$sample_2=="GS20R",]

GS21L <- gene.diff[gene.diff$sample_1=="GS21L",]
GS21LvGS21R <- GS21L[GS21L$sample_2=="GS21R",]

LvsR <- rbind(GS18LvGS18R, GS19LvGS19R, GS20LvGS20R, GS21LvGS21R) #data.frame with only stage appropriate, L vs R comparisons

significant <- LvsR[LvsR$q_value<=0.05,] #Extract significant genes
sig_gene_ids <- unique(unlist(significant$gene_id)) #Isolate only the unique gene ids

#Make sure the gene_ids are in the same order for each stage appropriate LR comparison
rownames(GS18LvGS18R) <- GS18LvGS18R[,1] 
rownames(GS19LvGS19R) <- GS19LvGS19R[,1]
rownames(GS20LvGS20R) <- GS20LvGS20R[,1]
rownames(GS21LvGS21R) <- GS21LvGS21R[,1]

for (i in 1:nrow(GS18LvGS18R)){ 
    if (rownames(GS18LvGS18R)[i] != rownames(GS19LvGS19R)[i] && rownames(GS18LvGS18R)[i] != rownames(GS20LvGS20R)[i] 
        && rownames(GS18LvGS18R)[i] != rownames(GS21LvGS21R)[i]){
        cat("problem") 
    }
}

#Create table with log2_fold_change and q_value data
data <-cbind(
    GS18LvGS18R$log2_fold_change, 
    GS19LvGS19R$log2_fold_change, 
    GS20LvGS20R$log2_fold_change, 
    GS21LvGS21R$log2_fold_change,
    GS18LvGS18R$q_value, 
    GS19LvGS19R$q_value, 
    GS20LvGS20R$q_value, 
    GS21LvGS21R$q_value
)

rownames(data) <- GS18LvGS18R[,1] #add row names to variable data
colnames(data) <- c("GS18_FC", "GS19_FC", "GS20_FC", "GS21_FC","GS18_qvalue", "GS19_qvalue", "GS20_qvalue", "GS21_qvalue") #add column names to variable data

stageAppropriate <- data[sig_gene_ids,] #data slice of only the significant DE genes, between L and R sides

stageAppMat <- as.matrix(stageAppropriate) #stage appropriate, converted to matrix

#Remove genes with a fold change of Inf or -Inf
stageAppMat[which(stageAppMat != "Inf")]
stageAppMat[which(stageAppMat != "-Inf")]

no_inf <- stageAppMat[stageAppMat[,1] != 'Inf' & stageAppMat[,1] != '-Inf',]
no_inf <- no_inf[no_inf[,2] != 'Inf' & no_inf[,2] != '-Inf',]
no_inf <- no_inf[no_inf[,3] != 'Inf' & no_inf[,3] != '-Inf',]
no_inf <- no_inf[no_inf[,4] != 'Inf' & no_inf[,4] != '-Inf',]  

row.names(unified_annot) <- unified_annot[,1] 

unified_annot[row.names(no_inf),]

almost <- cbind(unified_annot[row.names(no_inf),], no_inf)

almost_gene_ids <- sort(unique(unlist(almost$gene_id)))

annot[which(annot$gene_id %in% almost_gene_ids),] 
                                                  
ordered <- annot[order(annot$evalue),]

unified_ordered <- sorted[!duplicated(sorted$transcript_id),]

write.csv(file = "tab1.csv", x = almost)
write.csv(file = "tab2.csv", x = unified_ordered)