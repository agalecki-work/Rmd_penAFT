stitch_r <- function (nm){
 nm.R <- paste(nm,".R", sep = "")
 nmh <- paste(nm,"-r.html", sep = "")
 knitr::stitch_rhtml(nm.R, output = nmh)
}
