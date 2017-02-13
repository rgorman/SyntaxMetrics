

# clean workspace
rm(list = ls())

# !! begin here for test of script for chunks of sWord levels

library(XML)

source("code/corpusFunctions.R")
input.dir <- "./working_input1"
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
  
  divisor <- length(word.nodes)/40
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
  
  freqs.l[[i]] <-data.frame(sWord.freq.table.list[[i]], ID=i, 
                            stringsAsFactors=FALSE )
}


# convert to single matrix
timestamp()
freqs.df <- do.call(rbind, freqs.l)
timestamp()
#the result is a long form data frame

object.size(freqs.df)

timestamp()
# divide freqs.df into smaller data frames so that we can cross tabulate without running out of memory. Divide
# into at least 5 files
z <- ceiling(nrow(freqs.df)/10)
freqs.df[z,]
indexA <- which(freqs.df[,3] == freqs.df[z,3])
freqs.df1 <- freqs.df[1:indexA[length(indexA)],]

z <- 2 * (ceiling(nrow(freqs.df)/10))
freqs.df[z,]
indexB <- which(freqs.df[,3] == freqs.df[z,3])
freqs.df2 <- freqs.df[(indexA[length(indexA)]+1):indexB[length(indexB)],]

z <- 3 * (ceiling(nrow(freqs.df)/10))
freqs.df[z,]
indexC <- which(freqs.df[,3] == freqs.df[z,3])
freqs.df3 <- freqs.df[(indexB[length(indexB)]+1):indexC[length(indexC)],]

z <- 4 * (ceiling(nrow(freqs.df)/10))
freqs.df[z,]
indexD <- which(freqs.df[,3] == freqs.df[z,3])
freqs.df4 <- freqs.df[(indexC[length(indexC)]+1):indexD[length(indexD)],]

z <- 5 * (ceiling(nrow(freqs.df)/10))
freqs.df[z,]
indexE<- which(freqs.df[,3] == freqs.df[z,3])
freqs.df5 <- freqs.df[(indexD[length(indexD)]+1):indexE[length(indexE)],]

z <- 6 * (ceiling(nrow(freqs.df)/10))
freqs.df[z,]
indexF <- which(freqs.df[,3] == freqs.df[z,3])
freqs.df6 <- freqs.df[(indexE[length(indexE)]+1):indexF[length(indexF)],]

z <- 7 * (ceiling(nrow(freqs.df)/10))
freqs.df[z,]
indexG <- which(freqs.df[,3] == freqs.df[z,3])
freqs.df7 <- freqs.df[(indexF[length(indexF)]+1):indexG[length(indexG)],]

z <- 8 * (ceiling(nrow(freqs.df)/10))
freqs.df[z,]
indexH <- which(freqs.df[,3] == freqs.df[z,3])
freqs.df8 <- freqs.df[(indexG[length(indexG)]+1):indexH[length(indexH)],]

z <- 9 * (ceiling(nrow(freqs.df)/10))
freqs.df[z,]
indexI <- which(freqs.df[,3] == freqs.df[z,3])
freqs.df9 <- freqs.df[(indexH[length(indexH)]+1):indexI[length(indexI)],]

z <- 1 + indexI[length(indexI)]
freqs.df[z,]
freqs.df10 <- freqs.df[z:nrow(freqs.df),]

timestamp()

# check sums for 5 files
sum(nrow(freqs.df1), nrow(freqs.df2), nrow(freqs.df3), nrow(freqs.df4), nrow(freqs.df5)) == nrow(freqs.df)

# check sums for 10 files
sum(nrow(freqs.df1), nrow(freqs.df2), nrow(freqs.df3), nrow(freqs.df4), nrow(freqs.df5), nrow(freqs.df6),
    nrow(freqs.df7), nrow(freqs.df8), nrow(freqs.df9), nrow(freqs.df10)) == nrow(freqs.df)

# if sums are correct, clean memory
rm(freqs.df, chunks.l, doc.object, freqs.l, sWord.freq.table.list, sWord.nodes.l)

# make list of data frames as input for loop
freqs.df.list <- list()
freqs.df.list[[5]] <- freqs.df5



i <- 1
# run a loop to cross tablulate and save results
for (i in 1:5)  {
  
  result <- xtabs(Freq ~ ID+combined.content, data=freqs.df.list[[i]])
  save(result, file = paste("result", i, ".R", sep = ""))
  rm(result)
  
}


# or run xtab by hand
timestamp()

result1 <- xtabs(Freq ~ ID+combined.content, data=freqs.df1)
save(result1, file = "result1.R")
rm(result1)


result2 <- xtabs(Freq ~ ID+combined.content, data=freqs.df2)
save(result2, file = "result2.R")
rm(result2)

result3 <- xtabs(Freq ~ ID+combined.content, data=freqs.df3)
save(result3, file = "result3.R")
rm(result3)

