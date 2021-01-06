library("cummeRbund")
library("gplots")
library("RColorBrewer")

cuff <- readCufflinks() #read in data file
gene.diff <- diffData(genes(cuff)) #Extract differential expression data from variable cuff

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

significant <- LvsR[LvsR$q_value<=0.01,] #Extract significant genes
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

#Create table with log2_fold_change data
data <-cbind(GS18LvGS18R$log2_fold_change, GS19LvGS19R$log2_fold_change, GS20LvGS20R$log2_fold_change, GS21LvGS21R$log2_fold_change)

rownames(data) <- GS18LvGS18R[,1] #add row names to variable data
colnames(data) <- c("GS18", "GS19", "GS20", "GS21") #add column names to variable data

stageAppropriate <- data[sig_gene_ids,] #data slice of only the significant DE genes, between L and R sides

stageAppMat <- as.matrix(stageAppropriate) #stage appropriate, converted to matrix

#Remove genes with a fold change of Inf or -Inf
stageAppMat[which(stageAppMat != "Inf")]
stageAppMat[which(stageAppMat != "-Inf")]

no_inf <- stageAppMat[stageAppMat[,1] != 'Inf' & stageAppMat[,1] != '-Inf',]
no_inf <- no_inf[no_inf[,2] != 'Inf' & no_inf[,2] != '-Inf',]
no_inf <- no_inf[no_inf[,3] != 'Inf' & no_inf[,3] != '-Inf',]
no_inf <- no_inf[no_inf[,4] != 'Inf' & no_inf[,4] != '-Inf',]  

#Remove genes that were identified as flippers
minus_flippers <- no_inf[-which(rownames(no_inf)=="XLOC_001527"),]
minus_flippers <- minus_flippers[-which(rownames(minus_flippers)=="XLOC_002182"),]
minus_flippers <- minus_flippers[-which(rownames(minus_flippers)=="XLOC_003507"),]
minus_flippers <- minus_flippers[-which(rownames(minus_flippers)=="XLOC_008845"),]
minus_flippers <- minus_flippers[-which(rownames(minus_flippers)=="XLOC_010433"),]
minus_flippers <- minus_flippers[-which(rownames(minus_flippers)=="XLOC_011957"),]
minus_flippers <- minus_flippers[-which(rownames(minus_flippers)=="XLOC_012208"),]
minus_flippers <- minus_flippers[-which(rownames(minus_flippers)=="XLOC_012955"),]
minus_flippers <- minus_flippers[-which(rownames(minus_flippers)=="XLOC_017915"),]
minus_flippers <- minus_flippers[-which(rownames(minus_flippers)=="XLOC_018452"),]
minus_flippers <- minus_flippers[-which(rownames(minus_flippers)=="XLOC_023161"),]
minus_flippers <- minus_flippers[-which(rownames(minus_flippers)=="XLOC_023530"),]
minus_flippers <- minus_flippers[-which(rownames(minus_flippers)=="XLOC_031155"),]

#Create color palette
my_palette <- colorRampPalette(c("#C66D29", "#CEC9C5", "#3470AE"))(n = 10)
tokarz_colors <- colorRampPalette(c("#00CCFF", "#000000", "#FFFF00FF"))(n = 299)

blues <- colorRampPalette(c("#00ffff", "#00576D"))(n = 100)
yellows <- colorRampPalette(c("#5E5E00", "#FFFF00FF"))(n = 100)
blacks <- colorRampPalette(c("#00576D", "#000000", "#5E5E00"))(n = 99)

brighter <- c(blues, blacks, yellows)

col_breaks = c(seq(-7,-1,length=100), # for blue, negative values
               seq(-.99,.99,length=100), # for black          
               seq(1,7,length=100)) #for yellow, positive values

col_breaks <- sort(col_breaks)

#Create heatmap
heatmap.2(minus_flippers,
          col = brighter,
          density.info = "none",
          main = "log2 Fold Change\n Left versus Right",
          trace="none",
          Colv=FALSE,
          labRow = '',
          dendrogram = "row",
          margins =c(5,15),
          keysize = 2.5,
          breaks = col_breaks
)