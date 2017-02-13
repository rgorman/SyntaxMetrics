rm(list = ls())
rm(sent.xml, word.xml, subtree.xml)

library(XML)

i <- 1
j <- 1
k <- 1


# make vector of tree file names. This vector will allow us to iterate through files.
files.v <- dir( pattern=".*xml")
files.v

# create object with full xml of tree file. 
doc <- xmlParse(files.v[4])




# extract setences from full tree xml
sentence.nodes <- getNodeSet(doc, "//sentence")

# convert nodes to list object

sentence.list <- xmlApply(sentence.nodes, xmlToList)


subtree.xml <- xmlNode("subTree_document")

for (j in 1:length(sentence.list)) {
  
  
  # for each sentence in sentence.list, create a node including all attributes
  a <- unlist(sentence.list[[j]][length(sentence.list[[j]])]) # make vector of sentence attributes.
                                                              # sentence attributes appear in last sublist of each list
                                                              # in sentence.list. This list is accessed using 
                                                              # length(sentence.list[[j]]).
  
  sent.xml <- xmlNode("sentence") # create sentence node
  
  sent.xml  <-  addAttributes(sent.xml, id = a[".attrs.id"], 
                  document_id = a[".attrs.document_id"], 
                  subdoc = a[".attrs.subdoc"], span = a[".attrs.span"]) # populate node with attributes ffrom vector a.

  # The following loop extracts @id and @head attributes from each word in a gaiven setence (= sentence.list[[j]]) 
  heads.v <- NULL # vector to store @head attributes
  ids.v <- NULL # vector to store @id attributes
  raw.subtree.l <- list() # list to store subtree generated from edge matrix made from heads.v and ids.v.
  
  for (k in 1:(length(sentence.list[[j]])-1)) {
    b <- unlist(sentence.list[[j]][[k]]) # vector of attributes for each word element. 
    
    heads.v <- append(heads.v, b["head"]) # Populate heads.v with attributes from each word.
    
    ids.v <- append(ids.v, b["id"]) # Populate ids.v with appropriate attributes from each word.
    heads.v <- as.numeric(heads.v) # Convert from character to numeric.
    ids.v <- as.numeric(ids.v) # Convert from character to numeric.
    
  }
  
  #########################
  
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
  
  short.edge.matrix <- edge.matrix[index, ] # Use index to make new matrix without any cases of head = 0.
  graph.object <- graph_from_edgelist(short.edge.matrix) # create graph using igraph function.
  
  raw.subtree.l[[j]] <- ego(graph.object, 50, mode = "out") # populate raw.subtree[[j]] (j = sentence number)
                                           # with subtrees for each vertex in input vector.
                                           # first parameter = input graph, second parameter = number of "steps"
                                           # to take to find elements of subtree (50 is chosen as greater than any in corpus)
                                           # mode parameter = "out" finds descendents, mode = "in" finds ancestors.
  
  
 #############################################
  # The following code block identifies the projectivity of each vertex in a given sentence
  # (puncuation vertices --AuxK, AuxX, and AuxG-- are ignored).
  
  projectivity.l <- list()
  
  for (k in 1:(length(sentence.list[[j]])-1)) {
    
    
    
  }
  
  
  
  
  
  
  ####################################
   
  # The following code block creates for each sentence the proper number of word nodes and populates
  # each node with the attributes drawn from the input xml, It also adds a new attribute called Subtree.
  # The value of @Subtree is taken from raw.subtree.l[[j]], where j is the number of a given setence in
  # sentence.lsit.
  
  k <- 1
  
  for (k in 1:(length(sentence.list[[j]])-1)) {
    
    raw.subtree.v <- raw.subtree.l[[j]][k] # extract subtree for given word node
    raw.subtree.v <- unlist(raw.subtree.v) # change to vector from list
    
    raw.subtree.v <- paste(raw.subtree.v, sep="", collapse=" ") # change to character vector with one element.
                                          # Sequence of values for subtree is made into single character vector
                                          # with each element. This step is necessary to produce a correctly formatted
                                          # #Subtree attribute.
    
    ##################
    
    
    
    
    
    ###################
    
    b <- unlist(sentence.list[[j]][[k]]) # vector of attributes for given word element.
    word.xml <- xmlNode("word") # create word xml node
    word.xml <-  addAttributes(word.xml, id=b["id"], form = b["form"],
                  lemma = b["lemma"], postag = b["postag"],
                  relation = b["relation"], head = b["head"],
                  cite = b["cite"], Subtree = raw.subtree.v) # populate node from input xml. Add new @Subtree attribute.
    
    sent.xml <- append.xmlNode(sent.xml, word.xml) # insert word.xml as child of given sentence node.
    
  }
  k <- 1

 
  subtree.xml <- append.xmlNode(subtree.xml, sent.xml) # Insert sentence into document xml.
 
}

