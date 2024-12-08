## Temperature series by NIWA Seven Station Series but with reference to a baseline of the 1961-1990 average

New Zealand NIWA Seven-station series land surface temperature data 1909 to date

https://www.niwa.co.nz/our-science/climate/information-and-resources/nz-temp-record/seven-station-series-temperature-data

# NIWA "7-STATION" TEMPERATURE SERIES: ANNUAL DATA for MEAN Temperature: Version 3.1 (updated January 2019)
# Temp = Annual average mean temperature (deg C);  "Anomaly" = Temp(Year) minus 1981-2010 average ***
# Notes:
# 1) 7-Station Composite Anomaly = Average of anomalies at individual sites where there is data for that year (<7 sites before 1913)
# 2) 7-Station Composite Temperature = 7-Station Anomaly + Average of 7-Station 1981-2010 climatologies, E.g., for 1909 when there are 4 sites, the 7-Station Composite Temp is NOT the average of the Wellington, Nelson, Lincoln and Dunedin values.
# 3) The climatologies are specific to the "Reference" stations at each location, which are: Auckland Aero (Auckland, agent 1962), East Taratahi AWS (Masterton, agent 2612), Kelburn (Wellington, agent 3385), Hokitika Aero (Hokitika, agent 3909), Nelson Aero (Nelson, agent 4241), Lincoln Broadfield EWS (Lincoln, agent 17603), and Musselburgh EWS (Dunedin, agent 15752).

# load library
library(readxl)

# obtain data sheet from NIWA
url <- c("https://www.niwa.co.nz/sites/niwa.co.nz/files/NZT7_Adjusted_Annual_TMean2018_Web-updated-jan-2019.xlsx")
file <- c("/home/user/R/nzt7/NZT7_Adjusted_Annual_TMean2018_Web-updated-jan-2019.xlsx")
download.file(url, file)
trying URL 'https://www.niwa.co.nz/sites/niwa.co.nz/files/NZT7_Adjusted_Annual_TMean2018_Web-updated-jan-2019.xlsx'
Content type 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' length 22763 bytes (22 KB)
==================================================
downloaded 22 KB

# List all sheets in an excel spreadsheet 
excel_sheets("NZT7_Adjusted_Annual_TMean2018_Web-updated-jan-2019.xlsx")
[1] "NZT7_Adjusted_TMean2016_Web"

t7data <-read_excel("NZT7_Adjusted_Annual_TMean2018_Web-updated-jan-2019.xlsx", sheet = "NZT7_Adjusted_TMean2016_Web", range ="Q12:Q122", col_names = T, skip =11,col_types = c("guess"))
# Alternatively read in the tidied data in csv format
#t7data <- read.csv("niwa-t7data.csv")

str(t7data) 
'data.frame':	114 obs. of  2 variables:
 $ Year   : int  1909 1910 1911 1912 1913 1914 1915 1916 1917 1918 ...
 $ Anomaly: num  -0.22 -0.15 -0.66 -1.28 -1.04 -1.03 -0.67 0.38 0.19 -0.8

#Classes ‘tbl_df’, ‘tbl’ and 'data.frame':	110 obs. of  1 variable:
# $ Anomaly: num  -0.22 -0.15 -0.66 -1.28 -1.04 -1.03 -0.67 0.38 0.19 -0.8 ...

# read in years
year <-read_excel("NZT7_Adjusted_Annual_TMean2018_Web-updated-jan-2019.xlsx", sheet = "NZT7_Adjusted_TMean2016_Web", range ="A12:A122", col_names = T, skip =11,col_types = c("guess"))
str(year) 
Classes ‘tbl_df’, ‘tbl’ and 'data.frame':	110 obs. of  1 variable:
 $ X__1: num  1909 1910 1911 1912 1913 . 
 
t7data<-cbind(year,t7data) 
# check straucture of dataframe
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
# write dataframe to .csv file
write.table(t7data, file = "/home/user/R/nzt7/niwa-t7data.csv", sep = ",", col.names = TRUE, qmethod = "double",row.names = FALSE)

# read back tidy data file

t7data <- read.csv("/home/user/R/nzt7/niwa-t7data.csv") 

