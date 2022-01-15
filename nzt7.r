
# Temperature series by Statistics NZ based on NIWA Seven Station Series but with reference to a baseline of the 1961-1990 average, 15 October 2020, 10:45am
date()
[1] "Wed Jan 12 13:52:52 2022"
# reference of page
https://www.stats.govt.nz/indicators/temperature
# url of "download.zip"
https://statisticsnz.shinyapps.io/temperature_oct20/_w_0962552b/session/5433aba7a6a424c531e166b85475ea70/download/download?w=0962552b
# unzip to "/home/user/R/nzt7/download"
# check directory
getwd()
[1] "/home/user/R/nzt7"
# load libararies
library(readxl)
library(knitr)
library(tidyr) 
# read in the data in csv format 
StatsNZ7Sdata19611990 <- read.csv("/home/user/R/nzt7/download/state_data_7s.csv")
# look at dataframe
str(StatsNZ7Sdata19611990) 
'data.frame':	444 obs. of  6 variables:
 $ year            : int  1909 1910 1911 1912 1913 1914 1915 1916 1917 1918 ...
 $ temperature     : num  12.4 12.5 11.9 11.3 11.6 ...
 $ data_released   : int  2020 2020 2020 2020 2020 2020 2020 2020 2020 2020 ...
 $ source          : Factor w/ 4 levels "KNMI CRUTEM.4.6.0.0",..: 3 3 3 3 3 3 3 3 3 3 ...
 $ anomaly         : num  -0.079 -0.009 -0.519 -1.139 -0.899 ...
 $ reference_period: Factor w/ 1 level "1961-1990": 1 1 1 1 1 1 1 1 1 1 ...  

# filter by source (NIWA 7 station)
filter(StatsNZ7Sdata19611990, source == "NIWA 7 Station" )
Error in source == "NIWA 7 Station" : 
  comparison (1) is possible only for atomic and list types
# select using Base R
StatsNZ7Sdata19611990[StatsNZ7Sdata19611990[["source"]] == "NIWA 7 Station",]
# 111 rows looks ok
# select only 7 station to its own dataframe
StatsNZ7Sdata <- StatsNZ7Sdata19611990[StatsNZ7Sdata19611990[["source"]] == "NIWA 7 Station",]
str(StatsNZ7Sdata)
'data.frame':	111 obs. of  6 variables:
 $ year            : int  1909 1910 1911 1912 1913 1914 1915 1916 1917 1918 ...
 $ temperature     : num  12.4 12.5 11.9 11.3 11.6 ...
 $ data_released   : int  2020 2020 2020 2020 2020 2020 2020 2020 2020 2020 ...
 $ source          : Factor w/ 4 levels "KNMI CRUTEM.4.6.0.0",..: 3 3 3 3 3 3 3 3 3 3 ...
 $ anomaly         : num  -0.079 -0.009 -0.519 -1.139 -0.899 ...
 $ reference_period: Factor w/ 1 level "1961-1990": 1 1 1 1 1 1 1 1 1 1 ...  

#subset to just 3 variables 
StatsNZ7Sdata3 <-data.frame(StatsNZ7Sdata[["year"]],StatsNZ7Sdata[["temperature"]],StatsNZ7Sdata[["anomaly"]])
str(StatsNZ7Sdata3) 
'data.frame':	111 obs. of  3 variables:
 $ StatsNZ7Sdata...year...       : int  1909 1910 1911 1912 1913 1914 1915 1916 1917 1918 ...
 $ StatsNZ7Sdata...temperature...: num  12.4 12.5 11.9 11.3 11.6 ...
 $ StatsNZ7Sdata...anomaly...    : num  -0.079 -0.009 -0.519 -1.139 -0.899
# rename columns 
colnames(StatsNZ7Sdata3) <- c("year", "temperature", "anomaly") 
# write to .csv file
write.table(StatsNZ7Sdata3, file = "/home/user/R/nzt7/StatsNZ-t7data.csv", sep = ",", col.names = TRUE, qmethod = "double",row.names = FALSE) 

