# |------------------------------------|
# | Project:      Anne's RNA Seq Study |
# | Script:       Mixed Effect model   |
# | Scientist:    Anne                 |  
# |               Ran                  |
# |               Davit                |           |
# | Created:      07/18/2017           |
# |------------------------------------|
# Header----
# Comparisons:
# a. UVB (positive control) vs. Control (negative)
# b. UA (treatment 1) vs. UVB (treatment 2)
# c. SFN vs. UVB

# Files: 
# 1. /home/administrator/Documents/Anne_RNASeq_05302017/Docs/WeekFinal/WeekFinal Data/WeekFinal gene_exp.xlsx
# 2. /home/administrator/Documents/Anne_RNASeq_05302017/Docs/Week15/Week15 gene_exp.xlsx

# Source: 
# 1. http://www.sthda.com/english/wiki/ggplot2-quick-correlation-matrix-heatmap-r-software-and-data-visualization

# Load packages
require(data.table)
require(ggplot2)

# Load data
# Positive vs. negative controls
dt1 <- fread("data/Anne_RNASeq_05302017_Docs/WeekFinal gene_exp.csv")

length(unique(dt1$test_id))
length(unique(dt1$gene))
# NOTE: there are about 100 non-unique genes: remove for now
names(dt1)
dt2 <- unique(subset(dt1, 
                     status == "OK",
                     select = c("gene",
                                "sample_1",
                                "sample_2",
                                "log2(fold_change)")))
dt2

# Separate by comparisons and melt
unique(dt2$sample_1)
unique(dt2$sample_2)

# a. UVB vs Control
uvb.ctrl <- subset(dt2,
                   sample_1 == "Control" &
                     sample_2 == "UVB")
length(unique(uvb.ctrl$gene))
uvb.ctrl$contrast <- "UVB - Control"
uvb.ctrl[, sample_1 := NULL]
uvb.ctrl[, sample_2 := NULL]
uvb.ctrl

# b. UA vs. UVB 
#    NOTE: UVB vs. UA has no data!
ua.uvb <- subset(dt2,
                 sample_1 == "UVB" &
                   sample_2 == "UA")
length(unique(ua.uvb$gene))
ua.uvb$contrast <- "UA - UVB"
ua.uvb[, sample_1 := NULL]
ua.uvb[, sample_2 := NULL]
ua.uvb

# c. SFN vs. UVB
sfn.uvb <- subset(dt2,
                  sample_1 == "UVB" &
                    sample_2 == "SFN")
length(unique(sfn.uvb$gene))
sfn.uvb$contrast <- "SFN - UVB"
sfn.uvb[, sample_1 := NULL]
sfn.uvb[, sample_2 := NULL]
sfn.uvb

# Combine all 3 sets----
dt3 <- rbindlist(list(uvb.ctrl,
                      ua.uvb,
                      sfn.uvb))
dt3$`log2(fold_change)` <- as.numeric(dt3$`log2(fold_change)`)

# Remove NAs, NaNs and infinities
dt3 <- dt3[!is.na(dt3$`log2(fold_change)`), ]
dt3 <- dt3[is.finite(dt3$`log2(fold_change)`), ]

dt3$contrast <- factor(dt3$contrast,
                       levels = unique(dt3$contrast))
summary(dt3)

# Remove eevrything with less than 2-fold change
dt3 <- dt3[abs(dt3$`log2(fold_change)`) >= 1]

# Set everything above 8-fold cahnge to 8-fold cahnge
dt3$`log2(fold_change)`[dt3$`log2(fold_change)` > 3] <- 3 
dt3$`log2(fold_change)`[dt3$`log2(fold_change)` < -3] <- -3 
summary(dt3)
plot(dt3$`log2(fold_change)` ~ rep(0, nrow(dt3)))

tmp <- dcast.data.table(dt3,
                        gene ~ contrast,
                        value.var = "log2(fold_change)")
sum(rowSums(is.na(tmp[, -1])) == 0)
genes.keep <- tmp$gene[rowSums(is.na(tmp[, -1])) == 0]

# Keep only the genes that remained in all 3 comparisons
dt3 <- subset(dt3,
             gene %in% genes.keep)

# Heatmap, genes ordered alphanumerically----
tiff(filename = "tmp/heatmap.tiff",
     height = 10,
     width = 10,
     units = 'in',
     res = 300,
     compression = "lzw+p")
# png(filename = "tmp/heatmap.png",
#      height = 15,
#      width = 5,
#      units = 'in',
#      res = 300)
ggplot(data = dt3) +
  geom_tile(aes(x = contrast,
                y = gene,
                fill = `log2(fold_change)`)) +
  scale_fill_gradient2(low = "red", 
                       high = "green", 
                       mid = "black", 
                       midpoint = 0, 
                       limit = c(-3, 3), 
                       space = "Lab", 
                       name="Log2(Fold-Change)") +
  scale_x_discrete("Comparison") + 
  scale_y_discrete("Gene") +
  ggtitle("Hitmap")  +
  theme(axis.text.x = element_text(angle = 0),
        plot.title = element_text(hjust = 0.5))
graphics.off()

# Order genes by fold-change----
# See examples in "source" folder: "rna_seq_18w_plot.R", etc.
lvls <- unique(dt3$gene)[order(dt3$`log2(fold_change)`[dt3$contrast == "UVB - Control"])]
dt3$gene <- factor(dt3$gene,
                   levels = lvls)

# Heatmap, ordered by fold-change----
tiff(filename = "tmp/heatmap_ordered.tiff",
     height = 10,
     width = 10,
     units = 'in',
     res = 300,
     compression = "lzw+p")
# png(filename = "tmp/heatmap_ordered.png",
#      height = 15,
#      width = 5,
#      units = 'in',
#      res = 300)
ggplot(data = dt3) +
  geom_tile(aes(x = contrast,
                y = gene,
                fill = `log2(fold_change)`)) +
  scale_fill_gradient2(low = "red", 
                       high = "green", 
                       mid = "black", 
                       midpoint = 0, 
                       limit = c(-3, 3), 
                       space = "Lab", 
                       name="Log2(Fold-Change)") +
  scale_x_discrete("Comparison") + 
  scale_y_discrete("Gene") +
  ggtitle("Hitmap")  +
  theme(axis.text.x = element_text(angle = 0),
        plot.title = element_text(hjust = 0.5))
graphics.off()