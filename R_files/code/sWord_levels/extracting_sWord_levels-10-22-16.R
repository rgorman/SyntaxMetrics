# clean workspace
rm(list = ls())


library(XML)

source("code/corpusFunctions.R")


# location of files: C:\Users\rgorm\Documents\syntacto_stylistics\R_files\working_input


input.dir <- "./xslt_output"
files.v <- dir(path=input.dir, pattern=".*xml")



# The following loop extracts the sWords from each file in the given directory and inserts them as character vectors
# into the appropriate element in a list object.

# set incremental varaible to 1
i <- 1

# create list object with no content. Vectors extracted from XML files will be stored here.
sWord.freq.table.list <- list()
data.points.counter.l <- list()

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
  data.points.counter.l[[i]] <- sWord.contents
  sWord.contents <- tolower(sWord.contents)
  
  # create a contingency table of sWord.contents. The table lists nuber of occurences for all sWords.
  sWord.table <- table(sWord.contents)
  
  # normalize sWord.table by dividing by total sWords.
  sWord.freq.table <- sWord.table/sum(sWord.table)
  
  # insert sWord.freq.table into list
  sWord.freq.table.list[[i]] <- sWord.freq.table
  
}

# create list of actual freqency counts from relative frequencies
raw.table <- sWord.freq.table.list[[1]]*sum(length(data.points.counter.l[[1]]))

raw.table.list <- list()
i <- 1
# End of extraction loop!
 for (i in 1:length(files.v)) {
   raw.table.list[[i]] <- sWord.freq.table.list[[i]]*sum(length(data.points.counter.l[[i]]))
   
   
 }


save(raw.table.list, file = "xml_metadata/raw_table_lisr-3-15-17.R")

save(sWord.freq.table.list, file = "xml_metadata/sWord_frequency_table_list-3-15-17.R")
save(data.points.counter.l, file = "xml_metadata/all_data_points_list-3-15-17.R")


# save sWord.freq.table.list to disk
save(sWord.freq.table.list, file = "freq_table_lists/list_10-23-16_0958AM.R")

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

# extract the mean of each column
freq.means.v <- colMeans(final.m[, ])

# order columns by column mean, largest to smallest and create object with results
ordered.df <- final.m[, order(colMeans(final.m), decreasing=TRUE)]


# reduce data matrix to features with largest means (most common features)
smaller.m <- ordered.df[,1:1000]

View(smaller.m)

write.csv(smaller.m, file = "working_output1/rel_pos_Levels_Oct-23-2016_1001AM.csv")






  