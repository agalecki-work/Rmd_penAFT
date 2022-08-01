## ----knitr-setup, include = FALSE, comment="#>", eval=FALSE-------------------
#> knitr::opts_chunk$set(
#>   collapse = TRUE,
#>   results = "markup",
#>   highlight = TRUE,
#>   fig.width = 12, fig.height=8, fig.path='Figs/'
#> )


## ----test-knitr-setup---------------------------------------------------------
(test_knitr_setup <- "test-knitr-setup")


## ----input-info, echo=FALSE, results="hide"-----------------------------------
vignette_nm  <- "90-Rmd-test-chunks"
vignette_Rmd <- paste(vignette_nm,".Rmd", sep = "")
vignette_Rmd


## ----test-include, include = FALSE--------------------------------------------
(test_include <- "Test include")


## ----test-include-check-------------------------------------------------------
exists("test_include")


## ----test-tangle-out, echo= FALSE, eval=FALSE, comment = "##"-----------------
## (test_tangle <- "Test tangle")


## ----test-tangleout-check-----------------------------------------------------
exists("test_tangle")

