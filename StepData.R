## Reads Step Data into a, then calculates an aggregate dataset 

RawDat <- read.csv("activity/activity.csv")


DayAves <- aggregate(RawDat$steps, 
                     list(Day = RawDat$date), 
                     sum)

IntAves <- aggregate(RawDat$steps, 
                     list(Interval = RawDat$interval), 
                     mean, 
                     na.rm = TRUE)