## ----knitr-setup, include = FALSE, echo=FALSE---------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  results = "markup",
  highlight = TRUE,
  fig.width = 12, fig.height=8, fig.path='Figs/'
)


## ----input-info, echo=FALSE---------------------------------------------------
xlsxnm <- "datain/joslin_npx_scrambled_053122.xlsx"
xlsxbs <- basename(xlsxnm)
vignette_nm <- "41-penAFT-data"


## ----Rsetup-------------------------------------------------------------------
rm (list=ls())
sessionInfo()


## ----dat-raw------------------------------------------------------------------

xlsx  <- readxl::read_excel(xlsxnm, sheet = "joslin_npx_scrambled", na = "", guess_max = 1000)
dat_raw <- data.frame(xlsx)

nms_raw <- names(dat_raw)
nms_raw[nms_raw == "CASE_CONTROL"] <- "status"   # status = 1 (observed follow-up time), status = 0 (censored follow-up time)

nms_low <- tolower(nms_raw)
(names(dat_raw) <- nms_low)


## ----var-names-lists----------------------------------------------------------
(prt_vnms <- nms_low[which(nms_low == "kim1.npx") : length(nms_low)])
length(prt_vnms)
cln_vnms  <- c("sex",    "sbp_tl",       "dbp_tl", "ageonset_tl", "bmi_tl",
              "age_tl", "b_hba1c_prc",  "du_acr", "bl_egfr")


## ----dat-anl------------------------------------------------------------------
select_vars <-  c("fu_time", "status", cln_vnms, prt_vnms)
dat_anl <- dat_raw[,select_vars]
class(dat_anl)
dim(dat_anl)
names(dat_anl)


## ----missing-values-----------------------------------------------------------
count_miss_vals <- sapply(dat_anl, function(x) sum(is.na(x)))
count_miss_vals <- sort(count_miss_vals, decreasing = TRUE) 
ncol(dat_anl)                          # Number of variables in analysis
sum(count_miss_vals == 0)              # Number of variables without missing values  
count_miss_vals[count_miss_vals  >  0] # Variables with missing values


## ----cln_vnms2----------------------------------------------------------------
(cln_vnms2 <- cln_vnms[! cln_vnms %in% c("bmi_tl")])


## ----dtc-cmplt-cases----------------------------------------------------------

select_vars <- c("fu_time", "status", cln_vnms2, prt_vnms)
cmplt_cases <- complete.cases(dat_anl)
dtc <- dat_raw[cmplt_cases, select_vars ]  # Data with complete cases
nrow(dtc) # Number of rows with complete data


## ----save-dtc}----------------------------------------------------------------
fnm <- "Rdata/41-penAFT-dtc.Rdata"
save(dtc, file = fnm )


## ----XYmtx--------------------------------------------------------------------
X     <- as.matrix(dtc[, X_vnms]) 
logY  <- log(dtc[, "fu_time"]) 
delta <- dtc[, "status"]      # status = 0 indicates censored observation 
n <- length(logY)


## ----XY-new-------------------------------------------------------------------
sel_rows <- delta == 1
Xnew <- X[sel_rows,]
logYnew <- logY[sel_rows] 


## ----save-mtx}----------------------------------------------------------------
fnm <- "Rdata/41-penAFT-mtx.Rdata"
save(X,logY, delta, file = fnm )

fnm <- "Rdata/41-penAFT-mtxnew.Rdata"
save(Xnew, logYnew, file = fnm )

