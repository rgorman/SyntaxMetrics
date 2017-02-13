

# clean workspace
rm(list = ls())

# !! begin here for test of script for chunks of sWord levels

library(XML)

source("code/corpusFunctions.R")
input.dir <- "./working_input5"
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
  
  divisor <- length(word.nodes)/250
  max.length <- length(word.nodes)/divisor
  x <- seq_along(word.nodes)
  chunks.l <- split(word.nodes, ceiling(x/max.length))
  
  
  # set up a loop to process each chunk produced by preceding code in matrix 
  
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


str(sWord.freq.table.list)
length(sWord.freq.table.list)
lengths(sWord.freq.table.list)
sum(lengths(sWord.freq.table.list))

mean(lengths(sWord.freq.table.list))
summary(lengths(sWord.freq.table.list))
sWord.freq.table.list[[10]][1]


# convert to list of matrices


i <- 1

freqs.l <- list()

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
# note that chunk length must be same as in the above extraction loop
chunk.total <- NULL

i <- 1

for (i in 1:length(files.v))  {
  
  # read xml structure from file to .R object
  doc.object <- xmlTreeParse(file.path(input.dir, files.v[i]), useInternalNodes=TRUE)
  # extract all <word> elements and children into XmlNodeList object
  word.nodes <- getNodeSet(doc.object, "//word")
  
  # here we must split files into chunks
  
  divisor <- length(word.nodes)/250
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


ID.holder[100000]



# add newly created labels to new data frame object. 
freqs.df$ID <- ID.holder


#cross tabulate data; check to be sure names are correct
result.t <- xtabs(Freq ~ ID+combined.content, data=freqs.df)
dim(result.t)



#convert to a data frame
final.df <- as.data.frame.matrix(result.t)
final.df <- final.df[, order(colMeans(final.df), decreasing=TRUE)]
View(final.df)

final.df2 <- as.data.frame.matrix(result.t)
final.df2 <- final.df2[, order(colMeans(final.df2), decreasing=TRUE)]
View(final.df2)


short.df1 <- final.df[, 1:100]
short.df2 <- final.df2[, 1:100]

colnames(short.df1)
colnames(short.df2)

merged.t <- merge(short.df1, short.df2, colnames(short.df1), colnames(short.df2))

# remove result.t from memory; this is necessary when dealing with a large number of chunks
rm(result.t)

#reduce the feature set

# extract the mean of each column
freq.means.v <- colMeans(final.df[, ])

#collect column means of a given magnitude
keepers.v <- which(freq.means.v >=.005)



#use keepers.v to make a smaller data frame object for analysis
smaller.df <- final.df[, keepers.v]


dim(smaller.df)

rm(freqs.df)


# order columns by column mean, largest to smallest and create object with results
ordered.df <- smaller.df[, order(colMeans(smaller.df), decreasing=TRUE)]
View(ordered.df)

# free memory by removing data frame objects no longer necessary

rm(final.df)

# house cleaning
rm(chunks.l, freq.means.v, freqs.l, ID.holder, sWord.freq.table.list, sWord.nodes.l, word.nodes)

#save data frame object to .csv file
write.csv(ordered.df, file = "Results_Sept-2016/AllGreekFiles_250tokens_Oct-1.csv")


smaller.df <- ordered.df
View(smaller.df)
scaled.df <- scale(ordered.df)
View(scaled.df)