# add 2019 annual anomaly 0.76 C ref https://niwa.co.nz/climate/summaries/annual-climate-summary-2019 and ref https://www.nzherald.co.nz/environment/news/article.cfm?c_id=39&objectid=12299091 "New Zealand's nationwide average temperature for 2019, calculated using stations in Niwa's seven-station temperature series which began in 1909, came in at 13.37C - or 0.76C above the 1981–2010 annual average." This trend is not our friend' - 2019 NZ's fourth hottest year
9 Jan, 2020 11:00am, Jamie Morton 

t7data <- rbind(t7data,c(2019,0.76))

# add 2020 anomaly https://niwa.co.nz/climate/summaries/annual-climate-summary-2020 2020 was Aotearoa New Zealand’s 7th-warmest year on record. The nationwide average temperature for 2020, calculated using stations in NIWA’s seven-station temperature series which began in 1909, was 13.24°C (0.63°C above the 1981–2010 annual average).
t7data <- rbind(t7data,c(2020,0.63))

# add 2021 anomaly https://niwa.co.nz/climate/summaries/annual-climate-summary-2021   Annual Climate Summary 2021 11 January 2022 2021 was Aotearoa New Zealand’s warmest year on record, surpassing the previous record set in 2016. Seven of the past nine years have been among New Zealand’s warmest on record. This trend is consistent with the overall pattern of global warming. The nationwide average temperature for 2021, calculated using stations in NIWA’s seven-station temperature series which began in 1909, was 13.56°C (0.95°C above the 1981–2010 annual average).

t7data <- rbind(t7data,c(2021,0.95))

# add 2022 anomaly https://niwa.co.nz/climate/summaries/annual-climate-summary-2022 11 January 2023: New Zealand’s warmest year on record, again. Overview 2022 was Aotearoa New Zealand’s warmest year on record, surpassing the record set just last year (Figure 1,Figure 2a). The nationwide average temperature for 2022 calculated using stations in NIWA’s seven-station series was 13.76˚C, being +1.15˚C above the 1981-2010 annual average, surpassing 2021 by +0.20˚C

t7data <- rbind(t7data,c(2022,1.15))

# read in data up to 2022
t7data <- read.csv("niwa-t7data.csv")  

# add 2023 anomaly	https://niwa.co.nz/climate/summaries/annual-climate-summary-2023 "2023 was Aotearoa New Zealand’s 2nd warmest year on record, just shy of the record set in 2022 (Figure 1a). The nationwide average temperature for 2023 calculated from NIWA’s seven station series was 13.61˚C, being 0.87˚C above the 1991-2020 annual average".
# add 2023 anomaly
t7data <- rbind(t7data,c(2023,0.87))
 
str(t7data)
'data.frame':	115 obs. of  2 variables:
 $ Year   : num  1909 1910 1911 1912 1913 ...
 $ Anomaly: num  -0.22 -0.15 -0.66 -1.28 -1.04 -1.03 -0.67 0.38 0.19 -0.8 ...
# 2022
#'data.frame':	114 obs. of  2 variables:
# $ Year   : int  1909 1910 1911 1912 1913 1914 1915 1916 1917 1918 ...
# $ Anomaly: num  -0.22 -0.15 -0.66 -1.28 -1.04 -1.03 -0.67 0.38 0.19 -0.8 ... 

tail(t7data,2)
    Year Anomaly
114 2022    1.15
115 2023    0.87

# calculate absolute change - last (115th) anomaly less first (1st) anomaly
t7data[["Anomaly"]][115] - t7data[["Anomaly"]][1]
[1] 1.09
# [1] 1.37 

