
y[[1]][1]


sWord.nodes <- sapply(y[[1]], xmlChildren)
sWord.nodes
sWord.contents <- append(sWord.contents, paste(sapply(sWord.nodes[[1]][1], xmlValue), collapse = NULL))
xmlValue(sWord.nodes[[1]])

tester <- NULL
tester <- append(tester, xmlValue(sWord.nodes[[1]]))


sWord.nodes.l[[1]][1]
y <- sWord.nodes.l[[1]][1]
length(sWord.nodes.l[[1]][1])

sapply(sWord.nodes.l[[1]][1], xmlValue)
y
sWord.nodes[[1]]
xmlValue(sWord.nodes[[1]])

class(tester)






# the following nested loops extract the content from sWord elements

# create vector object to hold results
combined.content <- NULL

# set increment counter to 1
m <- 1

# loop for number of tokens in chunk (= length of sWord.nodes.l[[1]])
for (m in 1:length(sWord.nodes.l[[1]])) {
  
  # extract sWord nodes for 1 token at a tiime; result is an XML list object with content which
  # includes sWord xml tags.
  
  single.token <- sWord.nodes.l[[1]][m]
  
  # strip sWord level xml tags from data; result is a xml list object
  content.nodes <- sapply(single.token[[1]], xmlChildren)
  
  # create a loop to convert the content of the xml list object to a character vector
  # xmlValue extracts the data and append puts them in a vector
  
  # create vector for output
  extracted.content.v <- NULL
  
  # set increment counter to 1
    n <- 1
  
    # iterate loop through each successive content.nodes object produced by matrix loop
    for (n in 1:length(content.nodes)) {
    
   # add successively extracted content to vector
      extracted.content.v <- append(extracted.content.v, xmlValue(content.nodes[[n]]))
    
  }
  
    # collect output of nested loop in vector of all sWords for each token in chunk
combined.content <- append(combined.content, extracted.content.v)
  
}

y
extracted.content.v
content.nodes
length(content.nodes)
xmlValue(content.nodes[[n]])
combined.content[length(combined.content)]
     


# !! begin here for test of script for chunks of sWord levels

library(XML)

source("code/corpusFunctions.R")
input.dir <- "../sWord_levels/files_with_sWords/VG_files"
files.v <- dir(path=input.dir, pattern=".*xml")


i <- 1

# create list object with no content. Vectors extracted from XML files will be stored here.
sWord.freq.table.list <- list()

# set up loop to process each file in source directory
for (i in 1:length(files.v)) {
  
  
  # read xml structure from file to .R object
  doc.object <- xmlTreeParse(file.path(input.dir, files.v[i]), useInternalNodes=TRUE)
  # extract all <word> elements and children into XmlNodeList object
  word.nodes <- getNodeSet(doc.object, "//word")
  
  # here we must split files into chunks
  
  divisor <- length(word.nodes)/2000
  max.length <- length(word.nodes)/divisor
  x <- seq_along(word.nodes)
  chunks.l <- split(word.nodes, ceiling(x/max.length))
  
  
  # set up a loop to process each chunk produced by preceding code in matrix loop
  
 # set up list to store results of processsing 
   sWord.nodes.l <- list()
  
  
   # extract sWord elements from each chunk
   for (k in 1:length(chunks.l)) {
     
     sWord.nodes.l[[k]] <- sapply(chunks.l[[k]], xmlChildren)
     
    
     
     # create vector object to hold results
     combined.content <- NULL
     
     # set increment counter to 1
     m <- 1
     
     
     for (m in 1:length(sWord.nodes.l[[k]])) {
       
       
       # extract sWord nodes for 1 token at a tiime; result is an XML list object with content which
       # includes sWord xml tags.
       
       single.token <- sWord.nodes.l[[k]][m]
       
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
         
         
       }
       
       # collect output of nested loop in vector of all sWords for each token in chunk
       combined.content <- append(combined.content, extracted.content.v)
       
       
     }
     
     
     
     
     
     
     
     # change sWord.contents vector to lower case
     combined.content <- tolower(combined.content)
     
     # create a contingency table of sWord.contents. The table lists nuber of occurences for all sWords.
     sWord.table <- table(combined.content)
     
     # normalize sWord.table by dividing by total sWords. Multiply by 100 to produce rate of sWord occurence per 100 sWords.
     sWord.freq.table <- 100*(sWord.table/sum(sWord.table))
     
     # insert sWord.freq.table into list
     sWord.freq.table.list[[length(sWord.freq.table.list)+1]] <- sWord.freq.table
     
     
     
   }
   
  k <- 1
  
}    
   


