process_Rmd <- function (nm){
 nm.Rmd <- paste(nm,".Rmd", sep = "")
 nm.R <- paste(nm,".R", sep = "")
 knitr::purl(nm.Rmd, output = nm.R)
 rmarkdown::render(nm.Rmd, "all")
}
