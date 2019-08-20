library(ggplot2)
library(chron)
ImpIAWE <- aggregate(ImpDat$steps, 
                     list(Interval = ImpDat$interval, 
                          weekend = is.weekend(as.Date(ImpDat$date))), 
                     mean)

ImpIAWE$WE <- factor(ImpIAWE$weekend, labels = c("Weekend", "Weekday"))

WEplot <- ggplot(data=ImpIAWE, aes(x = Interval, y = x)) +
        geom_bar(stat = "identity") +
        facet_grid(WE~.,)

WEplot

## Find Maximum interval average

IntAves$Interval[which.max(IntAves$x)]