result4 <- xtabs(Freq ~ ID+combined.content, data=freqs.df4)
save(result4, file = "result4.R")
rm(result4)

result5 <- xtabs(Freq ~ ID+combined.content, data=freqs.df5)
save(result5, file = "result5.R")
rm(result5)

result6 <- xtabs(Freq ~ ID+combined.content, data=freqs.df6)
save(result6, file = "result6.R")
rm(result6)

result7 <- xtabs(Freq ~ ID+combined.content, data=freqs.df7)
save(result7, file = "result7.R")
rm(result7)

result8 <- xtabs(Freq ~ ID+combined.content, data=freqs.df8)
save(result8, file = "result8.R")
rm(result8)

result9 <- xtabs(Freq ~ ID+combined.content, data=freqs.df9)
save(result9, file = "result9.R")
rm(result9)

result10 <- xtabs(Freq ~ ID+combined.content, data=freqs.df10)
save(result10, file = "result10.R")
rm(result10)

timestamp()

# remove data frames to free up memory
rm(freqs.df1, freqs.df2, freqs.df3, freqs.df4, freqs.df5)
rm(freqs.df1, freqs.df2, freqs.df3, freqs.df4, freqs.df5, freqs.df6, freqs.df7, freqs.df8, freqs.df9, freqs.df10)

object.size(freqs.df)

# reopen saved files and convert to data frames
# resultant combined data frames are saved to disk and erased from memory (except for last).

timestamp()




##################################
#################################

# Extract column means from each cross-tabulated file and store results in matrix


load(file = "result1.R")
final.df <- as.data.frame.matrix(result1)
rm(result1)
meany <- matrix(colMeans(final.df), nrow = 1)
rm(final.df)


load(file = "result2.R")
final.df2 <- as.data.frame.matrix(result2)
rm(result2)
beany <- matrix(colMeans(final.df2), nrow = 1)
meany <- rbind(meany, beany)
rm(final.df2, beany)

load(file = "result3.R")
final.df3 <- as.data.frame.matrix(result3)
rm(result3)
beany <- matrix(colMeans(final.df3), nrow = 1)
meany <- rbind(meany, beany)
dim(meany)
rm(final.df3, beany)


load(file = "result4.R")
final.df4 <- as.data.frame.matrix(result4)
rm(result4)
beany <- matrix(colMeans(final.df4), nrow = 1)
meany <- rbind(meany, beany)
rm(final.df4, beany)

load(file = "result5.R")
final.df5 <- as.data.frame.matrix(result5)
rm(result5)
beany <- matrix(colMeans(final.df5), nrow = 1)
meany <- rbind(meany, beany)
rm(final.df5, beany)


load(file = "result6.R")
final.df6 <- as.data.frame.matrix(result6)
rm(result6)
beany <- matrix(colMeans(final.df6), nrow = 1)
meany <- rbind(meany, beany)
rm(final.df6, beany)



load(file = "result7.R")
final.df7 <- as.data.frame.matrix(result7)
rm(result7)
beany <- matrix(colMeans(final.df7), nrow = 1)
meany <- rbind(meany, beany)
rm(final.df7, beany)



load(file = "result8.R")
final.df8 <- as.data.frame.matrix(result8)
rm(result8)
beany <- matrix(colMeans(final.df8), nrow = 1)
meany <- rbind(meany, beany)
rm(final.df8, beany)




load(file = "result9.R")
final.df9 <- as.data.frame.matrix(result9)
rm(result9)
beany <- matrix(colMeans(final.df9), nrow = 1)
meany <- rbind(meany, beany)
rm(final.df9, beany)



load(file = "result10.R")
final.df10 <- as.data.frame.matrix(result10)
rm(result10)
beany <- matrix(colMeans(final.df10), nrow = 1)
meany <- rbind(meany, beany)
rm(final.df10, beany)

# extract vector of column means from our matrix of column means
freq.mean.v <- colMeans(meany)

#collect column means of a given magnitude
keepers.v <- which(freq.mean.v >=.005)

# re-open the cross-tabular files and slice the columns based on keepers.v
load(file = "result1.R")
final.df <- as.data.frame.matrix(result1)
rm(result1)
final.df <- final.df[, keepers.v]

load(file = "result2.R")
final.df2 <- as.data.frame.matrix(result2)
rm(result2)
final.df2 <- final.df2[, keepers.v]
final.df <- rbind(final.df, final.df2)
rm(final.df2)

load(file = "result3.R")
final.df3 <- as.data.frame.matrix(result3)
rm(result3)
final.df3 <- final.df3[, keepers.v]
final.df <- rbind(final.df, final.df3)
rm(final.df3)


load(file = "result4.R")
final.df4 <- as.data.frame.matrix(result4)
rm(result4)
final.df4 <- final.df4[, keepers.v]
final.df <- rbind(final.df, final.df4)
rm(final.df4)

