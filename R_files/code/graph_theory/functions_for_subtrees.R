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


#######################################################

# if necessary, empty memory.
rm(list = ls())

require(XML)
require(igraph)


# Identify directory with the input files.
input.dir <- "./xml_input"

# Identify directory for the output files.
output.dir <- "./xml_output"


files.v <- dir(path=input.dir, pattern=".*xml") # A vector with each file name from input directory.
DD.l <- list()
node.DD.l <- list()

rel.list <- list()
pos.list <- list()
rel.pos.list <- list()



for (i in 1: length(files.v))  {
  
  # create object with full xml of tree file. 
  doc <- xmlParse(file.path(input.dir, files.v[i]))
  
  # extract setences from full tree xml
  sentence.nodes <- getNodeSet(doc, "//sentence")
  
  # convert nodes to list object
  
  sentence.list <- xmlApply(sentence.nodes, xmlToList)
  
  
  subtree.xml <- xmlNode("subTree_document")
  
  rel.holder.v <- NULL
  pos.holder.v <- NULL
  rel.pos.holder.v <- NULL
  
  for (j in 1:length(sentence.list)) {
    
    rel.holder.v <- NULL
    pos.holder.v <- NULL
    rel.pos.holder.v <- NULL
    
    
    # The following loop extracts @id and @head attributes from each word in a gaiven setence (= sentence.list[[j]]) 
    heads.v <- NULL # vector to store @head attributes
    
    ids.v <- NULL # vector to store @id attributes
    
    raw.subtree.l <- list() # list to store subtree generated from edge matrix made from heads.v and ids.v.
    
    neighborhood.l <- list() # list to store for each node in a sentence j the closed neighborhood.  This means
    # the @id of the vertex itself and all its immediate dependents.
    
    relations.v <- NULL # Vector to store @relatin attributes
    
    
    for (k in 1:(length(sentence.list[[j]])-1)) { # Creates vectors for later calculations.
      b <- unlist(sentence.list[[j]][[k]]) # vector of attributes for each word element. 
      
      heads.v <- append(heads.v, b["head"]) # Populate heads.v with attributes from each word.
      
      ids.v <- append(ids.v, b["id"]) # Populate ids.v with appropriate attributes from each word.
      heads.v <- as.numeric(heads.v) # Convert from character to numeric.
      ids.v <- as.numeric(ids.v) # Convert from character to numeric.
      relations.v <- append(relations.v, b["relation"]) # Stores all @relation attributes for sentence [j].
      punct.index.v <-  c(which(relations.v == "AuxX"), which(relations.v == "AuxK"), which(relations.v == "AuxG"))
      # Collects the index values for each relevant punctuation mark in [j].
      
    }
    
    
    # The following code block creates a matrix from @head and @id attributes for each word and uses
    # matrix to generate graph object using the igraph package.
    # This graph object becomes input for the ego() function, which returns the ids for the
    # subtree of each vertex in the graph.
    
    edge.matrix <- matrix(heads.v, ncol=1) # create matrix of @head attributes of each word. Row number is equal to
    # number of words in sentence. Column number = 1.
    
    edge.matrix <- cbind(edge.matrix, ids.v) # add second column to matrix, containing @id attributes for each word.
    index <- which(edge.matrix[, 1] > 0) # make vector containing position of each row in matrix
    # whose @head attribute is greater than zero. This step removes punctuation
    # and also removes an edge from the root vertex to a "parent."
    
    short.edge.matrix <- matrix(edge.matrix[index, ], ncol = 2) # Use index to make new matrix without any cases of head = 0.
    graph.object <- graph_from_edgelist(short.edge.matrix) # create graph using igraph function.
    
    raw.subtree.l <- ego(graph.object, 50, mode = "out") # populate raw.subtree.l
    # with subtrees for each vertex in input vector.
    # first parameter = input graph, second parameter = number of "steps"
    # to take to find elements of subtree (50 is chosen as greater than any in corpus)
    # mode parameter = "out" finds descendents, mode = "in" finds ancestors.
    
    neighborhood.l <- ego(graph.object, 1, mode = "out") # populate neighborhood.l with subtrees of distance = 1.
    
    
   k <- 1 
    
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
      t <- 1
      
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
      
      
      
      rel.v <-  paste(rel.v, collapse = "-")
      pos.v <-  paste(pos.v, collapse = "-")
      rel.pos.v <- paste(rel.pos.v, collapse = "-")
      
      rel.holder.v <- append(rel.holder.v, rel.v)
      pos.holder.v <- append(pos.holder.v, pos.v)
      rel.pos.holder.v <- append(rel.pos.holder.v, rel.pos.v)
      
      
      
      
      # append all subtree data into one vector per sentence
      
      
    }
    
  # rel.list[[j]] <- rel.holder.v
  # pos.list[[j]] <- pos.holder.v
  # rel.pos.list[[j]] <- rel.pos.holder.v 
    
    
    
  }
  
  
  
}





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
  t <- 1
  
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
