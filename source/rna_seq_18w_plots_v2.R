# Project: RNA-seq data visualization
# Author: Davit Sargsyan
# Created: 04/26/2017
# Last Modified: 05/30/2017
# Sources: 
# http://www.sthda.com/english/wiki/ggplot2-quick-correlation-matrix-heatmap-r-software-and-data-visualization
# http://www.sthda.com/english/wiki/be-awesome-in-ggplot2-a-practical-guide-to-be-highly-effective-r-software-and-data-visualization#at_pco=smlwn-1.0&at_si=5928226b26b56b2a&at_ab=per-2&at_pos=0&at_tot=1
#*****************************************************
# Header----
require(data.table)
require(ggplot2)
require(gridExtra)
require(VennDiagram)

# Read data----
# 18 Weeks
f1 <- "data/data_05302017/Genes in common 18wk AOMDSS.csv"

# Positive vs. negative controls
dt1 <- fread(f1)
dt1$V4 <- NULL

# Melt the data----
dt2 <- melt.data.table(data = dt1,
                       id.vars = c("symbol", "p1"),
                       measure.vars = c("AOMDSS-CON",
                                        "AOMDSSCUR-AOMDSS"))
dt2

# Sort values----
dt2$symbol <- factor(dt2$symbol)
dt2$p1 <- factor(dt2$p1)
dt2$variable <- factor(dt2$variable)
summary(dt2)

#*****************************************************
# Heatmap----
# tiff(filename = "tmp/heatmap1.tiff",
#      height = 5,
#      width = 6,
#      units = 'in',
#      res = 300,
#      compression = "lzw+p")
png(filename = "tmp/heatmap_18w.png",
     height = 6,
     width = 4,
     units = 'in',
     res = 300)
ggplot(data = dt2) +
  geom_tile(aes(x = variable,
                y = symbol,
                fill = value)) +
  scale_fill_gradient2(low = "red", 
                       high = "green", 
                       mid = "black", 
                       midpoint = 0, 
                       limit = c(-3, 3), 
                       space = "Lab", 
                       name = "Log2 Change") +
  scale_x_discrete("Treatment") + 
  scale_y_discrete("Gene") +
  ggtitle("18 Weeks")  +
  theme(axis.text.x = element_text(angle = 0))
graphics.off()

#*****************************************************
# Venn Diagram: Up/Down----
l1 <- 1:184
l2 <- 1:76
l3 <- 1:377

png(filename = "tmp/venn_18w.png",
     height = 2,
     width = 2,
     units = 'in',
     res = 300)
p1 <- venn.diagram(x = list(A = c(l1, l2 + length(l1)),
                            B = c(l2 + length(l1),
                                  l3 + length(l1) + length(l2))),
                   filename = NULL,
                   fill = c("light blue", "grey"),
                   alpha = c(0.5, 0.5),
                   compression = "lzw+p",
                   main = "18 Weeks")
grid.arrange(gTree(children = p1))
graphics.off()