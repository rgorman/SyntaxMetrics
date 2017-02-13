# This version of the script includes creation of a list of raw sWord counts.

# clean workspace
rm(list = ls())


library(XML)

source("code/corpusFunctions.R")


# location of files: C:\Users\rgorm\Documents\syntacto_stylistics\R_files\working_input


input.dir <- "./working_input5"
files.v <- dir(path=input.dir, pattern=".*xml")



# The following loop extracts the sWords from each file in the given directory and inserts them as character vectors
# into the appropriate element in a list object.

# set incremental varaible to 1
i <- 1

# create list objects with no content. Vectors extracted from XML files will be stored here.
sWord.rawCount.list <- list()
sWord.freq.table.list <- list()
tokenTotal.list <- list()
sWordTotal.list <- list()

for (i in 1:length(files.v))  {
  
  # read xml structure from file to .R object
  doc.object <- xmlTreeParse(file.path(input.dir, files.v[i]), useInternalNodes=TRUE)
  # extract all <word> elements and children into XmlNodeList object
  word.nodes <- getNodeSet(doc.object, "//word")
  # extract all <sWord> elements from word,nodes. The result is an XMLNodeList object.
  sWord.nodes <- sapply(word.nodes, xmlChildren)
  
  
  # The following loop extracts contents of all <sWord> elements, i.e., extracts the sWords themselve srom the XML.
  
  # set incremetal variable for loop
  j <- 1
  
  # create vector object sWord,contents with no content.
  sWord.contents <- NULL
  
  for (j in 1:length(sWord.nodes)) {
    
    # if test to avoid nodes with two few sWord children. !!Be sure to change integer in if test and in 
    # the sWord.nodes[[j]][] reference or the code will not run properly
    if ((xmlSize(sWord.nodes[[j]]) >= 1)) {
      
      # extract contents of all <sWord> elements. Result is a charcter vector object.
      sWord.contents <- append(sWord.contents, paste(xmlValue(sWord.nodes[[j]][[1]]), collapse = NULL))
      
    } else {
      
  
      
    }
  
    
  }
  
  
  # change sWord.contents vector to lower case
  sWord.contents <- tolower(sWord.contents)
  
  # create a contingency table of sWord.contents. The table lists nuber of occurences for all sWords.
  sWord.table <- table(sWord.contents)
  
  # normalize sWord.table by number of tokens (not number of sWords).
  sWord.freq.table <- sWord.table/length(sWord.nodes)
  
  # insert sWord.freq.table into list
  sWord.freq.table.list[[i]] <- sWord.freq.table
  # insert raw frequencies into list
  sWord.rawCount.list[[i]] <- sWord.table
  #insert token totals for each file in list
  tokenTotal.list[[i]] <- length(sWord.nodes)
  # insert total number of sWords of a given level into a list object
  sWordTotal.list[[i]] <- length(sWord.contents)
  
}

# End of Loop!!!


# save sWord.freq.table.list to disk
# save(sWord.freq.table.list, file = "freq_table_lists/list_10-24-16_0930PM.R")

# Convert sWord.freq.table.list into a data matrix. This allows for further analysis and manipulation.


# First, create list object (freqs.l) containing data.frame object with columns containing ID number for source file
# variable name (i.e., the sWord), and relative frequency of sWord

freqs.l <- mapply(data.frame, ID=seq_along(sWord.freq.table.list),
                  sWord.freq.table.list, SIMPLIFY=FALSE, MoreArgs=list(stringsAsFactors=FALSE))


rawFreqs.l <- mapply(data.frame, ID=seq_along(sWord.freq.table.list),
                     sWord.rawCount.list, SIMPLIFY=FALSE, MoreArgs=list(stringsAsFactors=FALSE))

# Next, combine this list of data.frame objects into a single large data.frame object.

freqs.df <- do.call(rbind, freqs.l)

rawFreqs.df <- do.call(rbind, rawFreqs.l)

# check names of data frame to provide parameters for conversion to wide format table
names(freqs.df)
names(rawFreqs.df)

#convert from long form table to wide format (i.e., the files will be represented by rows, the sWords by columns)
result <- xtabs(Freq ~ ID+sWord.contents, data=freqs.df)
countResult <- xtabs(Freq ~ ID+sWord.contents, data=rawFreqs.df)


dim(result)

#convert wide format table to matrix object
final.m <- apply(result, 2, as.numeric)

rawFinal.m <- apply(countResult, 2, as.numeric)

