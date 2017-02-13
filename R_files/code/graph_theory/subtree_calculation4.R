####### This code adds a switch to handle both ellipsis and regular vertices correctly.

# if necessary, empty memory.
rm(list = ls())

require(XML)
require(igraph)


# Identify directory with the input files.
input.dir <- "./xml_input"

# Identify directory for the output files.
output.dir <- "./xml_output"


files.v <- dir(path=input.dir, pattern=".*xml") # A vector with each file name from input directory.

for (i in 1: length(files.v))  {
  
  # create object with full xml of tree file. 
  doc <- xmlParse(file.path(input.dir, files.v[i]))
  
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
    
    short.edge.matrix <- matrix(edge.matrix[index, ], ncol = 2) # Use index to make new matrix without any cases of head = 0.
    graph.object <- graph_from_edgelist(short.edge.matrix) # create graph using igraph function.
    
    raw.subtree.l[[j]] <- ego(graph.object, 50, mode = "out") # populate raw.subtree[[j]] (j = sentence number)
    # with subtrees for each vertex in input vector.
    # first parameter = input graph, second parameter = number of "steps"
    # to take to find elements of subtree (50 is chosen as greater than any in corpus)
    # mode parameter = "out" finds descendents, mode = "in" finds ancestors.
    
    
    #############################################
    # The following code block identifies the projectivity of each vertex in a given sentence
    # (puncuation vertices --AuxK, AuxX, and AuxG-- are ignored).
    
    
    
    
    
    
    
    
    ####################################
    
    # The following code block creates for each sentence the proper number of word nodes and populates
    # each node with the attributes drawn from the input xml, It also adds a new attribute called Subtree.
    # The value of @Subtree is taken from raw.subtree.l[[j]], where j is the number of a given setence in
    # sentence.lsit.
    
    k <- 1
    
    for (k in 1:(length(sentence.list[[j]])-1)) {
      
      raw.subtree.v <- raw.subtree.l[[j]][k] # extract subtree for given word node
      
      raw.subtree.v <- unlist(raw.subtree.v) # change to vector from list
      
      projection.v <- unlist(raw.subtree.v) # change to vector from list
      
      raw.subtree.v <- paste(raw.subtree.v, sep="", collapse=" ") # change to character vector with one element.
      # Sequence of values for subtree is made into single character vector
      # with each element. This step is necessary to produce a correctly formatted
      # #Subtree attribute.
      
      ##################
      # The following code block checks each vertex in a given sentence for projectivity. A projection of a vertex
      # is the vertex and all vertices that are transitively dependent on it (i.e., a vertex itself and all its
      # descendents). A vertex is projective if its projection forms an interval in the linear order of the
      # tree. In other words, members of a subtree form a contiguous sequence in the order of vertices.
      # No vertices from other subtrees intervene. A vertex is NonProjective if there is a gap in the continuous
      # (and contiguous) sequence, with the member of another subtree in that gap. 
      
      # The following code must check for punctuation, which should not be allowed to count as gaps in subtrees.
      
      
      if (length(projection.v) > 0)  { # do not consider vertices with empty @Subtree attributes.
        
        projection.span.v <- min(projection.v):max(projection.v) # make a vector of integers from the 
                                                # lowest integer in the Subtree to the largest.
                                                # This sequence represents a subtree without gaps (ignoring punctuation)
        
        projection.gaps.v <- setdiff(projection.span.v, projection.v)  # a vector of elements present in the
                                                # generated sequence but absent in the actual Subtree of each
                                                # vertex.  The elements of this vector represent the @id attributes
                                                # of potential gaps in the subtree.
       
      }
      
      
      if (length(projection.gaps.v) < 1 ) { # an empty vector indicates no potential gaps.
        
        
        projectivity.attr <- "Projective" # No potential gaps means the subtree is necessarily projective.
        
        
      } else { # a vector that is not empty indicates possible gaps, Most punctuation must be elimnated from consideration.
        
        relat.counter.v <- 0 # A counter vector to keep track of non-puntuation gaps in the subtree.
        
        punctuation.v <- c("AuxX", "AuxK", "AuxG") # a character vector contaiing  3 types of @relation attributes to
                                                   # be left out of consideration. These relations do not allow dependencies.
                                                   # They are not syntactically functional and thus cannot count as gaps.
        
        for (m in 1:length(projection.gaps.v)) { # this loop checks each potential gap, one element at a time.
          
          relat.v <- sentence.list[[j]][projection.gaps.v[m]] # for the current element in projection.gaps.v (indicated by variable m),
                                                  # collect the list of attributes from sentence.list (variable j indicates
                                                  # the reference number of the current sentence).
          
          relat.v <- unlist(relat.v) # convert from list object to named character vector.
          
          relat.v <- relat.v["word.relation"] # vector containing value of @relation attribute
          
          if (length(setdiff(punctuation.v, relat.v)) < 3) { # if the @relation attribute under consideration is not one
                                                  # of the three types of punctuation code in punctuation.v,
                                                  # the setdiff() function will return a vector with 3 elements.
                                                  # A length of less than 3 indicates that the current potential gap element
                                                  # is a relevant instance of punctuation. NO CHANGE is made to the
                                                  # relat.counter.v.
            
            
            
          } else { # Will execute when the setdiff() function indicates that the @relation attribute in question
                                                 # is not a relevant instance of punctuation. This result means that the 
                                                 # token being considered represents a gap.
            
            relat.counter.v <- relat.counter.v + 1 # Counter changed to indicate presence of a gap.
            
          } # end of the "for" loop to identify gaps.
          
        }
        
        if (relat.counter.v > 0) { # A value greater than 0 indicates a gap.
          
          projectivity.attr <- "NonProjective"  # A gap in the subtree means the vertex is not projective.
          
        } else # A value equal to 0 indicates no gap.
          
          projectivity.attr <- "Projective"  # No gap in the subtree indicates that the vertex is projective.
        
      }
      
      
      
      ###################
      
      b <- unlist(sentence.list[[j]][[k]]) # vector of attributes for given word element.
      word.xml <- xmlNode("word") # create word xml node
      
      # The following if/else switch accounts for the different attributes in ellipsis vertices
      
      if ("insertion_id" %in% names(b)) {
        
        word.xml <-  addAttributes(word.xml, id=b["id"], form = b["form"],
                                   lemma = b["lemma"], postag = b["postag"],
                                   relation = b["relation"], head = b["head"],
                                   cite = b["cite"], insertion_id = b["insertion_id"],
                                   artificial = b["artificial"],  Subtree = raw.subtree.v,
                                   Projectivity = projectivity.attr) # populate node from input xml. Add new @Subtree attribute.
        
        
        
      } else  {
        
        word.xml <-  addAttributes(word.xml, id=b["id"], form = b["form"],
                                   lemma = b["lemma"], postag = b["postag"],
                                   relation = b["relation"], head = b["head"],
                                   cite = b["cite"], Subtree = raw.subtree.v,
                                   Projectivity = projectivity.attr) # populate node from input xml. Add new @Subtree attribute.
        
        
      } # end of if/else switch
      
     
      
      sent.xml <- append.xmlNode(sent.xml, word.xml) # insert word.xml as child of given sentence node.
      
    }
    k <- 1 # reset iterator for each token.
    
    
    subtree.xml <- append.xmlNode(subtree.xml, sent.xml) # Insert sentence into document xml.
    
  } # end of loop j
  
  
  
  saveXML(subtree.xml, file =  file.path(output.dir, files.v[i], fsep = "/"))  

  
} # end of loop i 



##########################





