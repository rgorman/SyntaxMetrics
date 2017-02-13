
# This script creates a list of lists which contains the @lemma information for
# each sWord; 

library(XML)

source("code/corpusFunctions.R")
input.dir <- "../rel_pos_prose"
files.v <- dir(path=input.dir, pattern=".*xml")




lemma.l <- list()
i <- 1

for(i in 1:length(files.v)){
  doc.object <- xmlTreeParse(file.path(input.dir, files.v[i]), useInternalNodes=TRUE)
  sword.lemma <- getNodeSet(doc.object, "//sWord/@lemma")
  lemma.v <- paste(sword.lemma, collapse=NULL)
  lemma.freqs.t <-table(lemma.v)
  
 
  lemma.l[[i]] <- lemma.freqs.t
  
  
}



#converting an R list into a Data Matrix
freqs.l <- mapply(data.frame, ID=seq_along(book.freqs.l),
                  lemma.l, SIMPLIFY=FALSE, MoreArgs=list(stringsAsFactors=FALSE))


freqs.df <- do.call(rbind, freqs.l)
names(freqs.df)

#convert from long form table to wide format
result <- xtabs(Freq ~ ID+lemma.v, data=freqs.df)

dim(result)
