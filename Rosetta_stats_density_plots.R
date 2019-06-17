library(ggplot2)
library(data.table)


backrub.Relax.Score.Files <- list.files("scores/testing_ground/", pattern = "*.sc", recursive = T)
backrub.Relax.Score.Files

new.Names <- c("TNFA GLU 138 ALA",
               "TNFA GLU 138 ALA",
               "TNFA CYS 62 GLY",
               "TNFA CYS 62 GLY",
               "TNFA PHE 141 ILE",
               "TNFA PHE 141 ILE",
               "TNFA wild type",
               "TNFA wild type",
               "TNFB GLU 138 ALA",
               "TNFB GLU 138 ALA",
               "TNFB CYS 62 GLY",
               "TNFB CYS 62 GLY",
               "TNFB PHE 141 ILE",
               "TNFB PHE 141 ILE",
               "TNFB wild type",
               "TNFB wild type")

backrub.Relax.Score.Data.Frame.List <- lapply(backrub.Relax.Score.Files,function(score.File){
  fread(paste0("~/Desktop/scores/testing_ground/",score.File),
        skip=1,
        drop=c(1,23),
        stringsAsFactors = FALSE)
        
})

# name.Repetition <- function(mutation.Name,repetitions.Time){
#   rep(paste(strsplit(mutation.Name,"_|/")[[1]][2:3],collapse = " "),times=repetitions.Time)
# }

# Error during production makes them separate                          
TNFA.backrub <- melt(backrub.Relax.Score.Data.Frame.List[c(1,3,5)])
TNFA.backrub$L1 <- as.factor(sapply(new.Names[c(1,3,5)],rep, 21000))
TNFA.Backrub.WILD.TYPE <- melt(backrub.Relax.Score.Data.Frame.List[c(7)])
TNFA.Backrub.WILD.TYPE$L1 <- rep(new.Names[7],each=39354)
TNFA.backrub <-  rbind(TNFA.backrub,TNFA.Backrub.WILD.TYPE)
TNFA.backrub$L2 <- as.character("backrub_Alpha")

TNFA.relax <- melt(backrub.Relax.Score.Data.Frame.List[c(2,4,6,8)])
TNFA.relax$L1 <- as.factor(sapply(new.Names[c(2,4,6,8)], rep, times=1344))
# TNFA.relax$L1 <-as.factor(sapply(backrub.Relax.Score.Files[c(2,4,6)],name.Repetition,1344))
# TNFA.Relax.WILD.TYPE <- melt(backrub.Relax.Score.Data.Frame.List[8])
# TNFA.Relax.WILD.TYPE$L1 <- rep(paste(strsplit(backrub.Relax.Score.Files[8],"_|/")[[1]][2:4],collapse = " "),each=1344)
# TNFA.relax <- rbind(TNFA.relax,TNFA.Relax.WILD.TYPE)
TNFA.relax$L2 <- as.character("relax_Alpha")

TNFB.backrub <- melt(backrub.Relax.Score.Data.Frame.List[c(9,11,13,15)])
TNFB.backrub$L1 <- as.factor(sapply(new.Names[c(9,11,13,15)],rep ,21000))
TNFB.backrub$L2 <- as.character("backrub_Beta")

TNFB.relax <- melt(backrub.Relax.Score.Data.Frame.List[c(10,12,14,16)])
TNFB.relax$L1 <-as.factor(sapply(new.Names[c(10,12,14,16)],rep,1344))
# TNFB.Relax.WILD.TYPE <- melt(backrub.Relax.Score.Data.Frame.List[16])
# TNFB.Relax.WILD.TYPE$L1 <- rep(paste(strsplit(backrub.Relax.Score.Files[16],"_|/")[[1]][2:4],collapse = " "),each=1344)
# TNFB.relax <- rbind(TNFB.relax,TNFB.Relax.WILD.TYPE)
TNFB.relax$L2 <-as.character("relax_Beta")

combined.TNF.Backrub.Relax.Data <- list(TNFA.backrub,
                                       TNFB.backrub,
                                       TNFA.relax,
                                       TNFB.relax)
lapply(combined.TNF.Backrub.Relax.Data, function(TNF.Group){
  ggplot(data=TNF.Group,
         aes(x=value, colour = L1)) +
    geom_density() +
    theme_classic() +
    theme(
      axis.ticks.y = element_blank(),
      axis.line.x = element_blank(),
      axis.line.y = element_blank(),
      panel.background = element_rect(fill = "transparent", color = "black"), # bg of the panel
      plot.background = element_rect(fill = "transparent", color = NA), # bg of the plot
      panel.grid.major = element_blank(), # get rid of major grid
      panel.grid.minor = element_blank(), # get rid of minor grid
      legend.background = element_rect(fill = "transparent"), # get rid of legend bg
      legend.box.background = element_rect(fill = "transparent"), # get rid of legend panel bg
      legend.key = element_rect(fill = "transparent", colour = NA), # get rid of key legend fill, and of the surrounding
      axis.line = element_line(colour = "black") # adding a black line for x and y axis
      ) +
    facet_wrap(variable ~ .,
               scales = "free",
               nrow = 7,
               ncol = 3) +
    labs(color="Protein") +
    xlab(NULL) +
    ylab("Density")
    print(as.character(TNF.Group$L2[1]))
  ggsave(paste0("scores/testing_ground/",as.character(TNF.Group$L2[1]),"_plot.pdf"),width=9, height = 9)
})