# end of loop

saveXML(subtree.xml, file = "./test_output/test1_Feb-10.xml")

#################################
subtree.xml
word.xml
plot.igraph(graph.object)
raw.v <- as_ids(raw.subtree.l[[k]])
y <- paste(1, 3, sep = " ", collapse = NULL)

paste(raw.subtree.v[1], raw.subtree.v[2], sep = " ", collapse = NULL)



paste(raw.subtree.v, sep="", collapse=" ")

z <- c(1,2,3)
z
z <- strsplit(y, " ")
as_ids(raw.subtree.l[[k]])
zz <- unlist(z)
zzz <- as.numeric(zz)
zzz

# extract all @id attrubutes from <word> elements in indexed sentence of "top"
a <- xmlSApply(top[[s]], function(x) xmlGetAttr(x, "head"))
unlist(sentence.list[[j]][k])
b["head"]
c <- append(b["head"], b["head"])

# extract all @head attributes from <word> elementes in indexed sentence of "top"
b <- xmlSApply(top[[s]], function(x) xmlGetAttr(x, "id"))

c <- xmlSApply(top[[s]], function(x) xmlGetAttr(x, "form"))

# convert vectors from character to numeric
a <- as.numeric(a)
b <- as.numeric(b)

# create and edge matrix from the @id ("a") and @head vectors ("b")
# first create matrix with one column (ncol = 1) and a row for each element in "a"
edge.matrix <- matrix(a, ncol=1)
# add elements of "b" as second column
edge.matrix <- cbind(edge.matrix, b)


# delete all rows of "edge.maatrix" where @head = 0. This step eliminates all punctuation from consideration.
# Likewise, the root element of the sentence is linked only with these tokens dependent on in, not with a theoretical "root".

# First, create "index" containing row numbers of all rows with @head greater than 0.
index <- which(edge.matrix[, 2] > 0)
# Use "index" to create new matrix.
short.edge.matrix <- edge.matrix[index, ]






###############################

length(sentence.list[[1]])
unlist(sentence.list[[1]][16])
saveXML(subtree.xml, file = "test2_Feb-6.xml")

length(sentence.list[[j]])
subtree.xml
sent.xml
b
names(b)
sentence.list[[1]][16]
unlist(sentence.list[[1]][16])

1:(length(sentence.list[[j]])-1)

# this sequence of commands should allow us to isolate sentence nodes and use
# only the sent.list object for attributes

e <- getNodeSet(doc, "//sentence")


d <- xmlApply(e, xmlToList)

f <- unlist(d[[1]][3])
names(f)

# with a loop we can create a vector with the head attribute of each word.
# perhaps write a function which will return the head attribute.

f["word.head"]

# for establishing projectivity, it will be useful to find difference between SETs:
# In particulary, the difference between the set of id's of the yeild of a node and the sequence from 
# min to max of that yeild. Use the setdiff() for this calculation. 
# if the setdiff() between the yeild of a node and the min-to-max sequence from a yeild is the empty set,
# the the node is PROJETIVE.

# Otherwise: check to see if the nodes in the vector produced by setdiff() have relation attributes
# of AuxX, AuxK, or AuxG. If all do, the node is PROJECTIVE. If any do not, the node is NONPROJECTIVE.



vec1 <- 1:5
vec2 <- c(2,4,5,7)
setdiff(vec1, vec2)d
d[[1]]["relation"]
f["word.relation"]
names(f)
names(d[[1]])

i <- 1

for (i in i:9) {
 vec1 <- unlist(d[[1]][i])
 print(vec1["word.relation"])
  
}
f       

unlist(d[[1]][i])


