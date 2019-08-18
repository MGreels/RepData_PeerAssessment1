#Time Series Bar Plot in ggplot2 for 

library(ggplot2)

barplot <- ggplot(data=IntAves, aes(x = Interval, y = x)) +
                geom_bar(stat = "identity")

barplot

## Find Maximum interval average

IntAves$Interval[which.max(IntAves$x)]