# create svg format chart with 14 pt text font and grid lines via 'grid' and linear trend line
#png("nzt7timeseries2022-560by420.png", bg="white", width=560, height=420,pointsize = 12)
svg(filename="/home/user/R/nzt7/nzt7timeseries2022-720by540.svg", width = 8, height = 6, pointsize = 14, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))  
par(mar=c(2.7,2.7,1,1)+0.1)
plot(t7data,tck=0.01,ylim=c(-1.5,1.25),axes=TRUE,ann=TRUE, las=1,col=2,lwd=2,type='l',lty=1)
grid(col="darkgray",lwd=1)
axis(side=4, tck=0.01, las=0,tick=TRUE,labels = FALSE)
mtext(side=1,cex=0.7,line=-1.3,"Data: https://www.niwa.co.nz/sites/niwa.co.nz/files/NZT7_Adjusted_Annual_TMean2018_Web-updated-jan-2019.xlsx")
mtext(side=3,cex=1.7, line=-4,expression(paste("New Zealand annual average temperature \nanomaly 1909 - 2023")) )
mtext(side=2,cex=0.9, line=-1.3,"Temperature anomaly C vs 1981-2010 mean")
mtext(side=4,cex=0.75, line=0.05,R.version.string)
abline(lm(t7data[["Anomaly"]]~t7data[["Year"]]),col="#000099",lwd=2,lty=2)
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

# create graph in the style of a NASA GISS chart with lowess regression line
svg(filename="NZ-T7-land-temp-anom-2022-720by540.svg", width = 8, height = 6, pointsize = 14, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))
par(mar=c(2.7,2.7,1,1)+0.1)
plot(t7data[["Year"]],t7data[["Anomaly"]],ylim=c(-1.5,1.45),xlim=c(1905,2023),tck=0.01,axes=FALSE,ann=FALSE, type="l",col="1",lwd=1,las=1)
axis(side=1, tck=0.01, las=0,tick=TRUE)
axis(side=2, tck=0.01, las=0,tick=TRUE,las=1)
box()
lines(t7data[["Year"]],t7data[["Anomaly"]],col="1",lwd=1)
points(t7data[["Year"]],t7data[["Anomaly"]],col="#000099",pch=19)
lines(lowess(t7data[["Year"]],t7data[["Anomaly"]],f=0.1),lwd=3,col="#CC0000")
mtext(side=1,cex=0.7,line=-1.1,"Data: NIWA Seven-station series temperature data\n https://www.niwa.co.nz/sites/niwa.co.nz/files/NZT7_Adjusted_Annual_TMean2018_Web-updated-jan-2019.xlsx")
mtext(side=3,cex=1.7, line=-4,expression(paste("New Zealand mean land surface \ntemperature anomalies 1909 - 2023")) )
mtext(side=2,cex=1, line=-1.3,"Temperature anomaly C vs 1981-2010 mean")
legend(1910, 1,bty='n',bg="white", cex = 0.8, c(paste("Mean", c("annual anomaly", "lowess smoothed anomaly 11 years f = 0.1"))),pch=c(19,NA),lty=c(1,1),lwd=c(1,3),col=c("#000099","#CC0000"))
mtext(side=4,cex=0.75, line=0.05,R.version.string)
abline(h=0,col="darkgray")
dev.off() 

write.table(t7data, file = "/home/user/R/nzt7/niwa-t7data.csv", sep = ",", col.names = TRUE, qmethod = "double",row.names = FALSE)

--------------------------------------
# convert t7data into time series object
# find start
head(t7data,1)
  Year Anomaly
1 1909   -0.22 
# find end
tail(t7data,1)
    Year Anomaly
113 2021    0.95

# create a time series object ts(data = NA, start = 1, end = numeric(), frequency = 1, deltat = 1, ts.eps = getOption("ts.eps"), class = , names = )

t7timeseries <- ts(t7data[["Anomaly"]], start = 1909, end = 2023, frequency =1 )
is.ts(t7timeseries)
[1] TRUE 
str(t7timeseries)
Time-Series [1:115] from 1909 to 2023: -0.22 -0.15 -0.66 -1.28 -1.04 -1.03 -0.67 0.38 0.19 -0.8 ...
print(t7timeseries)
Time Series:
Start = 1909 
End = 2023 
Frequency = 1 
  [1] -0.22 -0.15 -0.66 -1.28 -1.04 -1.03 -0.67  0.38  0.19 -0.80 -1.22 -1.07
 [13] -0.75 -0.60 -0.76  0.20 -1.02 -0.83 -0.99  0.09 -0.66 -1.36 -1.16 -1.01
 [25] -0.55 -0.34 -0.14 -0.72 -0.94  0.24 -0.68 -0.86 -0.88 -0.58 -0.85 -0.83
 [37] -1.07 -0.81 -0.55 -0.32 -0.60 -0.48 -0.81 -0.48 -0.55 -0.01  0.18  0.31
 [49] -0.15 -0.22 -0.46 -0.34 -0.33  0.30 -0.65 -0.59 -0.73 -0.46 -0.34 -0.40
 [61] -0.43  0.26  0.50 -0.37  0.08  0.13  0.00 -0.88 -0.84  0.21 -0.06 -0.35
 [73]  0.25 -0.49 -0.58  0.07  0.24  0.05  0.16  0.32  0.36  0.38 -0.44 -1.13
 [85] -0.77 -0.28 -0.02 -0.16 -0.33  0.80  0.74  0.18  0.29  0.06  0.01 -0.44
 [97]  0.50 -0.21  0.06  0.25 -0.32  0.46  0.22 -0.15  0.72  0.18  0.14  0.84