# create graph
 
svg(filename="STATSNZ-T7-land-temp-anom-2019-720by540-v1.svg", width = 8, height = 6, pointsize = 14, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))
par(mar=c(2.7,2.7,1,1)+0.1)
plot(StatsNZ7Sdata[["year"]],StatsNZ7Sdata[["anomaly"]],ylim=c(-1.25,1.35),xlim=c(1905,2019),tck=0.01,axes=FALSE,ann=FALSE, type="l",col="1",lwd=1,las=1)
axis(side=1, tck=0.01, las=0,tick=TRUE)
axis(side=2, tck=0.01, las=0,tick=TRUE,las=1)
box()
lines(StatsNZ7Sdata[["year"]],StatsNZ7Sdata[["anomaly"]],col="1",lwd=1)
points(StatsNZ7Sdata[["year"]],StatsNZ7Sdata[["anomaly"]],col="#000099",pch=19)
lines(lowess(StatsNZ7Sdata[["year"]],StatsNZ7Sdata[["anomaly"]],f=0.1),lwd=3,col="#CC0000")
mtext(side=1,cex=0.7,line=-1.1,"Data: NIWA Seven-station series temperature data\n https://www.stats.govt.nz/indicators/temperature")
mtext(side=3,cex=1.5, line=-4,expression(paste("New Zealand Mean Land Surface \nTemperature Anomalies 1909 - 2019")) )
mtext(side=2,cex=1, line=-1.3,"Temperature anomaly C vs 1961-1990 mean")
legend(1910, 1,bty='n',bg="white", cex = 0.8, c(paste("Mean", c("annual anomaly", "lowess smoothed anomaly 11 years f =0.1"))),pch=c(19,NA),lty=c(1,1),lwd=c(1,3),col=c("#000099","#CC0000"))
mtext(side=4,cex=0.75, line=0.05,R.version.string)
abline(h=0,col="darkgray")
dev.off()  
-----------------------------------------------------------------------------
New Zealand NIWA Seven-station series land surface temperature data 1909 2018

https://www.niwa.co.nz/our-science/climate/information-and-resources/nz-temp-record/seven-station-series-temperature-data

# NIWA "7-STATION" TEMPERATURE SERIES: ANNUAL DATA for MEAN Temperature: Version 3.1 (updated January 2019)
# Temp = Annual average mean temperature (deg C);  "Anomaly" = Temp(Year) minus 1981-2010 average ***
# Notes:
# 1) 7-Station Composite Anomaly = Average of anomalies at individual sites where there is data for that year (<7 sites before 1913)
# 2) 7-Station Composite Temperature = 7-Station Anomaly + Average of 7-Station 1981-2010 climatologies, E.g., for 1909 when there are 4 sites, the 7-Station Composite Temp is NOT the average of the Wellington, Nelson, Lincoln and Dunedin values.
# 3) The climatologies are specific to the "Reference" stations at each location, which are: Auckland Aero (Auckland, agent 1962), East Taratahi AWS (Masterton, agent 2612), Kelburn (Wellington, agent 3385), Hokitika Aero (Hokitika, agent 3909), Nelson Aero (Nelson, agent 4241), Lincoln Broadfield EWS (Lincoln, agent 17603), and Musselburgh EWS (Dunedin, agent 15752).


getwd()

#setwd("/home/user/R/nzt7")
library(here)
here() starts at /home/user/R/nzt7
set_here()
library(readxl)
library(knitr)
library(tidyr) 

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
# Alternatively read in the tidied data in csv format
t7data <- read.csv("niwa-t7data.csv")

str(t7data) 
'data.frame':	110 obs. of  2 variables:
 $ Year   : int  1909 1910 1911 1912 1913 1914 1915 1916 1917 1918 ...
 $ Anomaly: num  -0.22 -0.15 -0.66 -1.28 -1.04 -1.03 -0.67 0.38 0.19 -0.8

