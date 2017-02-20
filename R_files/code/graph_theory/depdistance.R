# some functions for xml processing


# The following loop extracts @id and @head attributes from each word in a gaiven setence (= sentence.list[[j]]) 
heads.v <- NULL # vector to store @head attributes
ids.v <- NULL # vector to store @id attributes
raw.subtree.l <- list() # list to store subtree generated from edge matrix made from heads.v and ids.v.
relations.v <- NULL

for (k in 1:(length(sentence.list[[j]])-1)) {
  b <- unlist(sentence.list[[j]][[k]]) # vector of attributes for each word element. 
  
  heads.v <- append(heads.v, b["head"]) # Populate heads.v with attributes from each word.
  
  ids.v <- append(ids.v, b["id"]) # Populate ids.v with appropriate attributes from each word.
  heads.v <- as.numeric(heads.v) # Convert from character to numeric.
  ids.v <- as.numeric(ids.v) # Convert from character to numeric. 
  
  relations.v <- append(relations.v, b["relation"])

punct.index.v <-  c(which(relations.v == "AuxX"), which(relations.v == "AuxK"), which(relations.v == "AuxG"))
}


###############################  # identifies ellipsis nodes. Provides input for next block.
                                 # head.ellipsis.v gives a vector of logical values (true or false) 
                                 # for every node;  TRUE if node is ellipsis, FALSE if not.
head.ellipsis.v <- NULL

for (k in 1:(length(sentence.list[[j]])-1)) {
  b <- unlist(sentence.list[[j]][[k]]) # vector of attributes for each word element.
  if ("insertion_id" %in% names(b)) {
    
    head.ellipsis.v <- append(head.ellipsis.v, TRUE)
    
  } else {
    
    head.ellipsis.v <- append(head.ellipsis.v, FALSE)
    
  }
  
  
}



######################################## a test block to identify nodes dependent on ellipses.
                                    # Checks to see if the head of a given node (heads.v[k]) matches a TRUE value in 
                                    # head.ellipis.v 

depend.on.ellip.v <- NULL # Vector to hold results. Value is TRUE if head of given node [k] is an ellipsis.

for (k in 1:(length(sentence.list[[j]])-1))  {
  
  if (heads.v[k] > 0)  {
    
    if (head.ellipsis.v[heads.v[k]] == FALSE) {
      
      depend.on.ellip.v <- append(depend.on.ellip.v, FALSE)
      
    } else {
      
      depend.on.ellip.v <- append(depend.on.ellip.v, TRUE)
      
    } 
    
    
    
  } else {
    
   depend.on.ellip.v <- append(depend.on.ellip.v, FALSE) 
    
  }
  
  
  
}



k <- 1




##################################### This code block calculates Dependency distance for each relevant node
                                    # and stores them in a vector. The vector node.DeoDist.v is used to add
                                    # @DepDist attribute to each word node.

node.DepDist.v <- NULL  # vector for all Dependency Distances for a given sentence [j].
p.holder.v <- NULL # vector whose value is the cardinality of the set of punctuation marks occuring 
                  # between a given vertex [k] and its head.


for (k in 1:(length(sentence.list[[j]])-1))  {
  
  b <- unlist(sentence.list[[j]][[k]]) # vector of attributes for each word element.
  
                                     # The following ifelse() function tests for the following conditions:
                                     # if the value of the @head of a given node (k) is 0; no DepDist can be calculated for these.
                                                # Such include puntuation and the sentence root.
  
                                     # if the value of the @id attribute of a  given node [k] is in the punc.index.v vector, 
                                     # the node [k] is a punctuation mark and no DepDist can be calculated. This test is perhaps reduntant
                                     # with the preceding.
  
                                     # if a given node [k] has an @insertion_id attribute, it is an ellipsis node and no
                                     # DepDist should be calculated.
  
                                     # if a given node [k] has a @head attribute which is the @id value of an ellipsis node,
                                     # then no DepDist should be calculated.
  
  if ((heads.v[k] == 0) | (as.numeric(b["id"]) %in% punct.index.v) | ("insertion_id" %in% names(b)) | (depend.on.ellip.v[k] == TRUE))  {
    
    node.DepDist.v <- append(node.DepDist.v, NA) # Value added to vector for nodes exempt from DepDist calculation.
    
  } else {
    
   
    p.holder.v <- length(seq(heads.v[k], ids.v[k])) - length(setdiff(seq(heads.v[k], ids.v[k]), punct.index.v))
                                    # A vector whose value is number of punctuation marks in interval between child and head.
                                    # seq(heads.v[k], ids.v[k]) generates linear node positions for this interval.
                                    # setdiff(seq(heads.v[k], ids.v[k]), punct.index.v) identifies punctuation nodes 
                                                           # within the interval.
                                    # The difference between the lengths of the two vectors is the number of relevant 
                                                           # punctuation marks in the interval.
                   
                                    # The results are stored in p.holder.v to be used to adjust differnces calculated below.
    
    
    if (heads.v[k] > ids.v[k])  { # Tests whether head node follows child node.
      p.holder.v <- heads.v[k] - (ids.v[k] + p.holder.v) # Effectively moves child node (the subtrahend) closer in value to the head.
      node.DepDist.v <- append(node.DepDist.v, p.holder.v) # Adds value to vector.
      
    } else { # Test is true when child node follows head.
      
      p.holder.v <- (heads.v[k] + p.holder.v) - ids.v[k] # Effectively moves head node (the minuend) closer in value to the child.
      node.DepDist.v <- append(node.DepDist.v, p.holder.v) # Adds value to the vector.
    }
    
    
  }
  
}


heads.v[k]: ids.v[k]
seq(heads.v[k], ids.v[k])
setdiff(seq(heads.v[k], ids.v[k]), punct.index.v)

j <- 351
k <- 1
node.DepDist.v



#########################################
node.DepDist.v[12]

archive
 


na.holder <-   !is.na(node.DepDist.v)


mean(abs(node.DepDist.v), na.rm = TRUE)


abs(node.DepDist.v)



  