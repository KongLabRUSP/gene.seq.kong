# Project: RNA-seq pathway/gene table
# Author: David Cheng, Davit Sargsyan
# Created: 06/19/2017
# Last Modified: 
# Sources: 
#*****************************************************
# # Download packages (do it once per machine!)
# source("https://bioconductor.org/biocLite.R")
# biocLite("XVector")
# biocLite("Rsamtools")
# biocLite("edgeR")
# biocLite("DESeq2")
## Restart R session

require(Rsamtools)
require(edgeR)
library(help = "edgeR")

# A function to read bam file
# Source: https://gist.github.com/SamBuckberry/9914246
readBAM <- function(bamFile){
  
  bam <- scanBam(bamFile)
  
  # A function for collapsing the list of lists into a single list
  # as per the Rsamtools vignette
  .unlist <- function (x){
    x1 <- x[[1L]]
    if (is.factor(x1)){
      structure(unlist(x), class = "factor", levels = levels(x1))
    } else {
      do.call(c, x)
    }
  }
  
  bam_field <- names(bam[[1]])
  
  list <- lapply(bam_field, function(y) .unlist(lapply(bam, "[[", y)))
  
  bam_df <- do.call("DataFrame", list)
  names(bam_df) <- bam_field
  
  #return a list that can be called as a data frame
  return(bam_df)
}

# Load a bam file
f1 <- "/home/administrator/Documents/David_RNAseq_bgi/BAM_Files_v2_1_1/DR1.bam.prefix.bam"
bam1 <- readBAM(f1)
