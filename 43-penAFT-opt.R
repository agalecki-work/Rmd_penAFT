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
vignette_nm  <- "43-penAFT-opt"
vignette_Rmd <- paste(vignette_nm,".Rmd", sep = "")


## ----load-Rdata---------------------------------------------------------------
load(file = "Rdata/42-penAFT-cva.Rdata")
ls()


## ----cva-lossgrid-------------------------------------------------------------
loss_grid <- lossgrid(penAFTcva.en)
names(loss_grid)
save(loss_grid, file = "Rdata/43-penAFT-loss-grid.Rmd")


## ----minlossplot-all----------------------------------------------------------
minlossplot(penAFTcva.en, plot.it ="all")


## ----minlossplot-min----------------------------------------------------------
minlossplot(penAFTcva.en)


## ----cva-lossgrid-optm--------------------------------------------------------
# loss_grid_lambda_min <- loss_grid[, "lambda.min"] 
# loss_grid[loss_grid_lambda_min, ]
loss_grid_cv.err.linPred_min <-loss_grid[,"cv.err.linPred_min"]
loss_grid[loss_grid_cv.err.linPred_min, ]


## ----extract-opt--------------------------------------------------------------
alpha   <- unique(loss_grid$alpha)
(alpha0 <-alpha[11])

dta0 <- subset(loss_grid, alpha == alpha0) # select rows for alpha0
dt1 <-  subset(dta0, cv.err.linPred == min(cv.err.linPred))
(lambda0 <- dt1[["lambda"]])


