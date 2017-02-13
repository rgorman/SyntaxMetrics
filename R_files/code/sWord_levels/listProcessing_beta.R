
# clean workspace
rm(list = ls())

# !! begin here for test of script for chunks of sWord levels

library(XML)


input.dir <- "./working_input4"
files.v <- dir(path=input.dir, pattern=".*xml")
sWord.freq.table.list <- list()

i <- 1
content.vector <- NULL

for (i in 1:length(files.v)) {
  
  doc.object <- xmlParse(file.path(input.dir, files.v[i]))
  
  node.list <- xmlToList(doc.object, addAttributes = FALSE, simplify = TRUE)
  
  for (j in 3:length(node.list)) {
    
    for (k in 1:length(node.list[[j]]))  {
      
      for (m in 1:length(node.list[[j]][[k]])) {
        
     content.vector <- append(content.vector, node.list[[j]][[k]][[m]])
        
        
      }
      
      m <- 1
      
    }
    
    k <- 1
    
  }
  
  
  # change sWord.contents vector to lower case
  combined.content <- tolower(content.vector)
  
  # create a contingency table of sWord.contents. The table lists nuber of occurences for all sWords.
  sWord.table <- table(combined.content)
  
  # normalize sWord.table by dividing by total sWords. Multiply by 100 to produce rate of sWord occurence per 1000 sWords.
  sWord.freq.table <- 1000*(sWord.table/sum(sWord.table))
  
  # insert sWord.freq.table into list
  sWord.freq.table.list[[i]] <- sWord.freq.table
  
  
  
  content.vector <- NULL
  
  j <- 3
 
   
}



