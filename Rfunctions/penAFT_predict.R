penAFT.predict
penAFT_predict <- function (fit, Xnew, lambda = NULL) 
{
 message("Test penAFT.predict function")
    if (!is.matrix(Xnew)) {
        if (length(Xnew) == length(fit$X.mean)) {
            Xnew <- matrix(Xnew, nrow = 1)
        }
        else {
            stop("Xnew must be a matrix of dimension n_new x p")
        }
    }
    if (class(fit) != "penAFT" & class(fit) != "penAFT.cv") {
        stop("Input 'fit' must be a model fit from penAFT or penAFT.cv")
    }
    if (class(fit) == "penAFT") {
        if (is.null(lambda) | !any(fit$lambda == lambda)) {
            stop("Must supply input 'lambda' equal to element of penAFT$lambda, or use penAFT.cv for model fitting.")
        }
        else {
       
            if (fit$standardize) {
                Xpred <- (Xnew - rep(1, dim(Xnew)[1]) %*% t(fit$X.mean))/(rep(1, 
                  dim(Xnew)[1]) %*% t(fit$X.sd))
            }
            else {
                Xpred <- Xnew
            }
            s <- which(fit$lambda == lambda)
            message("s=", s)
            .beta <- fit$beta[, s]
            message(".beta =")
            print(.beta)
            preds <- Xpred %*% as.matrix(fit$beta[, s])
        }
    }
    else {
        if (is.null(lambda)) {
            s <- min(which(fit$cv.err.linPred == min(fit$cv.err.linPred)))
        }
        else {
            if (!any(fit$full.fit$lambda == lambda)) {
                stop("Must supply input 'lambda' equal to element of penAFT$lambda, or use penAFT.cv for model fitting.")
            }
            else {
                s <- which(fit$full.fit$lambda == lambda)
            }
        }
        fit <- fit$full.fit
        if (fit$standardize) {
            Xpred <- (Xnew - rep(1, dim(Xnew)[1]) %*% t(fit$X.mean))/(rep(1, 
                dim(Xnew)[1]) %*% t(fit$X.sd))
        }
        else {
            Xpred <- Xnew
        }
        preds <- Xpred %*% as.matrix(fit$beta[, s])
    }
    return(preds)
}

