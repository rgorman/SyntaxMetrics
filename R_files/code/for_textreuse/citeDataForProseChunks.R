
# This script creates a list of lists which contains the @cite information for
# each sWord; the information is divided into chunks that should correspond to
# the chunks created for classification prediction PROVIDED THE CHUNK SIZE IS THE SAME.

library(XML)
library(stylo)
source("code/corpusFunctions.R")
input.dir <- "../rel_pos_prose"
files.v <- dir(path=input.dir, pattern=".*xml")




cite.l <- list()

for(i in 1:length(files.v)){
  doc.object <- xmlTreeParse(file.path(input.dir, files.v[i]), useInternalNodes=TRUE)
  chunk.size <-1000
  sword.cite <- getNodeSet(doc.object, "//sWord/@cite")
  cite.v <- paste(sword.cite, collapse=NULL)
  
  
  divisor <- length(cite.v)/chunk.size
  max.length <- length(cite.v)/divisor
  x <- seq_along(cite.v)
 
  
  cite.l[[i]] <- split(cite.v, ceiling(x/max.length))
  
  
}

summary(cite.l)

# The following script creates a matrix containing the citation of the first and last words in a
# given chunk and the size (in words) of the chunk. It depends on the list object "cite.l"
# created by the previous script.

df <- matrix(nrow=1, ncol=3)
colnames(df) <- c("First", "Last", "Size")

i <- 1
holder.l <- list()

for (i in 1:length(files.v)) {
  j <- 1
  for (j in j:length(cite.l[[i]])) {
    holder.l <- cite.l[[i]][j]
    df <- rbind(df, c(holder.l[[1]][1], holder.l[[1]][length(holder.l[[1]])], length(holder.l[[1]])))
    
  }
  
  
}

# Delete the empty first row of df and rename the results

cite.param.m <-df[-1,]
View(cite.param.m)

#save cite.param.m as .csv file

write.csv (cite.param.m, file="Rresults/chunk_parameters5.csv")



cite.param.m[1,1]
author.v <- cite.param.m[1,1]
no_punc <- gsub("\\.|:", "", author.v)
underscore <- as.character(gsub(" ", "_", no_punc))
author.v
as.character(underscore)
underscore
# the next step is to extract sWord content for each chunk created above



sWord.l <- list()
for(i in 1:length(files.v)) {
  doc.object <- xmlTreeParse(file.path(input.dir, files.v[1]), useInternalNodes=TRUE)
  chunk.size <-1000
  sword.content <- getNodeSet(doc.object, "//sWord")
  sWord.v <- paste(sapply(sword.content, xmlValue), sep=" ", collapse=NULL)
  
  
  divisor <- length(sWord.v)/chunk.size
  max.length <- length(sWord.v)/divisor
  x <- seq_along(sWord.v)
  
  
  sWord.l[[1]] <- split(sWord.v, ceiling(x/max.length))
  
  
}

sWord.v[1:10]
sword.content[1]

h <- paste(sapply(sword.content[1:10], xmlValue), sep="", collapse=" " )
h <- sWord.v[1:10]


directory <- "../rel_pos_prose/"
suffix <- ".txt"
underscore
full_file

full_file <-paste(directory, underscore, sep="")
fuller_file <- paste(full_file, suffix, sep="")

write(author.v,  file=fuller_file, append=TRUE)

