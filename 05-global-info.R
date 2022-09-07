# Clears Global environment
rm(list=ls())

# Dataset names 
xlsxbs_train = "jnpx_scrambled_053122"   # Base name of xlsx train data


# Paths to datasets

train_xlsx_path <- paste("datain/", xlsxbs_train, ".xlsx", sep="")

##- typically no changes needed below this line 

##  Sets knitr chunk options used in Rmd file
require(knitr)
knitr::opts_chunk$set(
  collapse = TRUE,
  results = "markup",  
  comment="#>",
  highlight = TRUE,
  fig.width = 12, fig.height=8, fig.path='Figs/'
)

              
# Based on `.vignette_nm` assign variables for later use

.vignette_Rmd <- paste(.vignette_nm,".Rmd", sep = "")
.vignette_R   <- paste(.vignette_nm,".R",   sep = "")
.vignette_html<- paste(.vignette_nm, ".html",   sep = "")
