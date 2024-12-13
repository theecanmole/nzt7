# load knitr package
library(knitr)

knitr::spin(hair = "/home/user/R/nzt7/nzt7.r",
          knit=TRUE,        # knit doc
          format = "Rmd",
          precious = TRUE,  # keep intermediate files
          )
