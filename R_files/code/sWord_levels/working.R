# clean workspace to ensure maximum working memory
rm(list = ls())


# load XML package
library(XML)



# input to object the path of the directory with the relevant xml files.  These files should contain all sWord Levels as separate children
# of <word> elements.
source("code/corpusFunctions.R")
input.dir <- "../sWord_levels/files_with_sWords/VG_files"
# make vector of file names from input.dir
files.v <- dir(path=input.dir, pattern=".*xml")

freq.ratios.l <- list()
i <- 1
for (i in 1:length(files.v)) {
  
  # read xml structure from file to .R object
  doc.object <- xmlTreeParse(file.path(input.dir, files.v[i]), useInternalNodes=TRUE)
  # extract all <word> elements and children into XmlNodeList object
  sWord.nodes <- getNodeSet(doc.object, "//word/*[last()]")
  
  
  content.v <- paste(sapply(sWord.nodes, xmlValue), collapse=NULL)
  content.v <- tolower(content.v)
  
  divisor <- length(content.v)/1000
  max.length <- length(content.v)/divisor
  x <- seq_along(content.v)
  chunks.l <- split(content.v, ceiling(x/max.length))
  
  #convert the list object chunks.l into table objects
  freq.chunks.l <- lapply(chunks.l, table)
  
  #convert the result from raw frequencies to relative fequencies
  rel.freq.chunk.l <- lapply(freq.chunks.l, prop.table)
  
  freq.ratios.l[[i]] <- rel.freq.chunk.l 
  
  
} #end of loop "i"



#convert list into matrix object
#this code requires the user defined function "my.apply"
freqs.l <- lapply(freq.ratios.l, my.apply)

summary(freqs.l)

freqs.df <- do.call(rbind, freqs.l)
#the result is a long form data frame

bookids.v <- gsub(".xml", "", files.v)


chunk.total <- NULL
i <- 1

for (i in 1:length(files.v))  {
  
  # read xml structure from file to .R object
  doc.object <- xmlTreeParse(file.path(input.dir, files.v[i]), useInternalNodes=TRUE)
  # extract all <word> elements and children into XmlNodeList object
  sWord.nodes <- getNodeSet(doc.object, "//word/*[last()]")
  
  
  content.v <- paste(sapply(sWord.nodes, xmlValue), collapse=NULL)
  content.v <- tolower(content.v)
  
  
  
  divisor <- length(content.v)/1000
  max.length <- length(content.v)/divisor
  x <- seq_along(content.v)
  chunks.l <- split(content.v, ceiling(x/max.length))
  
  
  chunk.total <- append(chunk.total, length(chunks.l))
  
  
  
} # end of loop "i"



# this series of nested loops uses chunk.total to produce a vector (ID.holder) containing the correct set of chunk
#identifier tags


i <- 1
chunk.number <- NULL
ID.holder <- NULL
n <- 1



ID.holder <- NULL
i <- 1
single.name <- NULL



for (i in 1:length(bookids.v)) {
  
  for (j in 1:length(freqs.l[[i]]$ID)) {
    
    single.name <- paste(bookids.v[i], freqs.l[[i]]$ID[j], sep = "-", collapse = NULL)
    ID.holder <- append(ID.holder, single.name)
    
  }
  
  z <-  2*i
  
  j <- 1
  
}




freqs.l[[1]]$ID

backup.df <- freqs.df
View(freqs.df)
freqs.df$ID <- ID.holder



#cross tabulate data
result.t <- xtabs(Freq ~ ID+Var1, data=freqs.df)
dim(result.t)

#convert to a data frame
final.df <- as.data.frame.matrix(result.t)

# extract the mean of each column
freq.means.v <- colMeans(final.df[, ])

#collect column means of a given magnitude
keepers.v <- which(freq.means.v >=.0008)



#use keepers.v to make a smaller data frame object for analysis
smaller.df <- final.df[, keepers.v]


dim(smaller.df)




# order columns by column mean, largest to smallest and create object with results
ordered.df <- smaller.df[, order(colMeans(smaller.df), decreasing=TRUE)]
View(ordered.df)

authors.m <- read.csv(file="Rresults/matrices/AuthorFactor_1000tokenChunks_June-13-2016.csv", stringsAsFactors = FALSE)
View(authors.m)
authors.v <- authors.m[, 2]

probability.m <- read.csv("Rresults/matrices/chunk_ratios_1000.csv", stringsAsFactors = FALSE)



test.index <- sample(1:175, 18, prob = probability.m[, 2])

testing.data <- smaller.df[test.index, ]
training.data <- smaller.df[-test.index, ]

testing.classes <- as.factor(authors.v[test.index])
training.classes <- as.factor(authors.v[-test.index])

svm.model <- svm(training.data, training.classes, kernel = "linear", scale = TRUE)
svm.results <- predict(svm.model, testing.data)
svm.results


bayes.model <- naiveBayes(training.data, training.classes)
bayes.results <- predict(bayes.model, testing.data, type = "class")

bayes.results
errormatrix(testing.classes, bayes.results)
errormatrix(testing.classes, svm.results)
require(gmodels)

nrow(smaller.df)

testing.classes
svm.results