#Classes ‘tbl_df’, ‘tbl’ and 'data.frame':	110 obs. of  1 variable:
# $ Anomaly: num  -0.22 -0.15 -0.66 -1.28 -1.04 -1.03 -0.67 0.38 0.19 -0.8 ...

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
100 2013    0.72
101 2014    0.18
102 2015    0.14
103 2016    0.84
104 2017    0.54
105 2018    0.80

write.table(t7data, file = "/home/user/R/nzt7/niwa-t7data.csv", sep = ",", col.names = TRUE, qmethod = "double",row.names = FALSE)

# read back tidy data file

t7data <- read.csv("/home/user/R/nzt7/niwa-t7data.csv") 

# add 2019 annual anomaly 0.76 C ref https://www.nzherald.co.nz/environment/news/article.cfm?c_id=39&objectid=12299091 "New Zealand's nationwide average temperature for 2019, calculated using stations in Niwa's seven-station temperature series which began in 1909, came in at 13.37C - or 0.76C above the 1981–2010 annual average." This trend is not our friend' - 2019 NZ's fourth hottest year
9 Jan, 2020 11:00am, Jamie Morton 

t7data <- rbind(t7data,c(2019,0.76))
str(t7data)
'data.frame':	111 obs. of  2 variables:
 $ Year   : num  1909 1910 1911 1912 1913 ...
 $ Anomaly: num  -0.22 -0.15 -0.66 -1.28 -1.04 -1.03 -0.67 0.38 0.19 -0.8 ...
tail(t7data)
    Year Anomaly
106 2014    0.18
107 2015    0.14
108 2016    0.84
109 2017    0.54
110 2018    0.80
111 2019    0.76

# add 2020 anomaly https://niwa.co.nz/climate/summaries/annual-climate-summary-2020 2020 was Aotearoa New Zealand’s 7th-warmest year on record. The nationwide average temperature for 2020, calculated using stations in NIWA’s seven-station temperature series which began in 1909, was 13.24°C (0.63°C above the 1981–2010 annual average).
t7data <- rbind(t7data,c(2020,0.63))
# add 2021 anomaly https://niwa.co.nz/climate/summaries/annual-climate-summary-2021   Annual Climate Summary 2021 11 January 2022 2021 was Aotearoa New Zealand’s warmest year on record, surpassing the previous record set in 2016. Seven of the past nine years have been among New Zealand’s warmest on record. This trend is consistent with the overall pattern of global warming. The nationwide average temperature for 2021, calculated using stations in NIWA’s seven-station temperature series which began in 1909, was 13.56°C (0.95°C above the 1981–2010 annual average).
t7data <- rbind(t7data,c(2021,0.95))
 tail(t7data)
    Year Anomaly
108 2016    0.84
109 2017    0.54
110 2018    0.80
111 2019    0.76
112 2020    0.63
113 2021    0.95

# create svg format chart with 14 pt text font and grid lines via 'grid' and trend line
svg(filename="/home/user/R/nzt7/nzt7timeseries2021-720by540.svg", width = 8, height = 6, pointsize = 14, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))  
par(mar=c(2.7,2.7,1,1)+0.1)
plot(t7data,tck=0.01,ylim=c(-1.5,1.25),axes=TRUE,ann=TRUE, las=1,col=2,lwd=2,type='l',lty=1)
grid(col="darkgray",lwd=1)
axis(side=4, tck=0.01, las=0,tick=TRUE,labels = FALSE)
mtext(side=1,cex=0.7,line=-1.3,"Data: https://www.niwa.co.nz/sites/niwa.co.nz/files/NZT7_Adjusted_Annual_TMean2018_Web-updated-jan-2019.xlsx")
mtext(side=3,cex=1.7, line=-4,expression(paste("NZ Annual Average Temperature \nAnomaly 1909 - 2021")) )
mtext(side=2,cex=0.9, line=-1.3,"Temperature anomaly C vs 1981-2010 mean")
mtext(side=4,cex=0.75, line=0.05,R.version.string)
abline(lm(t7data[["Anomaly"]]~t7data[["Year"]]),col="#000099",lwd=2,lty=1)
legend(1920, 0.8, bty='n',bg="white", cex = 0.8, c(paste("Annual anomaly", c("mean", "linear trend line"))),pch=c(NA,NA),lty=c(1,1),lwd=c(2,2),col=c("#CC0000","#000099"))
dev.off()

