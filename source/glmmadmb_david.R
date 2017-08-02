# |---------------------------------------------|
# | Project:      David's RNA seq data analysis |
# | Script:       Mixed Effect model            |
# | Scientist:    David Cheng                   |
# |               Davit Sargsyan                |
# | Created:      07/21/2017                    |
# |---------------------------------------------|
# Header----
# # Install package glmmADMB
# # a. From R-Forge:
# install.packages("glmmADMB",
#                  repos=c("http://glmmadmb.r-forge.r-project.org/repos",
#                          getOption("repos")),
#                  type="source")
# # OR
# # b. From GitHub
# devtools::install_github("bbolker/glmmadmb")

# Load packages
require(data.table)
require(glmmADMB)
require(lsmeans)
require(ggplot2)

# Save the log file
sink(file = "tmp/glmmadmb_david_log.txt")

# Load data----
dt1 <- fread("data/data_07212017_david/combraw.count")
names(dt1)

# Rename columns with long names
names(dt1)[7:14] <- paste("DR", 
                          1:8,
                          sep = "")

# Convert data to long format----
dt.long <- melt.data.table(dt1,
                           id.vars = "Geneid",
                           measure.vars = 7:14,
                           variable.name = "Sample",
                           value.name = "Counts")
dt.long

# Map samples to treatments
map <- data.table(Sample = paste("DR", 
                                 1:8, 
                                 sep = ""),
                  Treatment = rep(c("Control",
                                    "DB"),
                                  4),
                  Week = rep(c("W16",
                               "W21"),
                             each = 4))
map

# Merge treatment with data----
dt2 <- merge(map, 
             dt.long,
             by = "Sample")

# Convert treatments to factor----
dt2$Treatment <- factor(dt2$Treatment,
                        levels = c("Control",
                                   "DB"))
dt2$Week <- factor(dt2$Week,
                   levels = c("W16",
                              "W21"))
dt2$Geneid <- factor(dt2$Geneid)

dt2

# Generalized Linear Mixed Models Using Authomatic Differentiation Model Builder (glmmADMB)----
# Contrasts (based on 'ref' object below)
c_list <- list(`DB - Control, W16` = c(-1, 1, 0, 0),
               `DB - Control, W21` = c(0, 0, -1, 1),
               `W21 - W16, Control` = c(-1, 0, 1, 0),
               `W21 - W16, DB` = c(0, -1, 0, -1))
c_list

# 1. Overall model, genes as random effect----
# NOTE: breaks!
system.time(m1 <- glmmadmb(Counts ~ Treatment*Week + (1 | Geneid), 
                           family = "nbinom",
                           save.dir = "tmp/glmmadmb_out",
                           data = dt2))
m1
summary(m1)

# Exclude random effect----
system.time(m1.1 <- glmmadmb(Counts ~ Treatment*Week, 
                           family = "nbinom",
                           save.dir = "tmp/glmmadmb_out",
                           data = dt2))
m1.1
summary(m1.1)

ref1.1 <- lsmeans::lsmeans(m1.1,
                          c("Treatment", 
                            "Week"))
ref1.1

# Forest plot----
plot(ref1.1)

# Output pairwise comparison resilts
out1.1 <- lsmeans::contrast(ref1.1, c_list)
out1.1
plot(out1.1)

# 2. Individual gene analysis----
# NOTE: the code below allows running the analysis for each gene separately.
#       To test all genes, put them in the loop and process in parallel
i=1
system.time(m.i <- glmmadmb(Counts ~ Treatment*Week, 
                           family = "nbinom",
                           save.dir = "tmp/glmmadmb_out",
                           data = subset(dt2,
                                         Geneid == levels(Geneid)[i])))
m.i
summary(m.i)

ref.i <- lsmeans::lsmeans(m.i,
                        c("Treatment", 
                          "Week"))
ref.i
plot(ref.i)

# Output pairwise comparison resilts
out.i <- lsmeans::contrast(ref.i, c_list)
out.i
plot(out.i)

# Close log file----
sink()