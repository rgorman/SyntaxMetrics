# clean workspace
rm(list = ls())


library(XML)

source("code/corpusFunctions.R")


# location of files: C:\Users\rgorm\Documents\syntacto_stylistics\R_files\working_input


input.dir <- "./working_input1"
files.v <- dir(path=input.dir, pattern=".*xml")



# The following loop extracts the sWords from each file in the given directory and inserts them as character vectors
# into the appropriate element in a list object.

# set incremental varaible to 1
i <- 1

# create list object with no content. Vectors extracted from XML files will be stored here.
sWord.freq.table.list <- list()

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
    
    
    # extract contents of all <sWord> elements. Result is a charcter vector object.
    sWord.contents <- append(sWord.contents, paste(sapply(sWord.nodes[[j]], xmlValue), collapse = NULL))
    
    
  }
  
  # change sWord.contents vector to lower case
  sWord.contents <- tolower(sWord.contents)
  
  # create a contingency table of sWord.contents. The table lists nuber of occurences for all sWords.
  sWord.table <- table(sWord.contents)
  
  # normalize sWord.table by number of tokens (not number of sWords).
  sWord.freq.table <- sWord.table/length(sWord.nodes)
  
  # insert sWord.freq.table into list
  sWord.freq.table.list[[i]] <- sWord.freq.table
  
}

# End of Loop!!!


# save sWord.freq.table.list to disk
save(sWord.freq.table.list, file = "freq_table_lists/list_10-22-06_0141PM.R")

# Convert sWord.freq.table.list into a data matrix. This allows for further analysis and manipulation.


# First, create list object (freqs.l) containing data.frame object with columns containing ID number for source file
# variable name (i.e., the sWord), and relative frequency of sWord

freqs.l <- mapply(data.frame, ID=seq_along(sWord.freq.table.list),
                  sWord.freq.table.list, SIMPLIFY=FALSE, MoreArgs=list(stringsAsFactors=FALSE))

# Next, combine this list of data.frame objects into a single large data.frame object.

freqs.df <- do.call(rbind, freqs.l)

# check names of data frame to provide parameters for conversion to wide format table
names(freqs.df)

#convert from long form table to wide format (i.e., the files will be represented by rows, the sWords by columns)
result <- xtabs(Freq ~ ID+sWord.contents, data=freqs.df)

#convert wide format table to matrix object
final.m <- apply(result, 2, as.numeric)

# make names for rows
names_for_files.v <- gsub (".xml", "", files.v)


# substitute files names for row numbers
rownames(final.m) <-names_for_files.v

rownames(final.m)

dim(final.m)



# order columns by column mean, largest to smallest and create object with results
ordered.df <- final.m[, order(colMeans(final.m), decreasing=TRUE)]


# reduce data matrix to features with largest means (most common features)
smaller.m <- ordered.df[,1:1000]

# multiply matrix by 100 to get ratio of sWordLevel per 100 tokens (these numbers are easier to read than
# small decimal fractions)
smaller.m <- 100 * smaller.m

View(smaller.m)

#save matrix to disk
write.csv(smaller.m, file = "working_output1/rel_pos_Levels_Oct-22-2016_0145PM.csv")




