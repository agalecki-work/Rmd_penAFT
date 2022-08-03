# source("_render_vignettes.R")

process_Rmd <- function (nm){
 nm.Rmd <- paste(nm,".Rmd", sep = "")
 nm.R <- paste(nm,".R", sep = "")
 knitr::purl(nm.Rmd, output = nm.R)
 rmarkdown::render(nm.Rmd, "all")
}

process_Rmd("11-data")

process_Rmd("12-cva")

process_Rmd("13-op")

process_Rmd("14-fit")

process_Rmd("90-test-chunks")

