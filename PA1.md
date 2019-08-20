\#Reproducible Research - Programming Assignment \#1

Loading and Preprocessing the Data into R
-----------------------------------------

We start by downloading the dataset and saving to an R dataframe.

The raw dataframe is also reconfigured into two aggregate datasets, one
taking a daily total step count sum for all the days in the study and
the second computing an average for each 5 minute interval across the
study set.

    RawDat <- read.csv("activity/activity.csv")


    DayAves <- aggregate(RawDat$steps, 
                         list(Day = RawDat$date), 
                         sum,
                         na.rm = TRUE)

    IntAves <- aggregate(RawDat$steps, 
                         list(Interval = RawDat$interval), 
                         mean, 
                         na.rm = TRUE)

What is the Mean total Number of Steps taken per Day?
-----------------------------------------------------

    dailymean <- mean(DayAves$x)
    dailymed <- median(DayAves$x)

    library(ggplot2)

    histo <- ggplot(data=subset(DayAves, !is.na(x)), aes(x)) + 
            geom_histogram(bins=10)

    histo

![](PA1_files/figure-markdown_strict/Mean%20total%20Steps-1.png)

The mean total daily steps recorded was 9354.2295082 and teh median
total daily steps recorded was 10395

What is the Average Daily Activity Pattern?
-------------------------------------------

    library(ggplot2)

    maxint  <- IntAves$Interval[which.max(IntAves$x)]

    barplot <- ggplot(data=IntAves, aes(x = Interval, y = x)) +
                    geom_bar(stat = "identity")

    barplot

![](PA1_files/figure-markdown_strict/Daily%20Timestamp%20Averages-1.png)

The maximum steps occur daily during interval number 835.

Impute Missing Values
---------------------

Code Below will create a new dataset “ImpDat” with imputed data to
replace NAs. In the case of an NA, the code inserts the associated 5
minute interval average.

Code then reruns Daily and per interval averages for the two dataframes
created above.

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

    impmean <- mean(ImpDA$x)
    impmed <- median(ImpDA$x)

    imphist <- ggplot(data=subset(ImpDA, !is.na(x)), aes(x)) + 
            geom_histogram(bins=10)

    imphist

![](PA1_files/figure-markdown_strict/Impute%20Missing%20Values-1.png)

WIth missing data imputed the new daily mean step count is
1.076618910^{4} and the new daily median step count is 1.076618910^{4}

Are there differences in activity patterns between weekdays and weekends?
-------------------------------------------------------------------------

    library(chron)

    ## Warning: package 'chron' was built under R version 3.6.1

    ImpIAWE <- aggregate(ImpDat$steps, 
                         list(Interval = ImpDat$interval, 
                              weekend = is.weekend(as.Date(ImpDat$date))), 
                         mean)

    ImpIAWE$WE <- factor(ImpIAWE$weekend, labels = c("Weekday", "Weekend"))

    WEplot <- ggplot(data=ImpIAWE, aes(x = Interval, y = x)) +
            geom_bar(stat = "identity") +
            facet_grid(WE~.,)

    WEplot

![](PA1_files/figure-markdown_strict/Weekend%20v.%20Weekday%20Analysis-1.png)