# !! stop here for evaluation



# convert to list of matrices

i <- 1
for (i in 1:length(sWord.freq.table.list)) {
  
  freqs.l[[i]] <-data.frame(sWord.freq.table.list[[i]], ID=seq_along(sWord.freq.table.list[[i]]), 
                       stringsAsFactors=FALSE )
}


# convert to single matrix

freqs.df <- do.call(rbind, freqs.l)
#the result is a long form data frame


View(freqs.df)

dim(freqs.df)


# we must make ID labels so that sWords are identified by file and chunk of origin. This is necessary before we
# can make a combined frequency table based on individual chunks


# remove .xml suffix  from file names and store result in vector for generation of row labels
bookids.v <- gsub(".xml", "", files.v)


# these loops  will create a vector of the proper id tags

# this loop gives us the number of chunks from each file and stores the results in chunk.total
chunk.total <- NULL

for (i in 1:length(files.v))  {
  
  # read xml structure from file to .R object
  doc.object <- xmlTreeParse(file.path(input.dir, files.v[i]), useInternalNodes=TRUE)
  # extract all <word> elements and children into XmlNodeList object
  word.nodes <- getNodeSet(doc.object, "//word")
  
  # here we must split files into chunks
  
  divisor <- length(word.nodes)/2000
  max.length <- length(word.nodes)/divisor
  x <- seq_along(word.nodes)
  chunks.l <- split(word.nodes, ceiling(x/max.length))
  
  chunk.total <- append(chunk.total, length(chunks.l))
  
  
  
}


# this series of nested loops uses chunk.total to produce a vector (ID.holder) containing the correct set of chunk
#identifier tags


i <- 1
chunk.number <- NULL
ID.holder <- NULL
n <- 1

for (i in 1:length(chunk.total)) {
  
  chunk.number <- seq_along(1:chunk.total[i])
  # chunk.number corresponds to the different file names to used in row IDs
  
  for (j in 1:length(chunk.number)) {
    
    single.name <- paste(bookids.v[i], chunk.number[j], sep = "-", collapse = NULL)
    ID.holder <- append(ID.holder, rep(single.name, nrow(freqs.l[[n]])))
    n <-n+1
    
  }
  
  j <- 1
  
}




# back up results by creating new data frame object to work on
freqs.df2 <- freqs.df

# add newly created labels to new data frame object. 
freqs.df2$ID <- ID.holder



#cross tabulate data; check to be sure names are correct
result.t <- xtabs(Freq ~ ID+combined.content, data=freqs.df2)
dim(result.t)



#convert to a data frame
final.df <- as.data.frame.matrix(result.t)



#reduce the feature set

# extract the mean of each column
freq.means.v <- colMeans(final.df[, ])

#collect column means of a given magnitude
keepers.v <- which(freq.means.v >=.003)


#use keepers.v to make a smaller data frame object for analysis
smaller.df <- final.df[, keepers.v]


dim(smaller.df)


## try http:// if https:// URLs are not supported
source("https://bioconductor.org/biocLite.R")
biocLite()


biocLite(c("graph", "RGBL"))

a
?remove.packages

remove.packages(QuACN)

require(igraph)


         