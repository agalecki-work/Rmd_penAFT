## ---- include = FALSE, echo=FALSE---------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  results = "markup",
  highlight = TRUE,
  fig.width = 12, fig.height=8, fig.path='Figs/'
)


## ----Rsetup-ls, include=FALSE-------------------------------------------------
rm (list=ls())


## ----Rsetup-------------------------------------------------------------------
library(cvaUtils)
sessionInfo()


## ----input-info, include=FALSE------------------------------------------------
vignette_nm  <- "44-penAFT-fit"
vignette_Rmd <- paste(vignette_nm,".Rmd", sep = "")


## ----load-Rdata---------------------------------------------------------------
load(file = "Rdata/43-penAFT-loss-grid.Rdata")
ls()


## ----cva-lossgrid-------------------------------------------------------------
names(loss_grid)
# save(?, file = "Rdata/44-penAFT-opt-fit.Rdata")


## ----extract-opt--------------------------------------------------------------
alpha   <- unique(loss_grid$alpha)
(alpha0 <-alpha[11])

dta0 <- subset(loss_grid, alpha == alpha0) # select rows for alpha0
dt1 <-  subset(dta0, cv.err.linPred == min(cv.err.linPred))
(lambda0 <- dt1[["lambda"]])