[109]  0.54  0.80  0.76  0.63  0.95  1.15  0.87

dput(t7timeseries)
structure(c(-0.22, -0.15, -0.66, -1.28, -1.04, -1.03, -0.67, 
0.38, 0.19, -0.8, -1.22, -1.07, -0.75, -0.6, -0.76, 0.2, -1.02, 
-0.83, -0.99, 0.09, -0.66, -1.36, -1.16, -1.01, -0.55, -0.34, 
-0.14, -0.72, -0.94, 0.24, -0.68, -0.86, -0.88, -0.58, -0.85, 
-0.83, -1.07, -0.81, -0.55, -0.32, -0.6, -0.48, -0.81, -0.48, 
-0.55, -0.01, 0.18, 0.31, -0.15, -0.22, -0.46, -0.34, -0.33, 
0.3, -0.65, -0.59, -0.73, -0.46, -0.34, -0.4, -0.43, 0.26, 0.5, 
-0.37, 0.08, 0.13, 0, -0.88, -0.84, 0.21, -0.06, -0.35, 0.25, 
-0.49, -0.58, 0.07, 0.24, 0.05, 0.16, 0.32, 0.36, 0.38, -0.44, 
-1.13, -0.77, -0.28, -0.02, -0.16, -0.33, 0.8, 0.74, 0.18, 0.29, 
0.06, 0.01, -0.44, 0.5, -0.21, 0.06, 0.25, -0.32, 0.46, 0.22, 
-0.15, 0.72, 0.18, 0.14, 0.84, 0.54, 0.8, 0.76, 0.63, 0.95, 1.15, 
0.87), tsp = c(1909, 2023, 1), class = "ts")

svg(filename="NZ-T7-land-temp-anom-2021-720by540-TS.svg", width = 8, height = 6, pointsize = 14, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))
par(mar=c(2.7,2.7,1,1)+0.1)
plot(t7timeseries,ylim=c(-1.5,1.45),xlim=c(1905,2021),tck=0.01,axes=FALSE,ann=FALSE, type="l",col="1",lwd=1,las=1)
axis(side=1, tck=0.01, las=0,tick=TRUE)
axis(side=2, tck=0.01, las=0,tick=TRUE,las=1)
box()
lines(t7timeseries,col="1",lwd=1)
points(t7timeseries,col="#000099",pch=19)
lines(lowess(t7timeseries,f=0.1),lwd=3,col="#CC0000")
mtext(side=1,cex=0.7,line=-1.1,"Data: NIWA Seven-station series temperature data\n https://www.niwa.co.nz/sites/niwa.co.nz/files/NZT7_Adjusted_Annual_TMean2018_Web-updated-jan-2019.xlsx")
mtext(side=3,cex=1.7, line=-4,expression(paste("New Zealand Mean Land Surface \nTemperature Anomalies 1909 - 2021")) )
mtext(side=2,cex=1, line=-1.3,"Temperature anomaly C vs 1981-2010 mean")
legend(1910, 1,bty='n',bg="white", cex = 0.8, c(paste("Mean", c("annual anomaly", "lowess smoothed anomaly 11 years f = 0.1"))),pch=c(19,NA),lty=c(1,1),lwd=c(1,3),col=c("#000099","#CC0000"))
mtext(side=4,cex=0.75, line=0.05,R.version.string)
abline(h=0,col="darkgray")
dev.off()

