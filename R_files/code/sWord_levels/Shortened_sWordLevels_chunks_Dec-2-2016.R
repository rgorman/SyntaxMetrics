load()

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


timestamp()
# set up loop to process each file in source directory
for (i in 1:length(files.v)) {
  
  
  # read xml structure from file to .R object
  doc.object <- xmlTreeParse(file.path(input.dir, files.v[i]), useInternalNodes=TRUE)
  # extract all <word> elements and children into XmlNodeList object
  word.nodes <- getNodeSet(doc.object, "//word")
  
  # here we must split files into chunks
  
  divisor <- length(word.nodes)/500
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

timestamp()

# !! stop here for evaluation



length(sWord.freq.table.list)

sum(lengths(sWord.freq.table.list))


summary(lengths(sWord.freq.table.list))



# convert to list of matrices


i <- 1

freqs.l <- list()

for (i in 1:length(sWord.freq.table.list)) {
  
  freqs.l[[i]] <-data.frame(sWord.freq.table.list[[i]], ID=i, 
                            stringsAsFactors=FALSE )
}

  
timestamp()
freqs.df <- do.call(rbind, freqs.l)
timestamp()

sum(lengths(sWord.freq.table.list)) == nrow(freqs.df)
object.size(freqs.df)


# if sums are correct, clean memory
rm(chunks.l, doc.object, freqs.l, sWord.freq.table.list, sWord.nodes.l)


########################################




# set variables for loop

i <- 1 # index variable for loop
rows.v <- 50000 # number of rows to be used in xtab
total.rows.v <- nrow(freqs.df)
y <-     floor(nrow((freqs.df))/rows.v)
seg.v <- seq_along(1:y)
row.counter.v <- NULL
border.row.v <- NULL


timestamp()
for (i in 1:y) {
  
  if (i == 1) {
    
    indexA <- which(freqs.df[,3] == freqs.df[(seg.v[i] * rows.v),3])
    input.df <- freqs.df[1:indexA[length(indexA)],]
    border.row.v <- append(border.row.v, indexA[length(indexA)])
    row.counter.v <- append(row.counter.v, nrow(input.df))
    
    nam <- paste("result", i, ".R", sep = "")
    nam2 <- paste("final.df", i, ".R", sep = "")
    
    
    output.df <-  xtabs(Freq ~ ID+combined.content, data=input.df)
    
    final.df <- as.data.frame.matrix(output.df)
    
    meany <- matrix(colMeans(final.df), nrow = 1)
    
    rm(input.df)
    
    
    # save(output.df, file = nam) # apparently unneccessary
    save(final.df, file = nam2)
    print("fuck")
    
    
    rm(nam, nam2, output.df, final.df)
    
    
  }
  
  else {
    
    if (i != length(seg.v)) {
      
      indexA <- which(freqs.df[,3] == freqs.df[border.row.v[length(border.row.v)] + 1,3])
      indexB <- which(freqs.df[,3] == freqs.df[((seg.v[i]) * rows.v) ,3])
      input.df <- freqs.df[indexA[1]:indexB[length(indexB)],]
      border.row.v <- append(border.row.v, indexA[1])
      border.row.v <- append(border.row.v, indexB[length(indexB)])
      row.counter.v <- append(row.counter.v, nrow(input.df))
      
      
      
      nam <- paste("result", i, ".R", sep = "")
      nam2 <- paste("final.df", i, ".R", sep = "")
      
      
      output.df <-  xtabs(Freq ~ ID+combined.content, data=input.df)
      rm(input.df)
      
      final.df <- as.data.frame.matrix(output.df)
      
      beany <- matrix(colMeans(final.df), nrow = 1)
      meany <- rbind(meany, beany)
      
      # save(output.df, file = nam)
      save(final.df, file = nam2)
      print("piss")
      
      
      rm(nam, nam2, output.df, final.df)
      
      
    }
    
    else {
      
      indexA <- which(freqs.df[,3] == freqs.df[border.row.v[length(border.row.v)] + 1,3])
      input.df <- freqs.df[indexA[1]: total.rows.v, ]
      border.row.v <- append(border.row.v, indexA[1])
      
      
      row.counter.v <- append(row.counter.v, nrow(input.df))
      
      
      
      nam <- paste("result", i, ".R", sep = "")
      nam2 <- paste("final.df", i, ".R", sep = "")
      
      
      output.df <-  xtabs(Freq ~ ID+combined.content, data=input.df)
      rm(input.df)
      
      final.df <- as.data.frame.matrix(output.df)
      
      beany <- matrix(colMeans(final.df), nrow = 1)
      meany <- rbind(meany, beany)
      
      # save(output.df, file = nam)
      save(final.df, file = nam2)
      
      print("poop")
      
      
      rm(nam, nam2, output.df, final.df)
      
      
    }
    
  }
  
  
}  

timestamp()

# check to see if we have correct number of rows
sum(row.counter.v) == nrow(freqs.df)


# extract vector of column means from our matrix of column means
freq.mean.v <- colMeans(meany)

#collect column means of a given magnitude
keepers.v <- which(freq.mean.v >=.005)

dim(meany)

i <- 1
timestamp()
for (i in 1:y) {
  if (i == 1) {
    
    nam2 <- paste("final.df", i, ".R", sep = "")
    load(nam2)
    selected.df <- final.df[, keepers.v]
    
    rm(final.df)
    
  }
  else {
    
    nam2 <- paste("final.df", i, ".R", sep = "")
    load(nam2)
    selected.df2 <- final.df[, keepers.v]
    selected.df <- rbind(selected.df, selected.df2)
    
    rm(final.df, selected.df2)
    
  }
  
  
}
timestamp()






# now move on to naming rows

#####################################
#################################



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
  
  divisor <- length(word.nodes)/750
  max.length <- length(word.nodes)/divisor
  x <- seq_along(word.nodes)
  chunks.l <- split(word.nodes, ceiling(x/max.length))
  
  chunk.total <- append(chunk.total, length(chunks.l))
  
  
  
}

