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
library(penAFT)
sessionInfo()


## ----input-info, include=FALSE------------------------------------------------
vignette_nm  <- "43-penAFT-opt"
vignette_Rmd <- paste(vignette_nm,".Rmd", sep = "")


## ----load-Rdata---------------------------------------------------------------
load(file = "Rdata/42-penAFT-cva.Rdata")
ls()


## ----cva-grid-----------------------------------------------------------------
loss_grid <- lossgrid(penAFTcva.en)
names(loss_grid)
loss_grid_min <- loss_grid[, "lambda.min"] 
loss_grid[loss_grid_min, ]

minlossplot(penAFTcva.en)
knitr::knit_exit()


## ----penAFT-test-nonzero-coefs------------------------------------------------
coef.en.10_nz <- coef.en.10$beta[coef.en.10$beta !=0]
names(coef.en.10_nz) <- rownames(coef.en.10$beta[coef.en.10$beta !=0])
coef.en.10_nz

Check whether X and Y are properly defined.


## ----chkdata------------------------------------------------------------------
is.matrix(X) # X needs to be a matrix
knitr::knit_exit()


## ----setup2-------------------------------------------------------------------


## ----initloop-----------------------------------------------------------------

K <- 2     # Number of iterations in the outer loop
J <- 5     # Number of iterations in the inner loop
alphx <- seq(0, 1, len = 11)^3   # 0-ridge, 1-LASSO
alphx_nms <- paste("a", alphx, sep ="")
## fldsK <- createFolds(Y, k = K, list = TRUE, returnTrain = FALSE)
set.seed(1234)
nrowdtc   <-  nrow(dtc)
fldsK <- sample(1:K, size = nrowdtc, replace = TRUE)



## ----looplists----------------------------------------------------------------
cvafitK <- list()


## ----mainloop-----------------------------------------------------------------
message("--->>> Outer loop K = ", K,"\n")
# For each outer fold 1..k do:
   for (k in 1:K){

   # Combine the data from folds != k into a training set of 900 and test data of 100
      train_k <- which(fldsK !=k)
       Xo_k <- X[train_k,] # Train data
       Yo_k <- Y[train_k]  
       Xp_k <- X[-train_k,] # Test data
       Yp_k <- Y[-train_k] 
 
    
      message("====>>>>> k =", k,"/",K,", outer split (", nrow(Xo_k), "+", nrow(Xp_k), ")/", length(fldsK)) 

      # CV with the same folds for different values of alpha
       cva.foldid <- sample(1:J, size = length(Yo_k), replace = TRUE)
       cvafitk    <- lapply(alphx, FUN = function(x){
                               res <-cv.glmnet(Xo_k,Yo_k, alpha=x, family="binomial", foldid = cva.foldid)
                               return(res)
                        }) 
       names(cvafitk) <- alphx_nms 
       cvafitK[[length(cvafitK) + 1]] <- cvafitk 
  message(" - assesing performnce of cvafitk model in Xp_k data (n =", nrow(Xp_k), ")")
   } # for k 
   names(cvafitK) <- paste("k", 1:K, sep ="")


## ----mainres------------------------------------------------------------------
length(cvafitK)            # Should be equal to K
class(res1 <- cvafitK$k1$a0.5)
str(res1)
res1$lambda.min
save(cvafitK, file = "cvafitK.Rdata")
# knitr::knit_exit()


## ----final model--------------------------------------------------------------
cva.foldid <- sample(1:J, size = length(Y), replace = TRUE) 

cva_full <- cva.glmnet(X, Y, family = "binomial", alpha = alphx, nfolds = J, foldid = cva.foldid)                     
str(cva_full)


## ----get_cvlistparms----------------------------------------------------------
get_cvafit_params <- function(fit) {
  alpha <- fit$alpha
  lambdaMin   <- sapply(fit$modlist, `[[`, "lambda.min")
  lambda1SE   <- sapply(fit$modlist, `[[`, "lambda.1se")
  min_mod_cvm <- sapply(fit$modlist, function(mod) {min(mod$cvm)})
  optm        <- min_mod_cvm == min(min_mod_cvm) 
  data.frame(alpha = alpha, 
             lambdaMin = lambdaMin,
             lambda1SE = lambda1SE,
             min_mod_cvm = min_mod_cvm, 
             optm=optm)
}
(cvafit_params <- get_cvafit_params(cva_full))


## ----optimum-params-for-cva-full-model----------------------------------------
cvafit_opt_params <- as.matrix(subset(cvafit_params, optm == TRUE, select =c(alpha,lambda1SE)))
print(cvafit_opt_params)
alpha_opt <- cvafit_opt_params[, "alpha"]
lmbda_opt <- cvafit_opt_params[, "lambda1SE"]


## ----glmnet-final-------------------------------------------------------------
fit_fnl <- glmnet(X, Y, family = "binomial", alpha = alpha_opt, lambda= lmbda_opt)
coef(fit_fnl)


## ----dtc-new------------------------------------------------------------------
set.seed(1122)
nx  <- nrow(dtc)
ns  <- floor(0.9*nx) # 90pct of teh total sample
idx <- sample(1:nx, size =ns)
dtc_new <- dtc[idx,]
class(dtc_new)
## knitr::knit_exit()


## ----XY-mtx-new---------------------------------------------------------------
X_new <- as.matrix(dtc_new[, 2:25])
Y_new <- dtc_new[, 1:1] # status 
n <- length(Y_new)

