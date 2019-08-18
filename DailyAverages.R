## STep Histogram for total daily steps

library(ggplot2)

histo <- ggplot(data=subset(DayAves, !is.na(x)), aes(x)) + 
        geom_histogram(bins=10)

histo

mean(DayAves$x)
median(DayAves$x)