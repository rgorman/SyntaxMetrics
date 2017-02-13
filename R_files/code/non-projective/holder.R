
# Script to find non-projective sentences
# The script requires as input an xml file with geodesics stored as values in child elements 
# for each <word> elements. 
require(XML)

# this line reads an XML file into an R object
doc.object <- xmlTreeParse(file = "../Projectivity/projectivity_test1.xml")



# this line reads doc.object into an XML Node object which can be accessed through subsetting
top <- xmlRoot(doc.object)



# Sets increment varaible
z <- 4

for (z in 4:length(top)) {
  
  # This line extracts the contents or the element <geodesic> from "top[[z]]" and puts them in a list.
  # The list has the same number of elements as words in the target sentence [[z]].
  # The items in each list are character vectors and need to be converted to numbers
  geodesics.list <- xmlApply(top[[z]], xmlValue)
  
  # The following loop takes as imput the list of character vectors and outputs a vector of integers.
  
  # Creates wrapper variable for ouput vector
  geodesics.v <- NULL
  # reset increment counter
  i <- 1
  
  for (i in 1:length(geodesics.list)) {
    a <- geodesics.list[[i]]
    b <- unlist(strsplit(a, " "))
    c <- as.numeric(b)
    geodesics.v <- append(geodesics.v, c)
    
    
    
    
  }
  
  
  #The following loop takes as input the list of character vectors and outputs a list object.
  # Each element in the list represents a word and its ancestors (by @id) to the root (the geodesic)
  # Items in each element are output as numeric vectors for further calculation
  
  
  # create wrapper list object
  geodesics.list2 <- list()
  #reset increment
  i <- 1
  
  for (i in 1:length(geodesics.list)) {
    a <- geodesics.list[[i]]
    b <- unlist(strsplit(a, " "))
    c <- as.numeric(b)
    geodesics.list2[[i]] <- c
    
  }
  
  
  
  # The following set of nested loops takes as input a list of numeric vectors representing the geodesics of
  # each word in a sentence (geodesics.list2).
  # The loops return a list object (subtree.list) contining, in linear sequence, the projection (i.e., the word and its descendents)
  # for each word in the sentence.
  
  
  # create wrappers for list and vector objects
  subtree.list <- list()
  a <- NULL
  b <- NULL
  c <- NULL
  # reset increment variables
  i <- 1
  k <- 1
  
  # outer loop 1x for each separate integer in combined geodesics. In other word, it creates a list entry
  # for each token in the target sentence and puts the result of the inner loop in that that entry.
  
  for (i in 1:(length(geodesics.list2))) {
    
    # inner loop 1x for each item in list of of geodesics; it should collect each node and its descendants.
    # For example, on the second pass, it looks for the integer "2" in each vector in geodesics.list2.
    # If a "2" is present, that vector (a geodesic) is copied to variable "a". 
    # Since the geodesic contains ancestors as well as descendants, anscestors are deleted by copying 
    # target and descendants to variable "b".
    # The results are copied via append() to variable "c", which amalgamates the results drawn from each list item.
    # Final results are stored in elements of subtree.list after duplicatees are removed and descendants are reordered
    # according to linear sequence.
    
    for (k in k:length(geodesics.list2)) {
      if (i %in% geodesics.list2[[k]]) {
        a <- geodesics.list2[[k]]
        b <- a[which(a == i):length(a)]
        c <- append(c, b)
        # k <- k+1
      }
      
      
    }
    # store results in corresponding element of subtree.list
    # remove duplicates via unique()
    # put in linear order via sort()
    subtree.list[[i]] <- sort(unique(c))
    # reset wrapper variabales for vectors 
    a <- NULL
    b <- NULL
    c <- NULL
    # reset increment vaaraible
    k <- 1
  }
  
  
  # The following loop takes as input a vector containing the projection of a target word
  # This projection must be ordered in linear sequence.
  # Such input is provided by the several vectors stored in subtree.list, the output of a previous set of loops.
  # The loop input should be copied to variable "d".
  
  d <- NULL
  m <- 1
  difference.list <- list()
  
  for (m in 1:length(subtree.list)) {
    d <- subtree.list[[m]]
    # set increment variable  
    n <- 1
    # create wrapper variable
    f <- NULL
    
    # loops runs for 1 iteration less than the length of the vector of the projectoion for the target word.
    # This subtraction is necessary, since it operates on each pair of adjacent words (= n-1) 
    for (n in 1:length(d)-1) {
      
      # difference between a set pf adjacent numbers is calculated; 
      # a value > 1 allows the possibility of non-projectivity; result is stored in variable "e"
      e <- abs(d[n]-d[n+1])
      # the resultant differences are collected in a single variable "f"
      f <- append (f, e)
      difference.list[[m]] <- f
      
    }
    
    
    g <- NULL
    for (q in 1:length(subtree.list)) {
      d <- subtree.list[[2]]
      
      if (length(subtree.list[[q]])> 1) {
        g <- seq(from = d[which(f>1)]+1, to= d[which(f>1)+1]-1)  
        h <- subtree.list[[q]]
        gap_word <- NULL
        
        for (p in 1:length(g))  {
          if (g[p] %in% h) {
            gap_word <- append(gap_word, g[p])
            
          }
          
          top[[z]] <- addAttributes(top[[z]], gap = gap_word)
          
        }
        
      }
      
      
      # h <- which(sapply(subtree.list, function(x) length(x))>1)
      
      
      
      
      
      
    }
    
    q <- 1
    
    
  }
  
  
  
}


########




seq(from = d[which(f>1)]+1, to= d[which(f>1)+1]-1)

d[which(f>1)]+1
d
f

for (q in 1:length(subtree.list)) {
  if (length(subtree.list[[q]]) > 0) {
    
    
    
  }
  
  
}





g <- NULL
for (q in 1:length(subtree.list)) {
  d <- subtree.list[[2]]
  
  if (length(subtree.list[[q]])> 1) {
    g <- seq(from = d[which(f>1)]+1, to= d[which(f>1)+1]-1)  
    h <- subtree.list[[q]]
    gap_word <- NULL
    
    for (p in 1:length(g))  {
      if (g[p] %in% h) {
        gap_word <- append(gap_word, g[p])
        
      }
      
      top[[z]] <- addAttributes(top[[z]], gap = gap_word)
      
    }
    
  }
  
  
  # h <- which(sapply(subtree.list, function(x) length(x))>1)
  
  
  
  
  
  
}





d
subtree.list[[m]]

# the following line gives a sequence of integers representing the words in a gap for a given subtree
# vector "d" is the word ids in the subtree; vector "f" is the result of calculating the distance 
# between adjacent pairs in vector "d".
# These results can be put in a variable and compared to the master vector of words with projections of more than one word.
g <- seq(from = d[which(f>1)]+1, to= d[which(f>1)+1]-1)

h <- which(sapply(subtree.list, function(x) length(x))>1)
gap_word <- NULL

for (p in 1:length(g))  {
  if (g[p] %in% h) {
    gap_word <- append(gap_word, g[p])
    
  }
 
  top[[z]] <- addAttributes(top[[z]], gap = gap_word)
  
}

rm(list = ls())
