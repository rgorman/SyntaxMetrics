
# read in .csv file with probabilities for chunks.  The goal is to make each author equally likely
# to be chosen

prob.m <- read.csv (file="Rresults/Naive_Bayes_predictions/chunkSize2000/chunk_parameters5.csv")

#load package e1071
library(e1071)
# load package gmodels for functions to evaluate predictions
library (gmodels)

# load package klar for errormatrix() function
library(klaR)


# script to test Naive Bayes in multiple iterations.


# make list and vector objects to collect input and output data
testing.classes.l <- list()
sWord_predictions.l <- list()
sWord_predictions_raw.l <- list()
index.record.v <- NULL
err.matr.l <- list()
sW.classifier.l <- list()
i <- 1

for (i in 1:100) {
  #create vector of random integers = 10% of obs in smaller.df
  testing.index.v <- sample (seq (1, nrow(smaller.df)), 120, prob=chunk.ratios.m[, 2])
  
  #create training and testing data matrices using testing.index.v and its inverse
  testing.data <- smaller.df[testing.index.v, ]
  training.data <- smaller.df[-testing.index.v, ]
  
  #create vectors of factors giving classes (here = authors) of each row in testing.data and training.data
  training.classes <- as.factor(author.v[-testing.index.v])
  testing.classes <- as.factor(author.v[testing.index.v])
  
  #train the algorithm using training.data and training classes
  sWord_classifier <- naiveBayes(training.data, training.classes)
  
  # test the algorithm by using sWord_classifier to predict() the testing.data
  #store results in list object
  sWord_predictions.l[[i]] <- predict(sWord_classifier, testing.data)
 
  
  # make a file of the raw probabilities
  sWord_predictions_raw.l[[i]] <- predict(sWord_classifier, testing.data, type = "raw")
  
  #make record of index vectors so we can identify the particular chunks
  index.record.v <- append(index.record.v, testing.index.v)
  
  #make record of testing_classes 
  testing.classes.l[[i]] <-testing.classes
  

  #make list of error matrices
  err.matr.l[[i]] <- errormatrix(testing.classes.l[[i]], sWord_predictions.l[[i]]) 
  
  #collect the sWord_classifier objects
  sW.classifier.l[[i]] <- sWord_classifier
  
}

#combine all matrices contained in err.matr.l into one matrix for export to .csv file
a <- do.call(rbind, err.matr.l)




View(a)

sum(a[,6])


sum(a[,6])/2

10000-(sum(a[,6])/2)

(12000-(sum(a[,6])/2))/12000




write.csv(a, file="Rresults/Naive_Bayes_predictions/error_matrix.csv")
save(err.matr.l, file="Rresults/Naive_Bayes_predictions/errorMatrix.R")

# combine results in sWord_predictions.l into one data.frame object and save it as .csv file
my.list <- mapply(data.frame, sWord_predictions.l)
b <- do.call (rbind, my.list)
write.csv (b, file="Rresults/Naive_Bayes_predictions/predictions_made.csv")
save(sWord_predictions.l, file="Rresults/Naive_Bayes_predictions/predictionList.R")

# combine results in sWord_predictions_raw.l into one data.frame object and save it as .csv file
my.list <- mapply(data.frame, sWord_predictions_raw.l)
c <- do.call (rbind, my.list)
write.csv (c, file="Rresults/Naive_Bayes_predictions/raw_predictions_made.csv")
save(sWord_predictions_raw.l, file="Rresults/Naive_Bayes_predictions/rawPredictions.R")

# combine results in testing.classes.l into one data.frame object and save it as .csv file
my.list <- mapply(data.frame, testing.classes.l)
d <- do.call (rbind, my.list)
write.csv (d, file="Rresults/Naive_Bayes_predictions/right_answers.csv")
save(testing.classes.l, file="Rresults/Naive_Bayes_predictions/correctAnswers.R")

#save list of sWord_classifier objects as binary file
save(sW.classifier.l, file="Rresults/Naive_Bayes_predictions/list_of_classifiers.R")

# save the index numbers so that chunks can be traced back to originals
# one file is a matrix with each classification attempt represented on 
#one line, the other file is a single vector to serve as back up.
index.record.m <- matrix(index.record.v, nrow=100, ncol=28, byrow=TRUE)
write.csv(index.record.m, file="Rresults/Naive_Bayes_predictions/index_matrix.csv")
write.csv(index.record.v, file="Rresults/Naive_Bayes_predictions/index_vector.csv")
