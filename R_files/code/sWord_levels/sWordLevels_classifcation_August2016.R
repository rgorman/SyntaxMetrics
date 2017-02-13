

# removes large files created by extraction process
rm(chunks.l, combined.content, content.nodes, freq.means.v, freqs.l, ID.holder, sWord.freq.table, sWord.freq.table.list, sWord.nodes.l,
   sWord.table, word.nodes)

smaller.df <- smaller.df[1:1328, ]
# script to test svm classification

require(e1071)
require(gmodels)
require(klaR)

# rename ordered.df as smaller.df to fit in following script
smaller.df <- ordered.df
smaller.df <- smaller.df[1:1328, ]
smaller.df <- scaled.df
# remove ordered.df from memory
rm(ordered.df)

# to test tha value of scaling, use the  following:
smaller.df <- scale(smaller.df)

chunk.ratios.m <- read.csv(file="Results_Sept-2016./MetaData_AllGreek_250-tokens.csv", stringsAsFactors = FALSE, header = TRUE)
dim(chunk.ratios.m)
chunk.ratios.m[,2]
View(chunk.ratios.m)


# we must have a list naming the author for each chunk; this should be automated
# author.factor <- NULL
# author.factor <- append(author.factor, rep("Thucydides", 24))

# read in author.v for list of levels
author.factor <- chunk.ratios.m[, 1]
unique(author.factor)

svm.results.l <- list()
svm.error.matrix.l <- list()
testing.classes.l <- list()

i <- 1


for (i in 1:100) {
  
  
  
  #create vector of random integers = 10% of obs in smaller.df
  testing.index.v <- sample (seq (1, nrow(smaller.df)), 206, prob = chunk.ratios.m[, 2])
  
  
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


#combine all matrices contained in err.matr.l into one matrix for export to .csv file
a <- do.call(rbind, svm.error.matrix.l)

View(a)

sum(a[,13])


sum(a[,13])/2



(20600-(sum(a[,13])/2))/20600

summary(model.svm)
model.svm$
dim(model.svm$decision.values)

dim(model.svm$SV)
View(model.svm$SV)

length(svm.error.matrix.l)
svm.error.matrix.l[[1]]
svm.results.l[[1]]
recheck <- svm(training.data, training.classes, kernel = "linear", scale = FALSE)




save(svm.error.matrix.l, file="Results_Sept-2016/svmErrorMatrix_250tokens_Oct-1-2016.R")
save(svm.results.l, file="Results_Sept-2016/svmResults_250tokens_Oct-1-2016.R")
write.csv(a, file = "Results_Sept-2016/svmError_Spreadsheet_250tokens_Oct-1-2016.csv")


save(svm.error.matrix.l, file="Results_Sept-2016/scaled-svmErrorMatrix_500tokens_Oct-1-2016.R")
save(svm.results.l, file="Results_Sept-2016/scaled-svmResults_500tokens_Oct-1-2016.R")
write.csv(a, file = "Results_Sept-2016/scaled-svmError_Spreadsheet_500tokens_Oct-1-2016.csv")



