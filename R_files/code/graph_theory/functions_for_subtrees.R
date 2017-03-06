string <- strsplit(neighborhood.v, " ")
string2 <- unlist(string)
str(unlist(string))
sort(string2)
substr(string2, 1, 1)
substr("abcdef", 2, 4)

b
names(n.holder.v)
b["postag"]
substring(b["postag"], 1, 1)
length(neighbor.subtree.v)



############################################ Code block to extract neighborhood for each node and to 
                                        # populate them with @relation, part of speech and a combination
                                        # of the two. 


for (k in 1:(length(sentence.list[[j]])-1)) {
 
  if (k <= length(neighborhood.l)) {
    
    neighborhood.v <- neighborhood.l[[k]] # extract neighborhood for given word element.
    neighbor.subtree.v <- neighborhood.l[[k]]
    sorted.neighbor.subtree.v <- sort( neighbor.subtree.v)
    neighborhood.attr.v   <-  paste0(neighborhood.v, sep="", collapse = " ") #convert to a character vector of one element for insertion
    # as attribute into new word element.
    
    
    
    
  } else {
    
    neighborhood.attr.v <- "NA"
    
  }
  
  rel.v <- NULL
  pos.v <- NULL
  rel.pos.v <- NULL
  rel.pos.self.v <- NULL
  
  
  for (t in 1:length(neighbor.subtree.v)) {
    
    n.holder.v <- unlist(sentence.list[[j]][sorted.neighbor.subtree.v[t]])
    
    
    if (length(neighbor.subtree.v) == 1) {
      
      rel.v <-  paste("Leaf", n.holder.v["word.relation"],  sep = ".")
      pos.v <-  pos.self.v <- paste("Leaf", substr(n.holder.v["word.postag"], 1, 1),  sep = ".")
      rel.pos.leaf.v <- c(n.holder.v["word.relation"], substr(n.holder.v["word.postag"], 1, 1))
      rel.pos.leaf.v <- paste(rel.pos.leaf.v, collapse = "-")
      rel.pos.v <- paste("Leaf", rel.pos.leaf.v, sep = ".")
      
    } else {
      
      if (neighbor.subtree.v[1]==sorted.neighbor.subtree.v[t]) {
        rel.self.v <- paste("Self", n.holder.v["word.relation"],  sep = ".")
        rel.v <- append(rel.v, rel.self.v)
        
        pos.self.v <- paste("Self", substr(n.holder.v["word.postag"], 1, 1),  sep = ".")
        pos.v <- append(pos.v, pos.self.v)
        
        rel.pos.self.v <- c(n.holder.v["word.relation"], substr(n.holder.v["word.postag"], 1, 1))
        rel.pos.self.v <- paste(rel.pos.self.v, collapse = "-")
        rel.pos.self.v <- paste("Self", rel.pos.self.v, sep = ".")
        rel.pos.v <- append(rel.pos.v, rel.pos.self.v)
        
      } else {
        
        rel.v <- append(rel.v, n.holder.v["word.relation"])
        pos.v <- append(pos.v, substr(n.holder.v["word.postag"], 1, 1))
        rel.pos.v <- append(rel.pos.v, c(n.holder.v["word.relation"], substr(n.holder.v["word.postag"], 1, 1)))
        
      }
      
      
    }
    
    
  }
  
  t <- 1
  
  rel.attr.v <-  paste(rel.v, collapse = "-")
  pos.attr.v <-  paste(pos.v, collapse = "-")
  rel.pos.attr.v <- paste(rel.pos.v, collapse = "-")
  
  
  
}

k <- 2


###################################################




rel.v <- NULL
pos.v <- NULL
rel.pos.v <- NULL
rel.pos.self.v <- NULL
t <- 1
j <- 159

length(neighbor.subtree.v)

rrr <-   c(n.holder.v["word.relation"], substr(n.holder.v["word.postag"], 1, 1))

n.holder.v <- unlist(sentence.list[[j]][neighbor.subtree.v[t]])
rel.v <- append(rel.v, n.holder.v["word.relation"])
pos.v <- append(pos.v, substr(n.holder.v["word.postag"], 1, 1))
rel.pos.v <- append(rel.pos.v, c(n.holder.v["word.relation"], substr(n.holder.v["word.postag"], 1, 1)))




neighbor.subtree.v[1]==sorted.neighbor.subtree.v[t]

paste(rel.v, collapse = "-")
paste(pos.v, collapse = "-")
paste(rel.pos.v, collapse = "-")

c(n.holder.v["word.relation"], substr(n.holder.v["word.postag"], 1, 1))
rel.pos.v <- c(n.holder.v["word.relation"], substr(n.holder.v["word.postag"], 1, 1))

string1 <- append(1, c(2,3))
paste(string1, collapse = "-")

str(n.holder.v["word.postag"])
string1 <- n.holder.v["word.postag"]
substr(n.holder.v["word.postag"], 1, 1)
