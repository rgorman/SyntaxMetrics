# This script compares sWord levels and sWord geodesics to see how effective they are in supervised classification.

# clean workspace to ensure maximum working memory
rm(list = ls())


# load XML package
library(XML)

# load pre-written functions
source("code/corpusFunctions.R")

# input to object the path of the directory with the relevant xml files.  These files should contain all sWord Levels as separate children
# of <word> elements.
input.dir <- "../sWord_levels/files_with_sWords/VG_files"
# make vector of file names from input.dir
files.v <- dir(path=input.dir, pattern=".*xml")

# set increment to 1 for loop that will process each file
i <- 1

# create list object with no content. Vectors extracted from XML files will be stored here.
sWord.freq.table.list <- list()
geodesic.freq.table.list <- list()

[for (i in 1:length(files.v)) {
  
  # read xml structure from file to .R object
  doc.object <- xmlTreeParse(file.path(input.dir, files.v[i]), useInternalNodes=TRUE)
  
  # input all <word> elements into object "words"
  words <- getNodeSet(doc.object, "//word")
    
  # input all geodesics (i.e., full sWords from leaf to root) into object "geodesics".
  geodesics <- getNodeSet(doc.object, "//word/*[last()]")
  
  # extract content of geodesic  elements and put it into a character vector object
  geodesic.content <- paste(sapply(geodesics, xmlValue), collapse=NULL)
  # convert geodesic.content to lower case
  geodesic.content <- tolower(geodesic.content)
  
  
  # here we  split object "words" into chunks; 
  
  divisor <- length(words)/1000 # this divisor indicates size of word chunks; the result it the real number representing
  # the number of x-length chunks in "words"
  
  # a wrapper for use in ceiling(); it is the same as the integer supplied above.
  max.length <- length(words)/divisor
  
  # create a vector of integers corresponding to each <word> element in "words"
  x <- seq_along(words)
  
  # create a list object of elements each with no more than selected chunk size of elements (the last set in list will be smaller
  # unless the number of words in file is evenly divisible). The function ceililng() is used to ensure an integer for the argument of
  # the function split().
  chunks.l <- split(words, ceiling(x/max.length))
  
  
  # create a list object of for chunks of geodesics; the same arguments may be used for function split() as were used for
  # <word> elements because there is one geodesic per <word> and the arguments should thus be the same.
  geodesic.chunks.l <- split(geodesic.content, ceiling(x/max.length))
  
  
  # the following loop extracts content of the children of the <word> elements
  
  # set up list to store results of processsing 
  sWord.nodes.l <- list()
  
  
  for (j in 1:length(chunks.l)) {
    
    sWord.nodes.l[[j]] <- sapply(chunks.l[[j]], xmlChildren)
    
    
    
    
    # create vector object to hold results
    combined.content <- NULL
    
    # set increment counter to 1
    m <- 1
    
    
    for (m in 1:length(sWord.nodes.l[[j]])) {
      
      
      # extract sWord nodes for 1 token at a tiime; result is an XML list object with content which
      # includes sWord xml tags.
      
      single.token <- sWord.nodes.l[[j]][m]
      
      # strip sWord level xml tags from data; result is a xml list object
      content.nodes <- sapply(single.token[[1]], xmlChildren)
      
      
      
      # create vector for output
      extracted.content.v <- NULL
      
      # set increment counter to 1
      n <- 1
      
      # iterate loop through each successive content.nodes object produced by matrix loop
      for (n in 1:length(content.nodes)) {
        
        # add successively extracted content to vector
        extracted.content.v <- append(extracted.content.v, xmlValue(content.nodes[[n]]))
        
        
        
      } # end of loop n
      
      # collect output of nested loop in vector of all sWords for each token in chunk
      combined.content <- append(combined.content, extracted.content.v)
      
      
    } # end of loop m
    
    
    
    
    
    
    
    # change sWord.contents vector to lower case
    combined.content <- tolower(combined.content)
    
    # create a contingency table of sWord.contents. The table lists nuber of occurences for all sWords.
    sWord.table <- table(combined.content)
    
    # normalize sWord.table by dividing by total sWords. Multiply by 100 to produce rate of sWord occurence per 100 sWords.
    sWord.freq.table <- 100*(sWord.table/sum(sWord.table))
    
   
    
    # insert sWord.freq.table into list
    sWord.freq.table.list[[length(sWord.freq.table.list)+1]] <- sWord.freq.table
    
    
    
   
    
  } # end of loop j
  
  
  # reset increment for loop
  j <- 1
  
  
  # begin loop "k" to hadle geodesic chunks.
  for (k in 1:length(geodesic.chunks.l)) {
    
    #convert the list object geodesic.chunks.l into contigency table objects
    geodesic.table <- table(geodesic.chunks.l[[k]])
    
    #convert the result from raw frequencies to relative fequencies
    geodesic.rel.freq.table <- prop.table(geodesic.table)
    
    # store output in list
    geodesic.freq.table.list[[length(geodesic.freq.table.list)+1]] <- geodesic.rel.freq.table
    
  } # end of loop k
  
  # reset increment for loop k
  k <- 1
  
} # end of loop i



# convert to list of matrices

# reset increment to 1
i <- 1

# create list objects to hold content
sWord.freqs.l <- list()
geodesic.freqs.l <- list()

for (i in 1:length(sWord.freq.table.list)) {
  
  sWord.freqs.l[[i]] <-data.frame(sWord.freq.table.list[[i]], ID=seq_along(sWord.freq.table.list[[i]]), 
                            stringsAsFactors=FALSE )
  
  geodesic.freqs.l[[i]] <-data.frame(geodesic.freq.table.list[[i]], ID=seq_along(geodesic.freq.table.list[[i]]), 
                                  stringsAsFactors=FALSE )
  
}


# convert to single matrix

sWord.freqs.df <- do.call(rbind, sWord.freqs.l)
geodesics.freqs.df <- do.call(rbind, geodesic.freqs.l)

#the result is a long form data frame

dim(sWord.freqs.df)
dim(geodesics.freqs.df)




# we must make ID labels so that sWords are identified by file and chunk of origin. This is necessary before we
# can make a combined frequency table based on individual chunks


# remove .xml suffix  from file names and store result in vector for generation of row labels
bookids.v <- gsub(".xml", "", files.v)


# these loops  will create a vector of the proper id tags

# this loop gives us the number of chunks from each file and stores the results in chunk.total
# note that chunk length must be same as in the above extraction loop


chunk.total <- NULL

i <- 1

for (i in 1:length(files.v))  {
  
  # read xml structure from file to .R object
  doc.object <- xmlTreeParse(file.path(input.dir, files.v[i]), useInternalNodes=TRUE)
  # extract all <word> elements and children into XmlNodeList object
  word.nodes <- getNodeSet(doc.object, "//word")
  
  # here we must split files into chunks
  
  divisor <- length(word.nodes)/1000
  max.length <- length(word.nodes)/divisor
  x <- seq_along(word.nodes)
  chunks.l <- split(word.nodes, ceiling(x/max.length))
  
  chunk.total <- append(chunk.total, length(chunks.l))
  
  
  
}


# this series of nested loops uses chunk.total to produce a vector (ID.holder) containing the correct set of chunk
#identifier tags

# first identifiers are created from sWord.freqs.l
i <- 1
chunk.number <- NULL
ID.holder <- NULL
n <- 1

for (i in 1:length(chunk.total)) {
  
  chunk.number <- seq_along(1:chunk.total[i])
  # chunk.number corresponds to the different file names to used in row IDs
  
  for (j in 1:length(chunk.number)) {
    
    single.name <- paste(bookids.v[i], chunk.number[j], sep = "-", collapse = NULL)
    ID.holder <- append(ID.holder, rep(single.name, nrow(sWord.freqs.l[[n]])))
    n <-n+1
    
  }
  
  j <- 1
  
}


# add newly created labels to $ID column of  sWord.freqs.df data frame object. 
sWord.freqs.df$ID <- ID.holder


#cross tabulate data; check to be sure names are correct
result.t <- xtabs(Freq ~ ID+combined.content, data=sWord.freqs.df)
dim(result.t)



#convert to a data frame
sWord.result.df <- as.data.frame.matrix(result.t)

# remove result.t from memory; this is necessary when dealing with a large number of chunks
rm(result.t)




# repeat last series of steps for geodesics

# this series of nested loops uses chunk.total to produce a vector (ID.holder) containing the correct set of chunk
#identifier tags

# first identifiers are created from sWord.freqs.l
i <- 1
chunk.number <- NULL
ID.holder <- NULL
single.name <- NULL
n <- 1

for (i in 1:length(chunk.total)) {
  
  chunk.number <- seq_along(1:chunk.total[i])
  # chunk.number corresponds to the different file names to used in row IDs
  
  for (j in 1:length(chunk.number)) {
    
    single.name <- paste(bookids.v[i], chunk.number[j], sep = "-", collapse = NULL)
    ID.holder <- append(ID.holder, rep(single.name, nrow(geodesic.freqs.l[[n]])))
    n <-n+1
    
  }
  
  j <- 1
  
}

# add newly created labels to $ID column of  sWord.freqs.df data frame object. 
geodesics.freqs.df$ID <- ID.holder


#cross tabulate data; check to be sure names are correct
result.t <- xtabs(Freq ~ ID+Var1, data=geodesics.freqs.df)
dim(result.t)



#convert to a data frame
geodesic.result.df <- as.data.frame.matrix(result.t)

# remove result.t from memory; this is necessary when dealing with a large number of chunks
rm(result.t)


#reduce the feature set

# extract the mean of each column
sWord.freq.means.v <- colMeans(sWord.result.df[, ])
geodesic.freq.means.v <- colMeans(geodesic.result.df[, ])

#collect indices of column means of a given magnitude
sWord.keepers.v <- which(sWord.freq.means.v >=.008)
# note that sWord level frequencies have been multiplied by 100
geodesic.keepers.v <- which(geodesic.freq.means.v >=.00008)
geodesic.keepers.v

#use keepers.v to make a smaller data frame object for analysis
sWord.smaller.df <- sWord.result.df[, sWord.keepers.v]
geodesic.smaller.df <- geodesic.result.df[, geodesic.keepers.v]

# check size of data frame
dim(sWord.smaller.df)




# order columns by column mean, largest to smallest and create object with results
sWord.ordered.df <- sWord.smaller.df[, order(colMeans(sWord.smaller.df), decreasing=TRUE)]
geodesic.ordered.df <- geodesic.smaller.df[, order(colMeans(geodesic.smaller.df), decreasing=TRUE)]

View(sWord.ordered.df)
View(geodesic.ordered.df)


#save data frame objects to .csv file
write.csv(sWord.ordered.df, file = "Rresults/matrices/sWordLevels_1000tokenChunks_June-13-2016.csv")
write.csv(geodesic.ordered.df, file = "Rresults/matrices/Geodesics_100t0okenChunks_June-13-7-2016.csv")

# clean workspace to ensure maximum working memory
rm(list = ls())



# !!! The following code implements the svm supervised classification on the data extracted above


# load the required packages
require(e1071)
require(gmodels)
require(klaR)


# read in data files from disk
# sWordLevels.m <- read.csv(file="Rresults/matrices/sWordLevels_1000tokenChunks_June-13-2016.csv", stringsAsFactors = FALSE)
# Geodesics.m <- read.csv(file="Rresults/matrices/Geodesics_1000tokenChunks_June-13-2016.csv", stringsAsFactors = FALSE)

sWordLevels.m <- sWord.ordered.df
Geodesics.m <- geodesic.ordered.df


#change to data frame objects
sWordLevels.df <- data.frame(sWordLevels.m)


# read in the list of ratios which we provide an even selection of random chunks from the various authors
chunk.ratios.m <- read.csv(file="Rresults/matrices/chunk_ratios_1000.csv", stringsAsFactors = FALSE)

# we must have a vector naming the author for each chunk; this should be automated
author.factor <- NULL
author.factor <- append(author.factor, rep("Thucydides", 24))

# save author.factor to disk
write.csv(author.factor, file = "Rresults/matrices/AuthorFactor_1000tokenChunks_June-13-2016.csv")

# create list objects to store results
sWordLevels.svm.results.l <- list()
sWordLevels.svm.error.matrix.l <- list()
sWordLevels.testing.classes.l <- list()
Geodesics.svm.results.l <- list()
Geodesics.svm.error.matrix.l <- list()
Geodesics.testing.classes.l <- list()

i <- 1


for (i in 1:100) {
  
  
  
  #create vector of random integers = 10% of obs in smaller.df
  sWordLevels.testing.index.v <- sample (seq (1, nrow(sWordLevels.m)), 17, prob = chunk.ratios.m[, 2])
  Geodesics.testing.index.v <- sample (seq (1, nrow(Geodesics.m)), 17, prob = chunk.ratios.m[, 2])
  
  #create training and testing data matrices using testing.index.v and its inverse
  sWordLevels.testing.data <- sWordLevels.m[sWordLevels.testing.index.v, ]
  sWordLevels.training.data <- sWordLevels.m[-sWordLevels.testing.index.v, ]
  Geodesics.testing.data <- Geodesics.m[Geodesics.testing.index.v, ]
  Geodesics.training.data <- Geodesics.m[-Geodesics.testing.index.v, ]
  
  #create vectors of factors giving classes (here = authors) of each row in testing.data and training.data
  
  sWordLevels.training.classes <- as.factor(author.factor[-sWordLevels.testing.index.v])
  sWordLevels.testing.classes <- as.factor(author.factor[sWordLevels.testing.index.v])
  Geodesics.training.classes <- as.factor(author.factor[-Geodesics.testing.index.v])
  Geodesics.testing.classes <- as.factor(author.factor[Geodesics.testing.index.v])
  
  
  # use training data to develop svm model
  sWordLevels.model.svm <- svm(sWordLevels.training.data, sWordLevels.training.classes, kernel = "linear", scale = FALSE)
  Geodesics.model.svm <- svm(Geodesics.training.data, Geodesics.training.classes, kernel = "linear", scale = FALSE)
  
  
  
  sWordLevels.svm.results.l[[i]] <- predict(sWordLevels.model.svm, sWordLevels.testing.data)
  sWordLevels.svm.error.matrix.l[[i]] <- errormatrix(sWordLevels.testing.classes, sWordLevels.svm.results.l[[i]])
  Geodesics.svm.results.l[[i]] <- predict(Geodesics.model.svm, Geodesics.testing.data)
  Geodesics.svm.error.matrix.l[[i]] <- errormatrix(Geodesics.testing.classes, Geodesics.svm.results.l[[i]])
  
  
}

View(sWordLevels.svm.error.matrix.l[[1]])
Geodesics.svm.results.l[[2]]

#combine all matrices contained in err.matr.l into one matrix for export to .csv file
a <- do.call(rbind, sWordLevels.svm.error.matrix.l)
b <- do.call(rbind, Geodesics.svm.error.matrix.l)

sum(a[, 6])
(1700-51)/1700

sum(b[, 6])
(1700-51)/1700
