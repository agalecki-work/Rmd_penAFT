# source("_01process_Rmd.R")
source("Rfunctions/process_Rmd.R")

Rmd_names <- c("11-data",
               "12-cva",
               "13-opt",
               "14-fit",
               "15-fit-summ",
               "21-fit-AFT"
               "90-test-chunks"
              )
Rmd_names <- "21-fit-AFT"
Rmd_names <- "21-fit-AFT"

lapply(as.list(Rmd_names), process_Rmd)
 