# make names for rows
names_for_files.v <- gsub (".xml", "", files.v)


# substitute files names for row numbers
rownames(final.m) <-names_for_files.v
rownames(rawFinal.m) <-names_for_files.v

dim(final.m)

order(colMeans(final.m), decreasing=TRUE)

# order columns by column mean, largest to smallest and create object with results
ordered.df <- final.m[, order(colMeans(final.m), decreasing=TRUE)]

ordered.Raw.df <- rawFinal.m[, order(colMeans(final.m), decreasing=TRUE)]

# reduce data matrix to features with largest means (most common features) if ordered.df in unweildy
smaller.m <- ordered.df[,1:3000]



# multiply ratios in ordered.df for ease of reading
ordered.df <- 100 * ordered.df

# reduce number of decimals
ordered.df <- round(ordered.df, 4)

#save matrix to disk
# write.csv(smaller.m, file = "working_output1/rel_pos_Levels_Oct-23-2016_1251PM.csv")

# Make empty vector to contain the number of total tokens in each file.
tokenTotal.v <- NULL

# Fill that vectort object with contents of tokenTotal.list
tokenTotal.v <- append(tokenTotal.v, sapply(tokenTotal.list, paste, collapse = NULL))

# add two NA elements at beginning of vector to correspond to rows added to matrix
tokenTotal.v <- c(NA, NA, tokenTotal.v)

# Change tokenTotal to integer vector.
tokenTotal.v  <-  as.integer(tokenTotal.v)

# Change tokenTotal.v to matrix so it can be combined with the other matrices.
tokenTotal.m <- matrix(tokenTotal.v, ncol = 1)



# Make empty vector to contain the number of total sWords in each level
sWordTotal.v <- NULL

# Fill that vectort object with contents of tokenTotal.list
sWordTotal.v <- append(sWordTotal.v, sapply(sWordTotal.list, paste, collapse = NULL))

# add two NA elements at beginning of vector to correspond to rows added to matrix
sWordTotal.v <- c(NA, NA, sWordTotal.v)

# Change tokenTotal to integer vector.
sWordTotal.v  <-  as.integer(sWordTotal.v)



# Change tokenTotal.v to matrix so it can be combined with the other matrices.
sWordTotal.m <- matrix(sWordTotal.v, ncol = 1)


DoubleTotal.m <- cbind(tokenTotal.m, sWordTotal.v)


# Make matrix of z-scores from ordered.df
zscores.m <- round(scale(ordered.df), 4)

# combine matrices of frequencies
m <- cbind(ordered.Raw.df, ordered.df, zscores.m)


# Reorder the columns to interleave them
# the concatinate function -- c() -- appatently conjoins rows 1, 2, and 3 of each column
 

m <- m[, c(matrix(1:ncol(m), nrow = 3, byrow = T))] 
View(m)



# make matrix of labels for columns
label.b <- matrix(rep("Rel. Freq. per 100 tokens", ncol(ordered.df)), ncol = ncol(ordered.df))
label.c <- matrix(rep("Z-Score", ncol(ordered.df)), ncol = ncol(ordered.df))
label.a <- matrix(rep("Raw Count", ncol(ordered.df)), ncol = ncol(ordered.df))

# Combinne labels
labels.abc <- cbind(label.a, label.b, label.c)


# reorder columns to interleave. First make index of integers separated by number of columns in labels.abc divided
# by 3 (i.e, 1, 1501, 3001, 2, 1502, 3002 ...)
index.abc <- c(matrix(1:ncol(labels.abc), nrow = 3, byrow = TRUE))

# use index to reorder labels victor
labels.abc <- labels.abc[index.abc]

# change labels vector to matrix object
labels.m <- matrix(labels.abc, ncol = ncol(m))


# loop to make rank labels
i <- 1
rank <- NULL
for (i in 1:231)  {
  rank <- append(rank, rep(i, 3))
  
  
}

# convert "rank" to matrix
rank.m <- matrix(rank, ncol = length(rank))



#combine the label matrices by row
combined.m <- rbind(rank.m, labels.abc, m)

# add total token amounts as first column in matrix
combined.m <- cbind(DoubleTotal.m, combined.m)


# save as csv file
write.csv(combined.m, file = "Polybius/level-0-sWords_6-files.csv")

# save as csv file the number of sWords associated with each level
write.csv(sWordTotal.m, file = "working_output1/rel-pos_sWordTotal.csv")





