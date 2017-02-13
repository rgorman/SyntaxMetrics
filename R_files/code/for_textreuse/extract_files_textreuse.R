
#this script is for the outer loop of the testreuse testing script


i <- 1
holder.l <- list()
suffix.v <-".txt"
prefix.v <- "../rel_pos_prose/test_reuse/"
full_name <- gsub("\\.xml", "", files.v)
full.file.name <-NULL


i <- 1
for (i in 1:length(sWord.l)) {
  
  # randomly select  integers representing index of chunks to be tested
  sample_index <- sample(1:length(sWord.l[[i]]), 2)
  
  # create list of integers corresponding to total number of chunks is file
  full_index <- seq_along(1:length(sWord.l[[i]]))
  
  # create a list of integers, with numbers corresponding to test chunks removed.
  main_index <- full_index[-sample_index]
  
  
  chunk.name.v <- NULL
  
  j <- 1
  
  for (j in j:length(cite.l[[i]])) {
    holder.l <- cite.l[[i]][j]
    df <- rbind(df, c(holder.l[[1]][1], holder.l[[1]][length(holder.l[[1]])], length(holder.l[[1]])))
    
    chunk.name.v <- append(chunk.name.v, holder.l[[1]][1])
    
    
  }
  
  full.file.v <- NULL
  m <- 1
  for (m in m:length(main_index)) {
    
    full.file.v <- append(full.file.v, sapply(sWord.l[[i]][main_index[m]], paste, sep="", collapse=" "))
    
  }
  
  
  full.file.name <- paste(prefix.v, full_name[i], suffix.v, sep="", collapse="" )
  write(full.file.v, file=full.file.name)
  
  k <- 1
  author.v <- chunk.name.v[sample_index]
  no_punc <- gsub("\\.|:", "", author.v)
  underscore <- as.character(gsub(" ", "_", no_punc))
  
  for (k in k:length(author.v)) {
    
    sample.chunk <- sapply(sWord.l[[i]][sample_index[k]], paste, sep="", collapse=" ")
    chunk_file <- paste(prefix.v, underscore[k], suffix.v, sep="", collapse="")
    write(sample.chunk, file=chunk_file)
    
  }
  
  
}



