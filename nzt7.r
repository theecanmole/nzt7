New Zealand NIWA Seven-station series land surface temperature data 1909 2018

https://www.niwa.co.nz/our-science/climate/information-and-resources/nz-temp-record/seven-station-series-temperature-data

getwd()

[1] "/home/user"

#setwd("/home/user/R/nzt7")
library(here)
here() starts at /home/user/R/nzt7
set_here()
library(readxl)

# t7data <- read.csv("", skip = 5,header=TRUE, stringsAsFactors=FALSE)
# obtain data sheet from NIWA
url <- c("https://www.niwa.co.nz/sites/niwa.co.nz/files/NZT7_Adjusted_Annual_TMean2018_Web-updated-jan-2019.xlsx")
file <- c("/home/user/R/nzt7/NZT7_Adjusted_Annual_TMean2018_Web-updated-jan-2019.xlsx")
download.file(url, file)
trying URL 'https://www.niwa.co.nz/sites/niwa.co.nz/files/NZT7_Adjusted_Annual_TMean2018_Web-updated-jan-2019.xlsx'
Content type 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' length 22763 bytes (22 KB)
==================================================
downloaded 22 KB

library(readxl)

# List all sheets in an excel spreadsheet 
excel_sheets("NZT7_Adjusted_Annual_TMean2018_Web-updated-jan-2019.xlsx")
[1] "NZT7_Adjusted_TMean2016_Web"

t7data <-read_excel("NZT7_Adjusted_Annual_TMean2018_Web-updated-jan-2019.xlsx", sheet = "NZT7_Adjusted_TMean2016_Web", range ="Q12:Q122", col_names = T, skip =11,col_types = c("guess"))

str(t7data) 
Classes ‘tbl_df’, ‘tbl’ and 'data.frame':	110 obs. of  1 variable:
 $ Anomaly: num  -0.22 -0.15 -0.66 -1.28 -1.04 -1.03 -0.67 0.38 0.19 -0.8 ...

year <-read_excel("NZT7_Adjusted_Annual_TMean2018_Web-updated-jan-2019.xlsx", sheet = "NZT7_Adjusted_TMean2016_Web", range ="A12:A122", col_names = T, skip =11,col_types = c("guess"))
str(year) 
Classes ‘tbl_df’, ‘tbl’ and 'data.frame':	110 obs. of  1 variable:
 $ X__1: num  1909 1910 1911 1912 1913 . 
 
t7data<-cbind(year,t7data) 

str(t7data) 
'data.frame':	110 obs. of  2 variables:
 $ X__1   : num  1909 1910 1911 1912 1913 ...
 $ Anomaly: num  -0.22 -0.15 -0.66 -1.28 -1.04 -1.03 -0.67 0.38 0.19 -0.8 ...

names(t7data)<-c("Year","Anomaly")
str(t7data)
 'data.frame':	110 obs. of  2 variables:
 $ Year   : num  1909 1910 1911 1912 1913 ...
 $ Anomaly: num  -0.22 -0.15 -0.66 -1.28 -1.04 -1.03 -0.67 0.38 0.19 -0.8 ...

tail(t7data)
   Year Anomaly
105 2013    0.72
106 2014    0.18
107 2015    0.14
108 2016    0.84
109 2017    0.54110 2018    0.80

write.table(t7data, file = "/home/user/R/nzt7/niwa-t7data.csv", sep = ",", col.names = TRUE, qmethod = "double",row.names = FALSE)

# create svg format chart with 14 pt text font and grid lines via 'grid'
svg(filename="/home/user/R/nzt7/nzt7timeseries_720by540.svg", width = 8, height = 6, pointsize = 14, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))  
par(mar=c(2.7,2.7,1,1)+0.1)
plot(t7data,tck=0.01,ylim=c(-1.5,1.25),axes=TRUE,ann=TRUE, las=1,col=2,lwd=2,type='l',lty=1)
grid(col="darkgray",lwd=1)
axis(side=4, tck=0.01, las=0,tick=TRUE,labels = FALSE)
mtext(side=1,cex=0.7,line=-1.3,"Data: https://www.niwa.co.nz/sites/niwa.co.nz/files/NZT7_Adjusted_Annual_TMean2018_Web-updated-jan-2019.xlsx")
mtext(side=3,cex=1.7, line=-4,expression(paste("NZ Annual Average Temperature \nAnomaly 1909 - 2019")) )
mtext(side=2,cex=0.9, line=-1.3,"Temperature anomaly C vs 1981-2010 mean")
mtext(side=4,cex=0.75, line=0.05,R.version.string)
abline(lm(t7data[["Anomaly"]]~t7data[["Year"]]),col="darkgray",lwd=3,lty=1)

#points(lowess(t7data[["Anomaly"]]~t7data[["Year"]], f = 5/100),type="l",col=1,lty=1,lwd=3)

points(lowess(ats,f = 11/106),type="l",col=2,lty=1,lwd=2)


# from wikimedia commons https://commons.wikimedia.org/wiki/File:NZ-best-land-temp-anom.svg

# create graph
svg(filename="NZ-T7-land-temp-anom-720by540-v1.svg", width = 8, height = 6, pointsize = 14, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))
par(mar=c(2.7,2.7,1,1)+0.1)
plot(t7data[["Year"]],t7data[["Anomaly"]],ylim=c(-1.5,1.25),xlim=c(1905,2018),tck=0.01,axes=FALSE,ann=FALSE, type="l",col="1",lwd=1,las=1)
axis(side=1, tck=0.01, las=0,tick=TRUE)
axis(side=2, tck=0.01, las=0,tick=TRUE,las=1)
box()
#lines(t7data[["Year"]],t7data[["Anomaly"]],col="1",lwd=1)
points(t7data[["Year"]],t7data[["Anomaly"]],col="#000099",pch=19)
lines(lowess(t7data[["Year"]],t7data[["Anomaly"]],f=0.1),lwd=3,col="#CC0000")
mtext(side=1,cex=0.7,line=-1.1,"Data: NIWA Seven-station series temperature data\n https://www.niwa.co.nz/sites/niwa.co.nz/files/NZT7_Adjusted_Annual_TMean2018_Web-updated-jan-2019.xlsx")
mtext(side=3,cex=1.7, line=-4,expression(paste("New Zealand Mean Land Surface \nTemperature Anomalies 1909 - 2018")) )
mtext(side=2,cex=1, line=-1.3,"Temperature anomaly C vs 1981-2010 mean")
legend(1910, 1,bty='n',bg="white", c(paste("Mean", c("annual anomaly", "lowess smoothed \nanomaly 11 years f =0.1"))),pch=c(19,NA),lty=c(1,1),lwd=c(1,3),col=c("#000099","#CC0000"))
dev.off()


dev.off() 
