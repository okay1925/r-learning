#Sample exercise#

#get "read_excel" function
require(readxl)

#load file
read_excel("D:/Dropbox/PJ_SEFC/16 Skills Dept/Sample exercise.xlsx", sheet="S1-ProjectDetails1")

#lable as "df" for dataset
df = read_excel("D:/Dropbox/PJ_SEFC/16 Skills Dept/Sample exercise.xlsx", sheet="S1-ProjectDetails1")

#to see data like browse
fix(df)

#to get varlist
names(df)

#to get summary
summary(df)
str(df)

#to know about the variable type (though str is a better option)
sapply(data, class)

#to get data.table package
install.packages("data.table")
#still requires some 'chron' package --> look into this
#update R to version 3.2.5

require(ggplot2)
test.survived = data.frame(Survived=rep("none", nrow(test)), test)
ggplot(percapitacost)

ggplot(mtcars, aes(x = mpg)) +
  geom_histogram(binwidth = 5,
                 colour = "black",
                 fill = "white") +
  labs(title = "Distribution - Miles Per Gallon",
       x = "Miles Per Gallon",
       y = "Count")

library(nycflights13)
nycflights13::flights #to see the tibble
jan1<- filter(flights, month==1, day==1)
#to be able to print the jan1 in the same command have brackets
(jan1 <- filter(flights, month==1, day==1))

(jan2 <-filter(flights, month==11| month==12))

#all these three forms are fine to get flights no delays more than 2 hrs
(jan3<-filter(flights, arr_delay<=120 | dep_delay<=120))
#OR
(jan3 <-filter(flights, !(arr_delay>120|dep_delay>120)))
#OR
(jan3<- filter(flights, arr_delay<=120, dep_delay<=120))
#^prefer to not get used to this one would not work for "jan4"


(jan4 <- filter(flights, month==1 & (arr_delay<=120 | dep_delay<=120)))


arrange(flights, year, month, day) #sort equivalent
arrange(flights, desc(month), day) #desc = descending order

#arrange by flights that were most delayed
arrange(flights, desc(dep_delay))

#arrange by flights that were most early with departures
arrange(flights, sched_dep_time)

arrange(flights, air_time) 
#^^how to make the printed result to incl air_time????

#select dep_time dep_delay arr_time arr_delay 
select(flights, dep_time, dep_delay, arr_time, dep_delay, arr_delay) #non-permanent drop equivalent

arrange (flights, desc(month), day) #this command can work right after a "select" cmd is run

flights_sml<- select(flights, year:day, ends_with("delay"), air_time)
#^here we forgot to include "distance"
flights_sml = data.frame(flights_sml, flights$distance)
mutate(flights_sml, gain=(arr_delay-dep_delay), speed= flights.distance/(air_time*60))
#^"gain" does not become a permanent feature though if you want to use in another mutate- u will have to 
#ensure that gain is recalculate in a new mutate row
e.g.
mutate(flights_sml, hour=air_time/60, gain_per_hour=gain/hour)
#^this wont work until you include "gain calculation"...i.e...

mutate(flights_sml, gain=arr_delay-dep_delay, hour=air_time/60,
        gain_per_hour=gain/hour)
#^this should work because "gain" has been calculated

#to rank 
min_rank(flights$arr_delay)

min_rank(desc(flights))
#SG, as am losing capacity to learn :p



###tips
#if you want missing values to be included in your R commands - ask explicitly
#is.na(x) 


#tapply(y, g, mean)
#^to get mean of y, at levels of g 

#SG
#one_of() <- how to use this function? before section 5.5. hadley
#Q3, 4 i dont understand
#if I want to see two cols from 2 diff data set e.g.
head(flight$distance, flight_sml$flight.distance)

#what if i want to see x no. of rows for 1 particular var?
head(flight$month, 50) #<-- this does not work!! 


#if one parameter is shorter than the other, 
#it will be automatically extended to be the same length. 
#This is most useful when one of the arguments is a single 
#number: air_time / 60, hours * 60 + minute, etc.

by_day <- group_by(flights, year, month, day)
summarise(by_day, delay=mean(dep_delay), na.rm=T)

  
by_dest <- group_by(flights, dest)
summarise(by_dest, count=n())
delay <- summarise(by_dest, count=n(), dist=mean(distance, na.rm=T), 
          delay=mean(arr_time, na.rm=T))
(delay1 <-filter(delay, count >20, dest!="HNL"))

#using Pipes
delay2 <- flights %>% group_by(dest) %>% summarise(count=n(), 
            dist=mean(distance, na.rm=T), delay=mean(arr_time, na.rm=T)) %>
  % filter(count>20, dest!="HNL")


#removing the cancelled flights in the delayed colum
not_cancelled = filter(flights, !is.na(dep_delay), !is.na(arr_delay))
#OR
not_cancelled = flights %>% filter(!is.na(dep_delay), !is.na(arr_delay))

not_cancelled %>% group_by(year, month, day) %>% summarise(mean = mean(dep_delay))

#identified by tailnum, and with highest avg delay
newset = not_cancelled %>% group_by(tailnum) %>% summarise(delays=mean(arr_delay))

ggplot(data=newset, mapping= aes(x=delays))+geom_freqpoly(binwidth=10)

#scatterplot of the above
#need to create the vars by summarise to use it in ggplot
newset1 = not_cancelled %>% group_by(tailnum) %>% 
  summarise(delays=mean(arr_delay), n=n())
  
ggplot(data=newset1, mapping=aes(x=delays, y=n))+geom_point(alpha=1/10)


##export to csv
write.csv(newset1, file="myTestData.csv", row.name=FALSE, na=".")
#row.names=FALSE => the index value for each row does not show up
#na ="." will ensure na to appear as 'missing value' through the dot .

#append to csv




#####varianceexplained.org##
library(ggplot2)
data("diamonds")
ggplot(data=diamonds, aes(x=carat, y=price))
#this wont show the graph because we have not specified the scotter or line or hist yet!
#this is just the structure
ggplot(diamonds, aes(x=carat, y=price)) #another way to write w/o data=diamonds
ggplot(data=diamonds, aes(x=carat, y=price)) + geom_point()

ggplot(data=diamonds, aes(x=carat, y=price, color =clarity)) + geom_point()
#here we add another layer of aesthetics, with color=clarity

#other ways of adding layers
ggplot(data=diamonds, aes(x=carat, y=price, color =clarity, size =color)) + geom_point()
ggplot(data=diamonds, aes(x=carat, y=price, color =clarity, shape =color, size=cut)) + geom_point()

ggplot(data=diamonds, aes(x=carat, y=price)) + geom_point() + geom_smooth(se=FALSE)
#this includes a line without the confidence interval marked in gray

ggplot(data=diamonds, aes(x=carat, y=price)) + geom_point() +geom_smooth(se=FALSE, method="lm")
#this includes a linear trend - the best fit line

ggplot(data=diamonds, aes(x=carat, y=price, color=clarity)) + geom_point() +geom_smooth(se=FALSE, method="lm")
#this creates one smoothing curve for each color
#you can delete geom_point() from this code line and get the graph w/o the scatter dots

ggplot(data=diamonds, aes(x=carat, y=price)) +geom_smooth()
#this gives the fit curve without the actual (scatter) points


ggplot(data=diamonds, aes(x=carat, y=price, color =clarity, size =color)) 
    + geom_point() + ggtitle("My scatter plot") 
#adding a title

ggplot(data=diamonds, aes(x=carat, y=price, color =clarity, size =color)) 
    + geom_point() + ggtitle("My scatter plot") + xlab("Weight(carats)") + xlim(0,2)
#limiting the values of x axis




