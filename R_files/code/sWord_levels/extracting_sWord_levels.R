library(XML)

source("code/corpusFunctions.R")


# location of files: C:\Users\rgorm\Documents\syntacto_stylistics\R_files\working_input


input.dir <- "./working_input"
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
  
  # normalize sWord.table by dividing by total sWords. Multiply by 100 to produce rate of sWord occurence per 100 sWords.
  sWord.freq.table <- 100*(sWord.table/sum(sWord.table))
  
  # insert sWord.freq.table into list
  sWord.freq.table.list[[i]] <- sWord.freq.table
  
}



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




# reduce data matrix to features with largest means (most common features)
smaller.m <- final.m[, apply(final.m,2,mean)>=.0025]

# check size of reduced feature set
dim(smaller.m)


# From here smaller.m can be used as basis for clustering and classification algorithms.


