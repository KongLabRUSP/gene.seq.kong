# Project: RNA-seq data visualization, 8-week study, AOM-DSS-Curcumin
# Author: Davit Sargsyan
# Created: 04/26/2017
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
# 8 Weeks
f1 <- "data/8wk DSS-Control.csv"
f2 <- "data/8wk DSSCur-DSS.csv"

# Positive vs. negative controls
dt1 <- fread(f1)[, c(1, 3)]
names(dt1) <- c("gene",
                "dlog2.ctrl.dss")
# Keep only genes with at least 2-fold change
dt1$dlog2.ctrl.dss <- as.numeric(dt1$dlog2.ctrl.dss)
dt1 <- subset(dt1,
              abs(dlog2.ctrl.dss) >= 1 &
                is.finite(dlog2.ctrl.dss))
summary(dt1)
duplicated(dt1$gene)
dt1

# Positive control vs. treatment
dt2 <- fread(f2)[, 1:2]
names(dt2) <- c("gene",
                "dlog2.dss.cur")
# Keep only genes with at least 2-fold change
dt2$dlog2.dss.cur <- as.numeric(dt2$dlog2.dss.cur)
dt2 <- subset(dt2,
              abs(dlog2.dss.cur) >= 1 &
                is.finite(dlog2.dss.cur))
duplicated(dt1$gene)
dt2

# Merge the data----
dt3 <- merge(dt1,
             dt2,
             by = "gene")
dt3
dt3$gene[duplicated(dt3$gene)]
length(unique(dt3$gene))

# ATTN! REMOVED DUPLICATES. ASK RENYI!
# Multiple records for  "Hba-a1"
dt3 <- dt3[!duplicated(dt3$gene), ]

# Melt the data----
dt4 <- melt.data.table(data = dt3,
                       id.vars = "gene",
                       measure.vars = c("dlog2.ctrl.dss",
                                        "dlog2.dss.cur"))

# Set anything over 8-fold change (i.e. value > 3) to 3
dt4$value[dt4$value > 3] <- 3
dt4$value[dt4$value < -3] <- -3
summary(dt4$value)

# Sort values----
length(unique(dt4$gene))
# dt4$gene <- factor(dt4$gene)
lvls <- dt3$gene
lvls <- lvls[order(dt3$dlog2.ctrl.dss)]
dt4$gene <- factor(dt4$gene,
                   levels = lvls)

levels(dt4$variable) <- c("DSS - Negative Control",
                          "DSSCur - DSS")
summary(dt4)
setkey(dt4, gene)

#*****************************************************
# Heatmap----
# tiff(filename = "tmp/heatmap1.tiff",
#      height = 5,
#      width = 6,
#      units = 'in',
#      res = 300,
#      compression = "lzw+p")
png(filename = "tmp/heatmap_8w_dss.png",
     height = 6,
     width = 6,
     units = 'in',
     res = 300)
ggplot(data = dt4) +
  geom_tile(aes(x = variable,
                y = gene,
                fill = value),
            color = "black") +
  # geom_tile(aes(x = variable,
  #               y = gene,
  #               fill = value)) +
  scale_fill_gradient2(low = "red", 
                       high = "green", 
                       mid = "black", 
                       midpoint = 0, 
                       limit = c(-3, 3), 
                       space = "Lab", 
                       name = "Log2 Change") +
  scale_x_discrete("Treatment") + 
  scale_y_discrete("Gene") +
  ggtitle("8 Weeks DSS-Curcumin")  +
  theme(axis.text.x = element_text(angle = 0))
graphics.off()

#*****************************************************
# Venn Diagram: Up/Down----
nLabCol <- 3

l1 <- unique(dt1$gene[dt1$dlog2.ctrl.dss < 0])
l2 <- unique(dt2$gene[dt2$dlog2.dss.cur > 0])

xx <- unique(c(l1, l2))
lbls <- l1[l1 %in% l2]
lbls <- lbls[order(lbls)]
if (floor(length(lbls)/nLabCol) < length(lbls)/nLabCol) {
  lbls <- c(lbls,
            rep("", 
                nLabCol*ceiling(length(lbls)/nLabCol) - length(lbls))) 
}
lbls <- matrix(lbls,
               ncol = nLabCol)

png(filename = "tmp/venn_up_down_8w_dss.png",
     height = 5,
     width = 10,
     units = 'in',
     res = 300)
p1 <- venn.diagram(x = list(A = which(xx %in% l1),
                            B = which(xx %in% l2)),
                   filename = NULL,
                   fill = c("red", "green"),
                   alpha = c(0.5, 0.5),
                   compression = "lzw+p",
                   main = "8 Weeks DSS-Curcumin",
                   sub = "A (Upregulation): (DSS) < (Negative Control)\nB (Downlregulation): (DSS+Cur) > (DSS)")
grid.arrange(gTree(children = p1),
             tableGrob(lbls),
             nrow = 1)
graphics.off()

# Venn Diagram: Down/Up----
nLabCol <- 3

l1 <- unique(dt1$gene[dt1$dlog2.ctrl.dss > 0])
l2 <- unique(dt2$gene[dt2$dlog2.dss.cur < 0])

xx <- unique(c(l1, l2))
lbls <- l1[l1 %in% l2]
lbls <- lbls[order(lbls)]
if (floor(length(lbls)/nLabCol) < length(lbls)/nLabCol) {
  lbls <- c(lbls,
            rep("", 
                nLabCol*ceiling(length(lbls)/nLabCol) - length(lbls))) 
}
lbls <- matrix(lbls,
               ncol = nLabCol)

png(filename = "tmp/venn_down_up_8w_dss.png",
    height = 5,
    width = 10,
    units = 'in',
    res = 300)
p1 <- venn.diagram(x = list(A = which(xx %in% l1),
                            B = which(xx %in% l2)),
                   filename = NULL,
                   fill = c("red", "green"),
                   alpha = c(0.5, 0.5),
                   compression = "lzw+p",
                   main = "8 Weeks DSS-Curcumin",
                   sub = "A (Downlregulation): (DSS) > (Negative Control)\nB (Upregulation): (DSS+Cur) < (DSS)")
grid.arrange(gTree(children = p1),
             tableGrob(lbls),
             nrow = 1)
graphics.off()