
require(e1071)
require(gmodels)
require(klaR)
save(smaller.df3, file = "Results_Nov-2016/AllGreekFiles_Smaller_30tokens_Dec-23.R")


# load saved data
load(file = "Results_Nov-2016/AllGreekFiles_Smaller_25tokens_Dec-26.R")

smaller.df3 <- smaller.df3[, 1:2500]
smaller.df <- ordered.df

# read meta data from disk; 
chunk.ratios.m <- read.csv(file="Polybius_metadata_750-token-chunks.csv", stringsAsFactors = FALSE, header = TRUE)
dim(chunk.ratios.m)
chunk.ratios.m[,2]
View(chunk.ratios.m)



# read in author.v for list of levels
author.factor <- chunk.ratios.m[, 1]
unique(author.factor)


# make empty objects for results of classification tests
svm.results.l <- list()
svm.error.matrix.l <- list()
testing.classes.l <- list()

i <- 1

timestamp()
for (i in 1:1000) {
  
  
  
  #create vector of random integers = 10% of obs in smaller.df
  testing.index.v <- sample (seq (1, nrow(smaller.df)), 12, prob = chunk.ratios.m[, 2])
  
  
  #create training and testing data matrices using testing.index.v and its inverse
  testing.data <- smaller.df[testing.index.v, ]
  training.data <- smaller.df[-testing.index.v, ]
  
  #create vectors of factors giving classes (here = authors) of each row in testing.data and training.data
  training.classes <- as.factor(author.factor[-testing.index.v])
  testing.classes <- as.factor(author.factor[testing.index.v])
  
  
  model.svm <- svm(training.data, training.classes, kernel = "linear", scale = FALSE, probability = TRUE, cross = 5)
  
  svm.results.l[[i]] <- predict(model.svm, testing.data)
  svm.error.matrix.l[[i]] <- errormatrix(testing.classes, svm.results.l[[i]])
  
  
  
}

timestamp()

#combine all matrices contained in err.matr.l into one matrix for export to .csv file
a <- do.call(rbind, svm.error.matrix.l)


save(svm.error.matrix.l, file="Results_NOv-2016/svmErrorMatrix_25tokens_Dec-27-2016.R")
save(svm.results.l, file="Results_Nov-2016/svmResults_25tokens_Dec-27-2016.R")
write.csv(a, file = "Results_Nov-2016/svmError_Spreadsheet_25tokens_Dec-27-2016.csv")


58*5


# make empty objects for results of classification tests
svm.results.l <- list()
svm.error.matrix.l <- list()
testing.classes.l <- list()

i <- 1

timestamp()
for (i in 1:100) {
  
  
  
  #create vector of random integers = 10% of obs in smaller.df
  testing.index.v <- sample (seq (1, nrow(smaller.df2)), 1641, prob = chunk.ratios.m[, 2])
  
  
  #create training and testing data matrices using testing.index.v and its inverse
  testing.data <- smaller.df2[testing.index.v, ]
  training.data <- smaller.df2[-testing.index.v, ]
  
  #create vectors of factors giving classes (here = authors) of each row in testing.data and training.data
  training.classes <- as.factor(author.factor[-testing.index.v])
  testing.classes <- as.factor(author.factor[testing.index.v])
  
  
  model.svm <- svm(training.data, training.classes, kernel = "linear", scale = FALSE)
  
  svm.results.l[[i]] <- predict(model.svm, testing.data)
  svm.error.matrix.l[[i]] <- errormatrix(testing.classes, svm.results.l[[i]])
  
  
  
}

timestamp()

#combine all matrices contained in err.matr.l into one matrix for export to .csv file
b <- do.call(rbind, svm.error.matrix.l)


save(svm.error.matrix.l, file="Results_Nov-2016/svmErrorMatrix_1000tokens_Dec-31-2016-C.R")
save(svm.results.l, file="Results_Nov-2016/svmResults_1000_Dec-31-2016-C.R")
write.csv(a, file = "Results_Nov-2016/svmError_Spreadsheet_1000tokens_moreVariables_Dec-31-2016-C.csv")

save(model.svm, file = "Results_Nov-2016/model_svm-Dec-31-C.R")


View(a)

sum(a[,3])
sum(b[,13])


sum(a[,13])/2
sum(b[,13])/2

1641*100


(12000-(sum(a[,3])/2))/12000
(164100-(sum(b[,13])/2))/164100

summary(model.svm)
model.svm$
dim(model.svm$decision.values)

dim(model.svm$SV)
View(model.svm$SV)

length(svm.error.matrix.l)
svm.error.matrix.l[[1]]
svm.results.l[[1]]
recheck <- svm(training.data, training.classes, kernel = "linear", scale = FALSE)




save(svm.error.matrix.l, file="Results_NOv-2016/svmErrorMatrix_40tokens_Dec-3-2016.R")
save(svm.results.l, file="Results_Nov-2016/svmResults_40tokens_Dec-3-2016.R")
write.csv(a, file = "Results_Nov-2016/svmError_Spreadsheet_40tokens_Dec-3-2016.csv")


save(svm.error.matrix.l, file="Results_Sept-2016/scaled-svmErrorMatrix_500tokens_Oct-1-2016.R")
save(svm.results.l, file="Results_Sept-2016/scaled-svmResults_500tokens_Oct-1-2016.R")
write.csv(a, file = "Results_Sept-2016/scaled-svmError_Spreadsheet_500tokens_Oct-1-2016.csv")


svm.results.l[[1]]

