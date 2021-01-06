library(VennDiagram)
library(RColorBrewer)
library(cummeRbund)

cuff <- readCufflinks() #read in data file
gene.diff <- diffData(genes(cuff)) #Extract differential expression data from variable cuff

significant <- gene.diff[gene.diff$q_value<=0.01,] #Extract significant genes

#Create lists of significant gene_ids from individual stages
GS18L <- significant[significant$sample_1=="GS18L",]
GS18LvGS18R <- GS18L[GS18L$sample_2=="GS18R",]
GS18 <- as.list(GS18LvGS18R[,1])

GS19L <- significant[significant$sample_1=="GS19L",]
GS19LvGS19R <- GS19L[GS19L$sample_2=="GS19R",]
GS19 <- as.list(GS19LvGS19R[,1])

GS20L <- significant[significant$sample_1=="GS20L",]
GS20LvGS20R <- GS20L[GS20L$sample_2=="GS20R",]
GS20 <- as.list(GS20LvGS20R[,1])

GS21L <- significant[significant$sample_1=="GS21L",]
GS21LvGS21R <- GS21L[GS21L$sample_2=="GS21R",]
GS21 <- as.list(GS21LvGS21R[,1])

#Create Venn Diagram
myCol <- brewer.pal(4, "Pastel2")
venn.diagram(
  x = list(GS18, GS19, GS20, GS21),
  category.names = c("GS18" , "GS19", "GS20", "GS21"),
  filename = '#14_venn_diagramm.png',
  output=TRUE,
  # Circles
  lwd = 2,
  lty = 'blank',
  fill = myCol,
  # Numbers
  cex = .6,
  fontface = "bold",
  fontfamily = "sans",
  # Output features
  imagetype="png" ,
  height = 1600 ,
  width = 1600 ,
  resolution = 300,
  # Set names
  cat.cex = 0.6,
  
)
