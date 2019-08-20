library(ggplot2)

ImpIAWE <- aggregate(ImpDat$steps, 
                     list(Interval = ImpDat$interval, 
                          weekend = is.weekend(as.Date(ImpDat$date))), 
                     mean)

WEplot <- ggplot(data=ImpIAWE, aes(x = Interval, y = x)) +
        geom_bar(stat = "identity") +
        facet_grid(weekend~.)

WEplot

## Find Maximum interval average

IntAves$Interval[which.max(IntAves$x)]