lm(t7data[["Anomaly"]]~t7data[["Year"]])
Call:
lm(formula = t7data[["Anomaly"]] ~ t7data[["Year"]])

Coefficients:
     (Intercept)  t7data[["Year"]]  
       -21.24466           0.01068  

summary(lm(t7data[["Anomaly"]]~t7data[["Year"]]))

Call:
lm(formula = t7data[["Anomaly"]] ~ t7data[["Year"]])

Residuals:
     Min       1Q   Median       3Q      Max 
-1.15977 -0.33113 -0.06122  0.29246  1.16190 

Coefficients:
                   Estimate Std. Error t value Pr(>|t|)    
(Intercept)      -21.244657   2.404559  -8.835 1.70e-14 ***
t7data[["Year"]]   0.010680   0.001224   8.729 2.96e-14 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.4243 on 111 degrees of freedom
Multiple R-squared:  0.407,	Adjusted R-squared:  0.4017 
F-statistic: 76.19 on 1 and 111 DF,  p-value: 2.961e-14 

# points(lowess(t7data,f = 106/106),type="l",col=2,lty=1,lwd=2)

# from wikimedia commons https://commons.wikimedia.org/wiki/File:NZ-best-land-temp-anom.svg

# create graph
svg(filename="NZ-T7-land-temp-anom-2021-720by540-v1.svg", width = 8, height = 6, pointsize = 14, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))
par(mar=c(2.7,2.7,1,1)+0.1)
plot(t7data[["Year"]],t7data[["Anomaly"]],ylim=c(-1.5,1.45),xlim=c(1905,2021),tck=0.01,axes=FALSE,ann=FALSE, type="l",col="1",lwd=1,las=1)
axis(side=1, tck=0.01, las=0,tick=TRUE)
axis(side=2, tck=0.01, las=0,tick=TRUE,las=1)
box()
lines(t7data[["Year"]],t7data[["Anomaly"]],col="1",lwd=1)
points(t7data[["Year"]],t7data[["Anomaly"]],col="#000099",pch=19)
lines(lowess(t7data[["Year"]],t7data[["Anomaly"]],f=0.1),lwd=3,col="#CC0000")
mtext(side=1,cex=0.7,line=-1.1,"Data: NIWA Seven-station series temperature data\n https://www.niwa.co.nz/sites/niwa.co.nz/files/NZT7_Adjusted_Annual_TMean2018_Web-updated-jan-2019.xlsx")
mtext(side=3,cex=1.7, line=-4,expression(paste("New Zealand Mean Land Surface \nTemperature Anomalies 1909 - 2021")) )
mtext(side=2,cex=1, line=-1.3,"Temperature anomaly C vs 1981-2010 mean")
legend(1910, 1,bty='n',bg="white", cex = 0.8, c(paste("Mean", c("annual anomaly", "lowess smoothed anomaly 11 years f = 0.1"))),pch=c(19,NA),lty=c(1,1),lwd=c(1,3),col=c("#000099","#CC0000"))
mtext(side=4,cex=0.75, line=0.05,R.version.string)
abline(h=0,col="darkgray")
dev.off() 

write.table(t7data, file = "/home/user/R/nzt7/niwa-t7data.csv", sep = ",", col.names = TRUE, qmethod = "double",row.names = FALSE)

knit("nzt7.r", output = "nzt7.html", tangle = FALSE, quiet = FALSE, envir = parent.frame(), encoding = "UTF-8")
"[1] "nzt7.html"
# just a plain text file with a .html suffix 
knit("nzt7.r")
[1] "nzt7.txt"
# just a plain text file  
