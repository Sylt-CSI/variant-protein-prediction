library(data.table)
setwd("..")

# GAVIN
variants.GAVIN <- read.table(gzfile("gavin_r0.5_calibvars.plusbenign.cadd_v1.4annot.gnomad.tsv.gz"), sep="\t", header=T, stringsAsFactors = F)
potential.Traps.Genes.Within.GAVIN <- subset(variants.GAVIN, gene == "TNFRSF1A" & effect == "missense_variant")

vep <- potential.Traps.Genes.Within.GAVIN[,c(2:5)]
vep[,3] <- vep[,2]
vep[,4]<- paste(potential.Traps.Genes.Within.GAVIN[,4],potential.Traps.Genes.Within.GAVIN[,5],sep="/")
vep[,5] <- rep("+",nrow(potential.Traps.Genes.Within.GAVIN))
write.table(vep, file="TRAPS_vep.vep" ,sep = "  ", col.names=F, row.names=F, quote = F)

# Result from VEP about GAVIN
gavin_traps <- read.table("GAVIN_TRAPS_missense_variant.txt",header = T,stringsAsFactors = F)

# gnomAD
genomeAD <- read.csv("gnomAD_v2.1.1_ENSG00000067182_2019_04_09_15_57_03.csv",stringsAsFactors = F)
useful.Gnomad.Columns <- genomeAD[genomeAD$Annotation=="missense_variant",c(2,4,5,9,10)]

# INFEVERS
tnfrsf1a <- fread("TNFRSF1A.csv",header=T)
missense.Mutations <- tnfrsf1a[grep("p.[A-Z][a-z]{2}[0-9]{1,3}[A-Z][a-z]{2}",tnfrsf1a$`protein name`),]
tnfrsf1a.Missense.Mutations.Infevers = missense.Mutations[,c(3,4,7,8)]


gavin_traps$missense.Mutation<- lapply(gavin_traps$HGVSp,function(HGVSp){
  strsplit(HGVSp,"\\.")[[1]][3]
})

potential.Traps.Genes.Within.GAVIN$vep_identifier<- apply(potential.Traps.Genes.Within.GAVIN,1,function(row){
  paste(row[2],row[3],paste(row[4],row[5],sep="/"),sep = "_")
})

intersected.Gavin.Data <- data.frame(
  intersect(potential.Traps.Genes.Within.GAVIN$vep_identifier,gavin_traps$Uploaded_variation),
  potential.Traps.Genes.Within.GAVIN[potential.Traps.Genes.Within.GAVIN$vep_identifier %in% intersect(potential.Traps.Genes.Within.GAVIN$vep_identifier,gavin_traps$Uploaded_variation),"group"])
merged.Gavin.Data <- merge(gavin_traps,intersected.Gavin.Data,by=1,all = T)
colnames(merged.Gavin.Data)[66] <- "Classification"


# merged.Gavin.Data[merged.Gavin.Data$Uploaded_variation=="12_6442654_GC/TG",1]
# intersected.Gavin.Data[intersected.Gavin.Data$X1=="12_6442989_G/A",]
# potential.Traps.Genes.Within.GAVIN[potential.Traps.Genes.Within.GAVIN$vep_identifier=="12_6442989_G/A",]


useful.Gnomad.Columns$missense.Mutation <- lapply(useful.Gnomad.Columns$Consequence,
                                                  function(conse){
                                                    strsplit(conse,"\\.")[[1]][2]
                                                  })

tnfrsf1a.Missense.Mutations.Infevers$missense.Mutation <- lapply(tnfrsf1a.Missense.Mutations.Infevers$`protein name`,
                                            function(protmut){
                                              strsplit(protmut,"\\.")[[1]][2]
                                            })




gnomad.Missense.TNFRSF1A <- data.frame(cbind(missense.Mutation=unlist(useful.Gnomad.Columns$missense.Mutation),Classification=as.vector(rep(NA,each=length(useful.Gnomad.Columns$missense.Mutation)))))
traps_gavin <- merged.Gavin.Data[,c("missense.Mutation","Classification")]
monte <- tnfrsf1a.Missense.Mutations.Infevers[,c(5,4)]

tnfrsf1a.Missense<- rbind(monte,traps_gavin,gnomad.Missense.TNFRSF1A)
write.table(tnfrsf1a.Missense,"non_filtered_tnfrsf1a_muts.tsv", sep = "\t")