# script to extract part of speech metrics from treebank xml files.


require(XML)

# this line reads an XML file into an R object
doc.object <- xmlTreeParse(file = "../Projectivity/working/Result_DD_Combined.xml")



# this line reads doc.object into an XML Node object which can be accessed through subsetting
top <- xmlRoot(doc.object)
top[[7]]




# A loop to extract @head and @id attributes from word elements and use them to compute Dependency Distance.
# The loop should start with the subset of "top" which represents the first sentence element.

# wrapper varaibles for processing
a <- NULL
b <- NULL
c <- NULL
d <- NULL
e <- NULL
# Sets increment variable to first <sentence> element in file.
i <- 7

for (i in i:length(top)) {
  a <- xmlSApply(top[[i]], function(x) xmlGetAttr(x, "postag"))
  a <- as.vector(a)
  # record number of verbs in vector "a"
  b <- length(grep("v", a))
  # record number of tokens in sentence less punctuation
  c <- length(a) - length(grep("u---", a))
  # ratio of number of verbs to total tokens (less punctuation)
  d <-append(d, b/c)
  # number of verbs in sentence
  e <- append (e, b)
  
}

# read spread sheet with time information
time_dataframe <- read.csv(file = "../Projectivity/working/working_Combined.csv")



View(time_dataframe)


# add verb number column to data frame
time_dataframe$Verbs <- e

# add verb number column to data frame
time_dataframe$VerbPerToken <- d



#save data frame to spread sheet
write.csv(time_dataframe, file = "../Projectivity/working/working_Combined.csv")




#############################################
#remove objects from memory
rm(list = ls())