t7timeseriesv2 <- structure(c(-0.22, -0.15, -0.66, -1.28, -1.04, -1.03, -0.67, 
0.38, 0.19, -0.8, -1.22, -1.07, -0.75, -0.6, -0.76, 0.2, -1.02, 
-0.83, -0.99, 0.09, -0.66, -1.36, -1.16, -1.01, -0.55, -0.34, 
-0.14, -0.72, -0.94, 0.24, -0.68, -0.86, -0.88, -0.58, -0.85, 
-0.83, -1.07, -0.81, -0.55, -0.32, -0.6, -0.48, -0.81, -0.48, 
-0.55, -0.01, 0.18, 0.31, -0.15, -0.22, -0.46, -0.34, -0.33, 
0.3, -0.65, -0.59, -0.73, -0.46, -0.34, -0.4, -0.43, 0.26, 0.5, 
-0.37, 0.08, 0.13, 0, -0.88, -0.84, 0.21, -0.06, -0.35, 0.25, 
-0.49, -0.58, 0.07, 0.24, 0.05, 0.16, 0.32, 0.36, 0.38, -0.44, 
-1.13, -0.77, -0.28, -0.02, -0.16, -0.33, 0.8, 0.74, 0.18, 0.29, 
0.06, 0.01, -0.44, 0.5, -0.21, 0.06, 0.25, -0.32, 0.46, 0.22, 
-0.15, 0.72, 0.18, 0.14, 0.84, 0.54, 0.8, 0.76, 0.63, 0.95), tsp = c(1909, 
2021, 1), class = "ts") 
str(t7timeseriesv2)
Time-Series [1:113] from 1909 to 2021: -0.22 -0.15 -0.66 -1.28 -1.04 -1.03 -0.67 0.38 0.19 -0.8 ... 

# Apply identical function
identical(t7timeseries, t7timeseriesv2)
[1] TRUE
--------------------------------------------------------
t7data <- read.csv("niwa-t7data.csv")  

str(t7data)
'data.frame':	115 obs. of  2 variables:
 $ Year   : int  1909 1910 1911 1912 1913 1914 1915 1916 1917 1918 ...
 $ Anomaly: num  -0.22 -0.15 -0.66 -1.28 -1.04 -1.03 -0.67 0.38 0.19 -0.8 ...

# create a dataframe with Date format column and temperature anomaly in numeric format
t7df <- data.frame(Date = seq(as.Date("1909/12/31"), by = "year", length.out = 115), Anomaly = t7data[["Anomaly"]] ) 

str(t7df)
'data.frame':	115 obs. of  2 variables:
 $ Date   : Date, format: "1909-12-31" "1910-12-31" ...
 $ Anomaly: num  -0.22 -0.15 -0.66 -1.28 -1.04 -1.03 -0.67 0.38 0.19 -0.8 ... 
 
# write dataframe to .csv file
write.table(t7df, file = "/home/user/R/nzt7/t7dataframe.csv", sep = ",", col.names = TRUE, qmethod = "double",row.names = FALSE)

# create a zoo time series matrix 
library(zoo)
t7zoo <- zoo(x= t7df[["Anomaly"]],  order.by = t7df[["Date"]]) 
str(t7zoo) 
‘zoo’ series from 1909-12-31 to 2023-12-31
  Data: num [1:115] -0.22 -0.15 -0.66 -1.28 -1.04 -1.03 -0.67 0.38 0.19 -0.8 ...
  Index:  Date[1:115], format: "1909-12-31" "1910-12-31" "1911-12-31" "1912-12-31" "1913-12-31" ... 

coredata(t7zoo)
  
