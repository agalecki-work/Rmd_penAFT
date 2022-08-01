## ---- knitr-setup, include = FALSE, comment="#>", eval=FALSE------------------
#> knitr::opts_chunk$set(
#>   collapse = TRUE,
#>   results = "markup",
#>   highlight = TRUE,
#>   fig.width = 12, fig.height=8, fig.path='Figs/'
#> )


## ----Rsetup-ls, include=FALSE-------------------------------------------------
rm (list=ls())


## ----Rsetup-------------------------------------------------------------------
sessionInfo()


## ----input-info, echo=FALSE---------------------------------------------------
vignette_nm  <- "42-penAFT-cva"
vignette_Rmd <- paste(vignette_nm,".Rmd", sep = "")


## ----load-Rdata---------------------------------------------------------------
library(penAFT)
sessionInfo()
load(file = "Rdata/41-penAFT-mtx.Rdata")
ls()


## ----penAFT-cva---------------------------------------------------------------
library(cvaUtils)

alpha <- seq(0, 1, len = 11)^3
lmbda <- 10^(seq(3,-5, -0.2))
penAFTcva.en <- penAFT.cva(x=X, logY = logY, delta = delta,
               alpha = alpha,
               nlambda = 50, lambda.ratio.min = 0.1, lambda = lmbda,
               penalty = "EN", nfolds = 5, seed = 123)
class(penAFTcva.en) # "penAFT.cva"
str(penAFTcva.en)


## ----save-penAFT-cva----------------------------------------------------------
save(penAFTcva.en,file = "Rdata/42-penAFT-cva.Rdata")

