

# set variables for loop

i <- 1 # index variable for loop
rows.v <- 50000 # number of rows to be used in xtab
total.rows.v <- nrow(freqs.df)
y <-     floor(nrow((freqs.df))/rows.v)
seg.v <- seq_along(1:y)
row.counter.v <- NULL
border.row.v <- NULL
  

timestamp()
for (i in 1:y) {
  
  if (i == 1) {
    
    indexA <- which(freqs.df[,3] == freqs.df[(seg.v[i] * rows.v),3])
    input.df <- freqs.df[1:indexA[length(indexA)],]
    border.row.v <- append(border.row.v, indexA[length(indexA)])
    row.counter.v <- append(row.counter.v, nrow(input.df))
    
    nam <- paste("result", i, ".R", sep = "")
    nam2 <- paste("final.df", i, ".R", sep = "")
    
    
    output.df <-  xtabs(Freq ~ ID+combined.content, data=input.df)
    
    final.df <- as.data.frame.matrix(output.df)
  
    meany <- matrix(colMeans(final.df), nrow = 1)
    
    rm(input.df)
    
    
    # save(output.df, file = nam) # apparently unneccessary
    save(final.df, file = nam2)
    print("fuck")
    
    
    rm(nam, nam2, output.df, final.df)
    
    
  }
  
  else {
    
    if (i != length(seg.v)) {
      
      indexA <- which(freqs.df[,3] == freqs.df[border.row.v[length(border.row.v)] + 1,3])
      indexB <- which(freqs.df[,3] == freqs.df[((seg.v[i]) * rows.v) ,3])
      input.df <- freqs.df[indexA[1]:indexB[length(indexB)],]
      border.row.v <- append(border.row.v, indexA[1])
      border.row.v <- append(border.row.v, indexB[length(indexB)])
      row.counter.v <- append(row.counter.v, nrow(input.df))
      
      
      
      nam <- paste("result", i, ".R", sep = "")
      nam2 <- paste("final.df", i, ".R", sep = "")
      
      
      output.df <-  xtabs(Freq ~ ID+combined.content, data=input.df)
      rm(input.df)
      
      final.df <- as.data.frame.matrix(output.df)
    
      beany <- matrix(colMeans(final.df), nrow = 1)
      meany <- rbind(meany, beany)
      
      # save(output.df, file = nam)
      save(final.df, file = nam2)
      print("piss")
      
      
      rm(nam, nam2, output.df, final.df)
      
      
    }
    
   else {
     
     indexA <- which(freqs.df[,3] == freqs.df[border.row.v[length(border.row.v)] + 1,3])
     input.df <- freqs.df[indexA[1]: total.rows.v, ]
     border.row.v <- append(border.row.v, indexA[1])
    
     
     row.counter.v <- append(row.counter.v, nrow(input.df))
     
     
     
     nam <- paste("result", i, ".R", sep = "")
     nam2 <- paste("final.df", i, ".R", sep = "")
     
     
     output.df <-  xtabs(Freq ~ ID+combined.content, data=input.df)
     rm(input.df)
     
     final.df <- as.data.frame.matrix(output.df)
     
     beany <- matrix(colMeans(final.df), nrow = 1)
     meany <- rbind(meany, beany)
     
     # save(output.df, file = nam)
     save(final.df, file = nam2)
     
     print("poop")
     
    
     rm(nam, nam2, output.df, final.df)
     
     
   }
    
  }
  
  
}  
 
timestamp()

# check to see if we have correct number of rows
sum(row.counter.v) == nrow(freqs.df)


# extract vector of column means from our matrix of column means
freq.mean.v <- colMeans(meany)

#collect column means of a given magnitude
keepers.v <- which(freq.mean.v >=.005)


i <- 1
timestamp()
for (i in 1:y) {
  if (i == 1) {
    
    nam2 <- paste("final.df", i, ".R", sep = "")
    load(nam2)
    selected.df <- final.df[, keepers.v]
    
    rm(final.df)
    
  }
  else {
    
    nam2 <- paste("final.df", i, ".R", sep = "")
    load(nam2)
    selected.df2 <- final.df[, keepers.v]
    selected.df <- rbind(selected.df, selected.df2)
    
    rm(final.df, selected.df2)
    
  }
  
  
}
timestamp()

# clean up -- test runs only
rm(beany, meany, selected.df)
