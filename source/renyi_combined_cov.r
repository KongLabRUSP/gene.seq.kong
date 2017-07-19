require(data.table)
dt1 <- fread("data/methyl-results.head.csv")
dt1

out <- list()



for (i in 5:ncol(dt1)) {
  out[[i-4]] <- dt1[, i]
}