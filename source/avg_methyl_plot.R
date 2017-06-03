require(data.table)
require(ggplot2)

dt1 <- fread("data/avg_methyl.csv")
unique(substr(dt1$feature, 1, 5))

pr <- subset(dt1, 
             substr(dt1$feature, 1, 8) == "Promoter")
pr$reg <- "Promoter"

strt <- subset(dt1, 
               substr(dt1$feature, 1, 2) == "5'")
strt$reg <- "5' UTR"

exn <- subset(dt1, 
              substr(dt1$feature, 1, 4) == "Exon")
exn$reg <- "Exon"

itrn <- subset(dt1, 
               substr(dt1$feature, 1, 6) == "Intron")
itrn$reg <- "Intron"

endd <- subset(dt1, 
               substr(dt1$feature, 1, 2) == "3'")
endd$reg <- "3' UTR"

iitr <- subset(dt1, 
               dt1$feature == "Distal Intergenic")
iitr$reg <- "Intergenic"

dt2 <- rbindlist(list(pr, strt, exn, itrn, endd, iitr))
dt2$feature <- NULL
dt2

dt3 <- melt.data.table(dt2,
                       id.vars = 4,
                       measure.vars = 1:3)
dt3

out <- aggregate(x = dt3$value, 
          by = list(dt3$reg,
                    dt3$variable),
          FUN = "mean",
          na.rm = TRUE)
names(out) <- c("Region",
                "Treatment",
                "Mean")
out$SD <- aggregate(x = dt3$value, 
                    by = list(dt3$reg,
                              dt3$variable),
                    FUN = "sd",
                    na.rm = TRUE)$x
out
out$Mean <- 100*out$Mean
unique(out$Region)
out$Region <- factor(out$Region, 
                     levels = c("Promoter",
                                "5' UTR",
                                "Exon",
                                "Intron",
                                "3' UTR",
                                "Intergenic"))

# Plot----
tiff(filename = "tmp/avg_methyl.tiff",
     height = 3,
     width = 5,
     units = 'in',
     res = 300,
     compression = "lzw+p")
ggplot(out,
       aes(x = Region,
           y = Mean,
           group = Treatment,
           fill = Treatment)) +
  geom_bar(position = position_dodge(),
           stat="identity") +
  scale_y_continuous("Average Methylation (%)") +
  theme_bw()
graphics.off()