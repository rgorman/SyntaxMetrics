# simplified script to extract geodesic sWords

# clean workspace to ensure maximum working memory
rm(list = ls())


# load XML package
library(XML)


# input to object the path of the directory with the relevant xml files.  These files should contain all sWord Levels as separate children
# of <word> elements.
input.dir <- "../sWord_levels/files_with_sWords/VG_files"
# make vector of file names from input.dir
files.v <- dir(path=input.dir, pattern=".*xml")


freq.table.l <- list()
i <- 1

for (i in 1: length(files.v)) {
  
  # read xml structure from file to .R object
  doc.object <- xmlTreeParse(file.path(input.dir, files.v[i]), useInternalNodes=TRUE)
  
  # input all geodesics (i.e., full sWords from leaf to root) into object "geodesics".
  geodesics <- getNodeSet(doc.object, "//word/*[last()]")
  
  # extract content of geodesic  elements and put it into a character vector object
  geodesic.content <- paste(sapply(geodesics, xmlValue), collapse=NULL)
  # convert geodesic.content to lower case
  geodesic.content <- tolower(geodesic.content)
  
  
  # here we  split object "words" into chunks; 
  
  divisor <- length(geodesics)/1000 # this divisor indicates size of word chunks; the result it the real number representing
  # the number of x-length chunks in "words"
  
  # a wrapper for use in ceiling(); it is the same as the integer supplied above.
  max.length <- length(geodesics)/divisor
  
  # create a vector of integers corresponding to each <word> element in "words"
  x <- seq_along(geodesics)
  
  # create a list object of elements each with no more than selected chunk size of elements (the last set in list will be smaller
  # unless the number of words in file is evenly divisible). The function ceililng() is used to ensure an integer for the argument of
  # the function split().
  chunks.l <- split(geodesic.content, ceiling(x/max.length))
  
  
  # create contingincy table; this device records the number of occurence of each type of sWord in each chunk
  geodesic.table <- lapply(chunks.l, table)
  
  # create relative frequency table
  freq.table <- lapply(geodesic.table, prop.table)
  
  # store output of loop
  freq.table.l[[i]] <- freq.table
  
}



#this function is applied to a list of lists of tables to convert to matrix. function must be run to be accessed later.
my.apply <- function(x){
  my.list <-mapply(data.frame, ID=seq_along(x),
                   x, SIMPLIFY=FALSE,
                   MoreArgs=list(stringsAsFactors=FALSE))
  my.df <- do.call(rbind, my.list)
  return(my.df)
}



# output must be changed into a single data frame object; first each element in the freq.table.l is converted via the my.apply function

# create list objects to hold content
freqs.l <- list()

freqs.l <- lapply(freq.table.l, my.apply)


# convert to single data frame with all separate elements of freqs.l subjoined


freqs.df <- do.call(rbind, freqs.l)



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



# add newly created labels to $ID column of  sWord.freqs.df data frame object. 
freqs.df$ID <- ID.holder


#cross tabulate data; check to be sure names are correct
result.t <- xtabs(Freq ~ ID+Var1, data=freqs.df)
dim(result.t)

#convert once more to a data frame
final.df <- as.data.frame.matrix(result.t)

# remove result.t from memory; this is necessary when dealing with a large number of chunks
rm(result.t)

#reduce the feature set

# extract the mean of each column
freq.means.v <- colMeans(final.df[, ])

#collect column means of a given magnitude
keepers.v <- which(freq.means.v >=.00008)



#use keepers.v to make a smaller data frame object for analysis
smaller.df <- final.df[, keepers.v]


dim(smaller.df)

# these results can be classified using "SimpleClassification.R"