svg(filename="NZ-T7-land-temp-anom-df-2021-720by540-TS.svg", width = 8, height = 6, pointsize = 14, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))
par(mar=c(2.7,2.7,1,1)+0.1)
plot(t7zoo,tck=0.01, type="l",col="1",lwd=1,las=1)
axis(side=4, tck=0.01, las=0,tick=TRUE,label=FALSE)
axis(side=2, tck=0.01, las=0,tick=TRUE,las=1)
#box()
lines(t7zoo,col="1",lwd=1)
points(t7zoo,col="blue",pch=19)
abline(lm(coredata(t7zoo) ~ index(t7zoo)),col="#CC0000",lwd=2,lty=1)
mtext(side=1,cex=0.7,line=-1.1,"Data: NIWA Seven-station series temperature data\n https://www.niwa.co.nz/sites/niwa.co.nz/files/NZT7_Adjusted_Annual_TMean2018_Web-updated-jan-2019.xlsx")
mtext(side=3,cex=1.7, line=-4,expression(paste("New Zealand mean land surface \ntemperature anomalies 1909 - 2023")) )
mtext(side=2,cex=1, line=-1.3,"Temperature anomaly C vs 1981-2010 mean")
legend(-12000, 0.8,bty='n',bg="white", cex = 0.8, c(paste("Mean annual anomaly")),pch=c(19),lty=c(1),lwd=c(1),col=c("blue"))
mtext(side=4,cex=0.75, line=0.05,R.version.string)
abline(h=0,col="darkgray")
dev.off()

summary(lm(coredata(t7zoo) ~ index(t7zoo)))
Call:
lm(formula = coredata(t7zoo) ~ index(t7zoo))

Residuals:
     Min       1Q   Median       3Q      Max 
-1.18631 -0.32620 -0.05027  0.28686  1.17963 

Coefficients:
               Estimate Std. Error t value Pr(>|t|)    
(Intercept)  -2.027e-01  4.019e-02  -5.044 1.76e-06 ***
index(t7zoo)  3.083e-05  3.301e-06   9.340 1.03e-15 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.4292 on 113 degrees of freedom
Multiple R-squared:  0.4357,	Adjusted R-squared:  0.4307 
F-statistic: 87.24 on 1 and 113 DF,  p-value: 1.025e-15 

R.version.string
[1] "R version 4.3.2 (2023-10-31)"

sessionInfo()
R version 4.3.2 (2023-10-31)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Debian GNU/Linux 12 (bookworm)

Matrix products: default
BLAS:   /usr/lib/x86_64-linux-gnu/blas/libblas.so.3.11.0
LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.11.0

locale:
 [1] LC_CTYPE=en_NZ.UTF-8          LC_NUMERIC=C
 [3] LC_TIME=en_NZ.UTF-8           LC_COLLATE=en_NZ.UTF-8
 [5] LC_MONETARY=en_NZ.UTF-8       LC_MESSAGES=en_NZ.UTF-8
 [7] LC_PAPER=en_NZ.UTF-8          LC_NAME=en_NZ.UTF-8
 [9] LC_ADDRESS=en_NZ.UTF-8        LC_TELEPHONE=en_NZ.UTF-8
[11] LC_MEASUREMENT=en_NZ.UTF-8    LC_IDENTIFICATION=en_NZ.UTF-8

time zone: Pacific/Auckland
tzcode source: system (glibc)

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base

other attached packages:
[1] rkward_0.7.5

loaded via a namespace (and not attached):
[1] compiler_4.3.2 tools_4.3.2

library(simplermarkdown)
example1 <- system.file("examples/example1.md", package = "simplermarkdown")
ls()
[1] "example1"
str(example1)
chr "/usr/lib/R/site-library/simplermarkdown/examples/example1.md"

mdweave(example1, "example1_woven.md")
Evaluating code in block 'codeblock1'.
Evaluating code in block '<unlabeled code block>'.
Evaluating code in inline block '<unlabeled inline block>'.
Evaluating code in inline block '<unlabeled inline block>'.
Evaluating code in block '<unlabeled code block>'.
Evaluating code in block '<unlabeled code block>'.
Warning message:
In eval(ei, envir) : FOO
 ls()
[1] "a"        "b"        "c"        "dta"      "example1" "m"
a
b
c
str(dta)
'data.frame':	150 obs. of  6 variables:
 $ Sepal.Length: num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
 $ Sepal.Width : num  3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
 $ Petal.Length: num  1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
 $ Petal.Width : num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
 $ Species     : Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ foo         : num  0.686 0.612 0.681 0.674 0.72 ...

system("pandoc example1_woven.md -o example1.pdf")

mdweave_to_html

To process your markdown file you can use the mdweave function:

mdweave("mydocument.md", "mydocument_woven.md")
# hwriter

dta.html <- hwrite(dta, page=NULL)
getwd()
