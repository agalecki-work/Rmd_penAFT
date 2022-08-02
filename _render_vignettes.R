# source("_render_vignettes.R")

rmarkdown::render("glmnetUtils_logistic.Rmd", "all")
knitr::purl("glmnetUtils_logistic.Rmd")

rmarkdown::render("glmnet_logistic.Rmd", "all")
knitr::purl("glmnet_logistic.Rmd")

rmarkdown::render("penAFT.Rmd")
knitr::purl("penAFT.Rmd", output = "penAFT-vignette.R")

rmarkdown::render("41-penAFT-data.Rmd", "all")
knitr::purl("41-penAFT-data.Rmd", output = "41-penAFT-data.R")

rmarkdown::render("42-penAFT-cva.Rmd", "all")
knitr::purl("42-penAFT-cva.Rmd", output = "42-penAFT-cva.R")

rmarkdown::render("43-penAFT-opt.Rmd", "all")
knitr::purl("43-penAFT-opt.Rmd", output = "43-penAFT-opt.R")

rmarkdown::render("44-penAFT-fit.Rmd", "all")
knitr::purl("44-penAFT-fit.Rmd", output = "44-penAFT-fit.R")

rmarkdown::render("90-Rmd-test-chunks.Rmd", "all")
knitr::purl("90-Rmd-test-chunks.Rmd", output = "90-Rmd-test-chunks.Rmd.R")