load(file = "result5.R")
final.df5 <- as.data.frame.matrix(result5)
rm(result5)
final.df5 <- final.df5[, keepers.v]
final.df <- rbind(final.df, final.df5)
rm(final.df5)

load(file = "result6.R")
final.df6 <- as.data.frame.matrix(result6)
rm(result6)
final.df6 <- final.df6[, keepers.v]
final.df <- rbind(final.df, final.df6)
rm(final.df6)

load(file = "result7.R")
final.df7 <- as.data.frame.matrix(result7)
rm(result7)
final.df7 <- final.df7[, keepers.v]
final.df <- rbind(final.df, final.df7)
rm(final.df7)

load(file = "result8.R")
final.df8 <- as.data.frame.matrix(result8)
rm(result8)
final.df8 <- final.df8[, keepers.v]
final.df <- rbind(final.df, final.df8)
rm(final.df8)

load(file = "result9.R")
final.df9 <- as.data.frame.matrix(result9)
rm(result9)
final.df9 <- final.df9[, keepers.v]
final.df <- rbind(final.df, final.df9)
rm(final.df9)

load(file = "result10.R")
final.df10 <- as.data.frame.matrix(result10)
rm(result10)
final.df10 <- final.df10[, keepers.v]
final.df <- rbind(final.df, final.df10)
rm(final.df10)

# now move on to naming rows

#####################################
#################################








load(file = "result1.R")
final.df <- as.data.frame.matrix(result1)
rm(result1)
meany <- matrix(colMeans(final.df), nrow = 1)


load(file = "result2.R")
final.df2 <- as.data.frame.matrix(result2)
final.df <- rbind(final.df, final.df2)
rm(result2)
rm(final.df2)

load(file = "result3.R")
final.df3 <- as.data.frame.matrix(result3)
final.df <- rbind(final.df, final.df3)
rm(result3)
rm(final.df3)

save(final.df, file = "Data_Frame1.R")
rm(final.df)



load(file = "result4.R")
final.df.part2 <- as.data.frame.matrix(result4)
rm(result4)

load(file = "result5.R")
final.df5 <- as.data.frame.matrix(result5)
final.df.part2 <- rbind(final.df.part2, final.df5)
rm(result5)
rm(final.df5)

load(file = "result6.R")
final.df6 <- as.data.frame.matrix(result6)
final.df.part2 <- rbind(final.df.part2, final.df6)
rm(result6)
rm(final.df6)

save(final.df.part2, file = "Data_Frame2.R")
rm(final.df.part2)



load(file = "result7.R")
final.df.part3 <- as.data.frame.matrix(result7)
rm(result7)

load(file = "result8.R")
final.df8 <- as.data.frame.matrix(result8)
final.df.part3 <- rbind(final.df.part3, final.df8)
rm(result8)
rm(final.df8)

load(file = "result9.R")
final.df9 <- as.data.frame.matrix(result9)
final.df.part3 <- rbind(final.df.part3, final.df9)
rm(result9)
rm(final.df9)

load(file = "result10.R")
final.df10 <- as.data.frame.matrix(result10)
final.df.part3 <- rbind(final.df.part3, final.df10)
rm(result10)
rm(final.df10)





timestamp()

load(file = "Data_Frame1.R")
load(file = "Data_Frame2.R")

final.df <- rbind(final.df, final.df.part2)

object.size(final.df)
rm(final.df.part2, final.df.part3)

# slice data frames keeping only the first 10,000 columns to save memory
final.df <- final.df[, 1:10000]
final.df.part2 <- final.df.part2[, 1:10000]
final.df.part3 <- final.df.part3[, 1:10000]

timestamp()

final.df <- rbind(final.df, final.df.part2)
final.df <- rbind(final.df, final.df.part3)

timestamp()


rm(final.df.part2)


#################################################


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
  
  divisor <- length(word.nodes)/40
  max.length <- length(word.nodes)/divisor
  x <- seq_along(word.nodes)
  chunks.l <- split(word.nodes, ceiling(x/max.length))
  
  chunk.total <- append(chunk.total, length(chunks.l))
  
  
  
}

# check to make sure final.df has correct number of rows
sum(chunk.total) == nrow(final.df)

sum(chunk.total)




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
write.csv(ID.matrix, file = "Results_Nov-2016/Authors_AllGreekFiles_40tokens_Nov-28.csv")


row.names(final.df) <- ID.holder

# take a look
View(final.df[, 1:5])

object.size(final.df)









# order columns by column mean, largest to smallest and create object with results
ordered.df <- final.df[, order(colMeans(final.df), decreasing=TRUE)]

# create smaller.df to correspond to variable names in classificaiton script
smaller.df <- ordered.df

#save data frame object to .csv file
write.csv(ordered.df, file = "Results_Nov-2016/AllGreekFiles_50tokens_Nov-27.csv")
save(final.df, file = "Results_Nov-2016/AllGreekFiles_100tokens_Nov-24.R")


