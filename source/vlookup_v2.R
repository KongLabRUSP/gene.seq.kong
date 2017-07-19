# Project: RNA-seq pathway/gene table
# Author: Davit Sargsyan
# Created: 05/30/2017
# Last Modified: 05/30/2017
# Sources: 
#*****************************************************
require(data.table)
dt1 <- fread("data/data_05302017/canonical pathways comparison in AOMDSS 8wks top hits.csv",
             skip = 1)

# Table1 (Neg Control vs. AOM DSS)----
t1 <- dt1[1:23, c(1, 5)]
# NOTE: in previous version, the split was done incorrectly on pathway
tmp <- strsplit(t1$Molecules, split = ",")
tmp

# Create a long format dataset, one row per pathway-gene combination
out <- list()
for (i in 1:length(tmp)) {
  out[[i]] <- data.table(pathway = rep(t1$`Ingenuity Canonical Pathways`[i], 
                                       length(tmp[[i]])),
                         gene = tmp[[i]])
}
out
tt1 <- do.call("rbind", out)
tt1

# Table2 (Cur vs. AOM DSS)----
t2 <- dt1[1:23, c(10, 14)]
tmp <- strsplit(t2$Molecules, split = ",")
tmp

# Create a long format dataset, one row per pathway-gene combination
out <- list()
for (i in 1:length(tmp)) {
  out[[i]] <- data.table(pathway = rep(t2$V10[i], 
                                       length(tmp[[i]])),
                         gene = tmp[[i]])
}
out

tt2 <- do.call("rbind", out)
tt2

# # Select the list of genes that were mapped to pathways in both comparisons
# tt3 <- subset(tt1,
#               gene %in% unique(tt2$gene))

# Table3
t3 <- data.table(gene = dt1$V16,
                 found = TRUE)
t3

# Combine Table 1 and Table 3----
tt1.match <- subset(tt1,
                    tt1$gene %in% t3$gene)
tt1.match

length(unique(tt1$gene))
length(unique(t3$gene))

t3$gene[(t3$gene %in% tt1$gene)]

tt1.merged <- unique(merge(tt1, t3, by = "gene", all.y = TRUE))

setkey(tt1.merged, gene)
tt1.merged[, n := 1:.N,
           by = gene]

dt1.out <- dcast.data.table(tt1.merged,
                            gene ~ n,
                            value.var = "pathway")
dt1.out

# Combine Table 2 and Table 3----
length(unique(tt2$gene))
length(unique(t3$gene))

t3$gene[(t3$gene %in% tt2$gene)]

tt2.merged <- unique(merge(tt2, t3, by = "gene", all.y = TRUE))

setkey(tt2.merged, gene)
tt2.merged[, n := 1:.N,
           by = gene]

dt2.out <- dcast.data.table(tt2.merged,
                            gene ~ n,
                            value.var = "pathway")
dt2.out

# Save as CSV files----
write.csv(dt1.out,
          file = "tmp/dt1.out.csv",
          row.names = FALSE)

write.csv(dt2.out,
          file = "tmp/dt2.out.csv",
          row.names = FALSE)