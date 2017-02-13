
# a script to run svm classification algorithm

#load package e1071
library(e1071)
# load package gmodels for functions to evaluate predictions
library (gmodels)

# load package klar for errormatrix() function
library(klaR)

# import class names for chunks into matrix object
# chunk.authors.m <- read.csv(file = "Rresults/matrices/AuthorFactor_1000tokenChunks_June-13-2016.csv", stringsAsFactors = FALSE)
chunk.authors.m <- read.csv(file = "Rresults/matrices/AuthorFactor_500tokenChunks_June-20-2016.csv", stringsAsFactors = FALSE)
# put relevant column of matrix into vector object
author.v <- chunk.authors.m[, 2]

# import probabilites for function sample(); this argument will ensure that a fairly equal number of chunks will be sampled from
# each author represented
# probs.m <- read.csv(file = "Rresults/matrices/chunk_ratios_1000.csv", stringsAsFactors = FALSE)
probs.m <- read.csv(file = "Rresults/matrices/chunk_ratios_500.csv", stringsAsFactors = FALSE)

# make list and vector objects to collect input and output data

svm.results.l <- list()
svm.error.matrix.l <- list()
testing.classes.l <- list()

i <- 1


for (i in 1:100) {
  
  testing.index <- sample(1:347, 36, prob = probs.m[, 2])
  
  testing.data <- smaller.df[testing.index, ]
  training.data <- smaller.df[-testing.index, ]
  
  testing.classes <- as.factor(author.v[testing.index])
  training.classes <- as.factor(author.v[-testing.index])
  
  svm.model <- svm(training.data, training.classes, kernel = "linear", scale = FALSE, cost = 1)
  svm.results.l[[i]] <- predict(svm.model, testing.data)
  
  
  svm.error.matrix.l[[i]] <- errormatrix(testing.classes, svm.results.l[[i]])
  
  
}

#combine all matrices contained in err.matr.l into one matrix for export to .csv file
a <- do.call(rbind, svm.error.matrix.l)
View(a)
sum(a[, 6])
(1800- (sum(a[, 6])/2))/1800
(3600-(sum(a[, 6])/2))/3600
write.csv(a, file="Rresults/svmError_matrix__sWordLevels_FalseScale_1006Obs_NoStubs_June-14-2016.csv")


