setwd("gene.seq.kong/data/610")
dir()

dt.dna <- read.csv("dna.csv")

dt.dna <- data.frame(gene = dt.dna$gene3,
                     feature = dt.dna$feature,
                     diff = dt.dna$Control_18..AOMDSS_18.diff)
gc()

dt.rna <- read.csv("rna.csv")
dt.rna <- dt.rna[dt.rna$sample_1 == "Control" & dt.rna$sample_2 == "AOM+DSS", ]
dt.rna <- dt.rna[, which(colnames(dt.rna) %in% c("gene", "log2.fold_change."))]


# Merge
dt.rna$gene <- as.character(dt.rna$gene)
dt.dna$gene <- as.character(dt.dna$gene)

dt1 <- merge(dt.dna,
             dt.rna,
             by = "gene")

plot(dt1$diff ~ dt1$log2.fold_change.)
points(dt1$diff[dt1$gene == "Tnf"] ~ dt1$log2.fold_change[dt1$gene == "Tnf"],
       col = "red",
       pch = 16)


dt1.prom <- dt1[dt1$feature == "Promoter (<=1kb)", ]
dt1.prom <- dt1[dt1$feature == "Promoter (2-3kb)", ]

plot(dt1.prom$diff ~ dt1.prom$log2.fold_change.)

dt1[dt1$gene == "Tnf", ]
points(dt1.prom$diff[dt1$gene == "Tnf"] ~ dt1.prom$log2.fold_change[dt1$gene == "Tnf"],
       col = "red",
       pch = 21)

