## Reads Step Data into a, then calculates an aggregate dataset 

RawDat <- read.csv("activity/activity.csv")


DayAves <- aggregate(RawDat$steps, 
                     list(Day = RawDat$date), 
                     sum,
                     na.rm = TRUE)

IntAves <- aggregate(RawDat$steps, 
                     list(Interval = RawDat$interval), 
                     mean, 
                     na.rm = TRUE)


#Loop to Impute data with NAs
ImpDat<- RawDat
for (i in 1:length(RawDat$steps)){
        if (is.na(ImpDat[i,1])){
                ImpDat[i,1] <- IntAves$x[
                        which(IntAves$Interval == round(ImpDat[i,3]))] 
        }
}

ImpDA <- aggregate(ImpDat$steps, 
                     list(Day = ImpDat$date), 
                     sum)

ImpIA <- aggregate(ImpDat$steps, 
                     list(Interval = ImpDat$interval), 
                     mean)

ImpIAWE <- aggregate(ImpDat$steps, list(Interval = ImpDat$interval, 
                        weekend = is.weekend(as.Date(ImpDat$date))), 
                   mean)