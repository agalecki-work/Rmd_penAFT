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
knitr::purl("42-penAFT-cva.Rmd", output = "42-penAFT-fits.R")

rmarkdown::render("90-Rmd-test-chunks.Rmd", "all")
knitr::purl("90-Rmd-test-chunks.Rmd", output = "90-Rmd-test-chunks.Rmd.R")