# check to make sure final.df has correct number of rows
sum(chunk.total) == nrow(selected.df)

sum(chunk.total)

sum(row.counter.v)
border.row.v


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
    ID.holder <- append(ID.holder, single.name)
    n <-n+1
    
  }
  
  j <- 1
  
}

# replace row names in final.df with names of chunks from ID.holder
ID.matrix <- matrix(ID.holder, ncol = 1)
write.csv(ID.matrix, file = "Polybius_metadata_750-token-chunks.csv")


row.names(selected.df) <- ID.holder

# take a look
View(selected.df[, 1:5])
View(ordered.df[, 1:25])


object.size(selected.df)











# order columns by column mean, largest to smallest and create object with results
ordered.df <- selected.df[, order(colMeans(selected.df), decreasing=TRUE)]
ordered.df2 <- selected.df[, order(colMeans(selected.df), decreasing=TRUE)]

write.csv(ordered.df2, file = "Results_Nov-2016/NGrams_included.csv")


# create smaller.df to correspond to variable names in classificaiton script
smaller.df <- ordered.df
smaller.df1 <- ordered.df
smaller.df2 <- ordered.df
smaller.df3 <- ordered.df


#save data frame object to .csv file
write.csv(ordered.df, file = "Results_Nov-2016/AllGreekFiles_250tokens_Dec-31.csv")
save(smaller.df3, file = "Results_Nov-2016/AllGreekFiles_Smaller_30tokens_Dec-26.R")
save(final.df, file = "Results_Nov-2016/AllGreekFiles_100tokens_Nov-24.R")

rm(smaller.df1)
load(file = "Results_Nov-2016/AllGreekFiles_Smaller_30tokens_Dec-23.R")
