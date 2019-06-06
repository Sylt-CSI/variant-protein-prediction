library(ggplot2)
library(data.table)


backrub.Relax.Score.Files <- list.files("~/Desktop/scores/testing_ground/", pattern = "*.sc", recursive = T)
backrub.Relax.Score.Files


backrub.Relax.Score.Data.Frame.List <- lapply(backrub.Relax.Score.Files,function(score.File){
  fread(paste0("~/Desktop/scores/testing_ground/",score.File),
        skip=1,
        drop=c(1,23),
        stringsAsFactors = FALSE)
        
})

name.Repetition <- function(mutation.Name,repetitions.Time){
  rep(strsplit(mutation.Name,"/")[[1]][1],times=repetitions.Time)
}

# Error during production makes them separate                          
TNFA.backrub <- melt(backrub.Relax.Score.Data.Frame.List[c(1,3,5)])
TNFA.backrub$L1 <- as.factor(sapply(backrub.Relax.Score.Files[c(1,3,5)],name.Repetition,21000))
TNFA.WILD.TYPE <- melt(backrub.Relax.Score.Data.Frame.List[c(7)])
TNFA.WILD.TYPE$L1 <- rep(strsplit(backrub.Relax.Score.Files[7],"/")[[1]][1],each=39354)

TNFA.backrub.aa <-  rbind(TNFA.backrub,TNFA.WILD.TYPE)
rm(TNFA.backrub.aa)

TNFA.relax <- melt(backrub.Relax.Score.Data.Frame.List[c(2,4,6,8)])
TNFA.relax$L1 <-as.factor(sapply(backrub.Relax.Score.Files[c(2,4,6,8)],name.Repetition,1344))




TNFB.backrub <- melt(backrub.Relax.Score.Data.Frame.List[c(9,11,13,15)])
TNFB.backrub$L1 <- as.factor(sapply(backrub.Relax.Score.Files[c(9,11,13,15)],name.Repetition,21000))
TNFB.relax <- melt(backrub.Relax.Score.Data.Frame.List[c(10,12,14,16)])
TNFB.relax$L1 <-as.factor(sapply(backrub.Relax.Score.Files[c(10,12,14,16)],name.Repetition,1344))


ggplot(data=TNFA.relax,
       aes(x=value, colour = L1)) +
         geom_density() +
      theme_classic() +
      theme(
        axis.ticks.y = element_blank(),
        axis.line.x = element_blank(),
        axis.line.y = element_blank(),
        panel.background = element_rect(fill = NA, color = "black")) +
      facet_wrap(variable ~ .,
                 scales = "free",
                 nrow = 7,
                 ncol = 3) +
      labs(color="Protein") +
      xlab(NULL) +
      ylab("Density")
