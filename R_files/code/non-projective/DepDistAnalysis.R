# script to extraxt DepDist from xm; file and store in vector object

require(XML)

# this line reads an XML file into an R object
doc.object <- xmlTreeParse(file = "../Projectivity/working/Result_DD_Combined.xml")




# this line reads doc.object into an XML Node object which can be accessed through subsetting
top <- xmlRoot(doc.object)
top[[6]]

###########################

# A loop to extract @head and @id attributes from word elements and use them to compute Dependency Distance.
# The loop should start with the subset of "top" which represents the first sentence element.

# wrapper varaibles for processing
a <- NULL
b <- NULL
c <- NULL
d <- NULL
# Sets increment variable to first <sentence> element in file.
i <- 7



for (i in i:length(top)) {
  a <- as.numeric(xmlGetAttr(top[[i]], "DepDist"))
  b <- append(b, a)
  
  c <- as.numeric(xmlGetAttr(top[[i]], "id"))
  d <- append(d, c)
  
}

which (is.na(b))


###############
# This section reads in time data on file and looks for correlations

time_dataframe <- read.csv(file = "../Projectivity/working/working_Combined.csv")



View(time_dataframe)


# add dep dist column to data frame
time_dataframe$DepDist <- b

# add sentence numbers in top object to make sure sentences line up with depdist
time_dataframe$topSentNum <- d

# test for skewness
require(e1071)
skewness(time[index])
  
##############################
#######  here we run some test looking for correlations

# read in spreadsheet with time data
time_dataframe <- read.csv(file = "../Projectivity/working/working_Combined.csv")

colnames(time_dataframe)

# create vector objects to store variables for easier processing
time <- time_dataframe$depPerWord # our dependent varaible
log_time <- log(time_dataframe$depPerWord) # log() of time to compensate for skew

# store independent variable in vector for testing
indepVar <- time_dataframe$DepDist
indepVar <- time_dataframe$VerbPerToken

# examine rough contours of data
summary(time)
summary(log_time)
summary(indepVar)
summary(log(depVar))

index <- which(time < 5)
summary(time[index])

summary(indepVar[index])

plot (log(indepVar[index]), log(time[index]), main = "DD and Sentence Difficulty", ylab = "Time per Word (log)", 
      xlab = "Dependency Distance (log)")
lines(lowess(x, y), col = "red", lwd = 2)

x <- log(indepVar[index])
y <- log(time[index])
cor(x,y)


c <- indepVar[index]
d <- time[index]
e <- time_dataframe$words[index]
f <- time_dataframe$VerbPerToken[index]
plot(c,d)

which(time_dataframe$DepDist==2)

lm(x ~ y)
model <- lm (y ~ x )
summary(model)

# visualize data
hist(time, col = "pink",main = "Dependency Time per Word")
boxplot(time)
hist(log_time)
hist(depVar)
hist(log(depVar))


# plot some data to see if any correlations are visible
plot(indepVar, time)
lines(lowess(indepVar, time), col="blue") # lowess line (x,y)
cor(indepVar, time)
cor(time, log(depVar))
cor(log (time), depVar)



plot(log_tiime, depVar)
cor(time, depVar)

plot(log_time, log(depVar))
lines(lowess(log_time, log(depVar)), col="blue") # lowess line (x,y)
cor(log_time, log(depVar))

###########
# trim the skew off the independent variable and examine again
index <- which(time < 4)
summary(time[index])
summary(depVar[index])
summary(log(time[index]))
summary(log(depVar[index]))
cor(log (time[index]), log(depVar[index]))


plot(time[index], depVar[index],  xlab = "Time per Word", ylab = "Dependency Distance", main = "Syntax Difficulty")
lines(lowess(time[index], depVar[index]), col = "red")

plot(log(time[index]), log(depVar[index]), xlab = "Time per Word (log)", ylab = "Dep. Dist. (log)", main = "Syntax Difficulty")
lines(lowess(log(time[index]), log(depVar[index])), col = "red")

##############################
# extract a subset of sentences with roughly similar DDs to try to see why they differ so greatly in time
# make index variable for lower limit


 time_dataframe$depPerWord [which(time_dataframe$DepDist == 2)]
time_dataframe$sent [which(time_dataframe$DepDist == 2)]
top_index <-  which(time_dataframe$DepDist == 2)
DD2_top <- top[6 + top_index]
DD2_top

#################
# short sentences are too volitile and shoud be removed

no_shorties <- which(time_dataframe$words > 15)
no_outliers <- which(time < 5)
intersect (no_shorties, no_outliers)
new_index <- intersect (no_shorties, no_outliers)
plot(log(indepVar[new_index]), log(time[new_index]))
lines( lowess(a,b))
a <- log(indepVar[new_index])
b <-  log(time[new_index])
cor(a,b)

    #######################################
# this line will save file as .xml
saveXML(top, file = "../Projectivity/working/XXXX.xml", prefix = '<?xml version="1.0" encoding="UTF-8"?>\n')
# save dataframe to csv file
write.csv(time_dataframe, file = "../Projectivity/working/working_Combined.csv")

d

# clear all objects from memory
rm(list = ls())
