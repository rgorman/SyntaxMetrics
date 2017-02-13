# clean workspace
rm(list = ls())

smaller.df <- ordered.df

require(e1071)
require(gmodels)
require(klaR)

# read data from disk
smaller.df <- read.csv(file="Results_Nov-2016/AllGreekFiles_125tokens_Nov-24.csv", stringsAsFactors = FALSE, header = TRUE, row.names = 1,)
View(smaller.df)
row.names(smaller.df)

# to test tha value of scaling, use the  following:
smaller.df <- scale(smaller.df)

# read meta data from disk; 
chunk.ratios.m <- read.csv(file="Results_Nov-2016/MetaData_AllGreek_40Tokens.csv", stringsAsFactors = FALSE, header = TRUE)
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
for (i in 1:100) {
  
  
  
  #create vector of random integers = 10% of obs in smaller.df
  testing.index.v <- sample (seq (1, nrow(smaller.df)), 1435, prob = chunk.ratios.m[, 2])
  
  
  #create training and testing data matrices using testing.index.v and its inverse
  testing.data <- smaller.df[testing.index.v, ]
  training.data <- smaller.df[-testing.index.v, ]
  
  #create vectors of factors giving classes (here = authors) of each row in testing.data and training.data
  training.classes <- as.factor(author.factor[-testing.index.v])
  testing.classes <- as.factor(author.factor[testing.index.v])
  
  
  model.svm <- svm(training.data, training.classes, kernel = "linear", scale = FALSE)
  
  svm.results.l[[i]] <- predict(model.svm, testing.data)
  svm.error.matrix.l[[i]] <- errormatrix(testing.classes, svm.results.l[[i]])
  
  
  
}

timestamp()

#combine all matrices contained in err.matr.l into one matrix for export to .csv file
a <- do.call(rbind, svm.error.matrix.l)

View(a)

sum(a[,13])


sum(a[,13])/2

250*100


(143500-(sum(a[,13])/2))/143500

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



