# Project: RNA-seq pathway/gene table
# Author: Davit Sargsyan
# Created: 05/30/2017
# Last Modified: 05/30/2017
# Sources: 
#*****************************************************
require(data.table)
dt1 <- fread("data/data_05302017/canonical pathways comparison in AOMDSS 8wks top hits.csv")

# Table1----
t1 <- dt1[1:23, c(1, 5)]
tmp <- strsplit(t1$`Ingenuity Canonical Pathways`, split = ",")
tmp

out <- list()
for (i in 1:length(tmp)) {
  out[[i]] <- data.table(pathway = rep(t1$`Ingenuity Canonical Pathways`[i], 
                                       length(tmp[[i]])),
                         gene = tmp[[i]])
}
out

tt1 <- do.call("rbind", out)
tt1

# Table 2----
t2 <- dt1[1:23, c(7, 11)]
tmp <- strsplit(t2$Molecules, split = ",")
tmp

out <- list()
for (i in 1:length(tmp)) {
  out[[i]] <- data.table(pathway = rep(t2$V7[i], 
                                       length(tmp[[i]])),
                         gene = tmp[[i]])
}
out

tt2 <- do.call("rbind", out)
tt2

# Table3
t3 <- data.table(gene = dt1$V13,
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
