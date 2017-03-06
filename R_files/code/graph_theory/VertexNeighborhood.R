####### 
# This script calulates subtrees for each node. Only node and its children are extracted.

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


timestamp()

for (i in 1: length(files.v))  {
  
  # create object with full xml of tree file. 
  doc <- xmlParse(file.path(input.dir, files.v[i]))
  
  # extract setences from full tree xml
  sentence.nodes <- getNodeSet(doc, "//sentence")
  
  # convert nodes to list object
  
  sentence.list <- xmlApply(sentence.nodes, xmlToList)
  
  
  subtree.xml <- xmlNode("subTree_document")
  
  file.DepDist.v <- NULL
  total.node.DD.v <- NULL
  
  for (j in 1:length(sentence.list)) {
    
    sentence.projectivity.v <- 0 # A counter to track existence of non-projective vertices in sentence.
    
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
    
    raw.subtree.l <- ego(graph.object, 50, mode = "out") # populate raw.subtree.l
    # with subtrees for each vertex in input vector.
    # first parameter = input graph, second parameter = number of "steps"
    # to take to find elements of subtree (50 is chosen as greater than any in corpus)
    # mode parameter = "out" finds descendents, mode = "in" finds ancestors.
    
    neighborhood.l <- ego(graph.object, 1, mode = "out") # populate neighborhood.l with subtrees of distance = 1.
    
    
    
    
    
    
    ######################################## START OF DEPENDENCY DISTANCE #######################################
                                                              # This code calculates dependency distance for each node.
                                                              # A dependency distance mean is calculated for each sentence.
    
    
    
    
    for (k in 1:(length(sentence.list[[j]])-1)) {
      b <- unlist(sentence.list[[j]][[k]]) # vector of attributes for each word element. 
      
     # heads.v <- append(heads.v, b["head"]) # Populate heads.v with attributes from each word.
      
     # ids.v <- append(ids.v, b["id"]) # Populate ids.v with appropriate attributes from each word.
    #  heads.v <- as.numeric(heads.v) # Convert from character to numeric.
    #  ids.v <- as.numeric(ids.v) # Convert from character to numeric. 
      
     # relations.v <- append(relations.v, b["relation"])
      
    #  punct.index.v <-  c(which(relations.v == "AuxX"), which(relations.v == "AuxK"), which(relations.v == "AuxG"))
    }
    
    k <- 1
    
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
    
    K <- 1
    
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
    
    mean.DepDist.v <- round(mean(abs(node.DepDist.v), na.rm = TRUE), 4)
                                          # Vector whose value will populate atrribute in each sentence node [j].
    
    
    ################################ END OF DEPENDENCY DISTANCE ################################################
    ###########################################################################################################
    
    
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
        
        n.holder.v <- unlist(sentence.list[[j]][neighbor.subtree.v[t]])
        
        
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
    
    k <- 1
    
    
    ###################################################
    
    
    
    
    
    
    
    
    
    
    
    #############################################
    # The following code block identifies the projectivity of each vertex in a given sentence
    # (puncuation vertices --AuxK, AuxX, and AuxG-- are ignored).
    
    
    
    
    
    
    
   
    
    # The following code block creates for each sentence the proper number of word nodes and populates
    # each node with the attributes drawn from the input xml, It also adds a new attribute called Subtree.
    # The value of @Subtree is taken from raw.subtree.l
    
    k <- 1
    
    for (k in 1:(length(sentence.list[[j]])-1)) {
      
      raw.subtree.v <- raw.subtree.l[k] # extract subtree for given word node
      
      raw.subtree.v <- unlist(raw.subtree.v) # change to vector from list
      
      projection.v <- unlist(raw.subtree.v) # change to vector from list
      
      raw.subtree.v <- paste(raw.subtree.v, sep="", collapse=" ") # change to character vector with one element.
      # Sequence of values for subtree is made into single character vector
      # with each element. This step is necessary to produce a correctly formatted
      # #Subtree attribute.
      
      #################################### Code block to extract neighborhood vertices for each vertex
      
      # an if/else switch to avoid problems caused because the length of neighborhood.l is less than
      # the number of word nodes in a sentence         
     
      
      if (k <= length(neighborhood.l)) {
        
        neighborhood.v <- neighborhood.l[[k]] # extract neighborhood for given word element.
        neighborhood.v   <-  paste0(neighborhood.v, sep="", collapse = " ") #convert to a character vector of one element for insertion
        # as attribute into new word element.
        
      } else {
        
        neighborhood.v <- "NA"
        
      }
      
      
     
      
     
      
      
      
      
      
      
      ######################################
      
      
      
      ##################
      # The following code block checks each vertex in a given sentence for projectivity. A projection of a vertex
      # is the vertex and all vertices that are transitively dependent on it (i.e., a vertex itself and all its
      # descendents). A vertex is projective if its projection forms an interval in the linear order of the
      # tree. In other words, members of a subtree form a contiguous sequence in the order of vertices.
      # No vertices from other subtrees intervene. A vertex is NonProjective if there is a gap in the continuous
      # (and contiguous) sequence, with the member of another subtree in that gap. 
      
      # The following code checks for punctuation, which should not be allowed to count as gaps in subtrees.
      
      ######## an ifelse() function  to make sure punctuation marks are not considered non-projective
     
      punc.check.v <- sentence.list[[j]][k] # a list of attributes of a given word
      punc.check.v <-  unlist(punc.check.v) # list converted to named character vector
      
      
      
      if ( "AuxK" %in%  punc.check.v["word.relation"] | "AuxX" %in% punc.check.v["word.relation"]  | "AuxG" %in% punc.check.v["word.relation"]) {
        
        b <- unlist(sentence.list[[j]][[k]]) # vector of attributes for given word element.
        word.xml <- xmlNode("word") # create word xml node
        
         word.xml <-  addAttributes(word.xml, id=b["id"], form = b["form"],
                                   lemma = b["lemma"], postag = b["postag"],
                                   relation = b["relation"], head = b["head"],
                                   cite = b["cite"], Subtree = "NA",
                                   Projectivity = "NA", DepDist = "NA",
                                   Neighborhood = "NA", Relation_Subtree = "NA",
                                   POS_Subtree = "NA", Rel_Pos_Subtree = "NA") # populate node from input xml. Add new @Subtree attribute.
        
         sent.xml <- append.xmlNode(sent.xml, word.xml) # insert word.xml as child of given sentence node
                                           # check here if all goes wrong!
        
      } else {  # process all nodes not AuxX, AuxK, or AuxG
        
        if (length(projection.v) > 0)  { # do not consider vertices with empty @Subtree attributes.
          
          ######################################## ATTEMPT TO ACCOUNT FOR ELLIPSIS IN PROJECTIVITY
          ########################################
          
          b <- unlist(sentence.list[[j]][[k]]) # vector of attributes for given word element.
          
          # The following switch catches ellipsis vertices that are also leaf nodes. It prevents the creation of an
          # empty vector; such would occur if the value of the @id attribute were erased from a leaf vertex.
          
          if ("insertion_id" %in% names(b) & length(projection.v) > 1)  {
            projection.v <- as.numeric(gsub(b["id"], "", projection.v))
            
            
          }
          
          #######################################
          #######################################
          
          
          
          
          projection.span.v <- min(projection.v, na.rm = TRUE):max(projection.v, na.rm = TRUE) # make a vector of integers from the 
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
          
          ################## A code block to remove ellipses from condideration
          
          
          ##################
          
          for (m in 1:length(projection.gaps.v)) { # this loop checks each potential gap, one element at a time.
            
            relat.v <- sentence.list[[j]][projection.gaps.v[m]] # for the current element in projection.gaps.v (indicated by variable m),
            # collect the list of attributes from sentence.list (variable j indicates
            # the reference number of the current sentence).
            
            relat.v <- unlist(relat.v) # convert from list object to named character vector.
            ##########
            
            if ("word.insertion_id" %in% names(relat.v)) {
              
              
            } else {
              
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
                
              }
              
              
            }
            
            ##########
            
            
            
            
          } # end of the "for" loop[m] to identify gaps.
          
          if (relat.counter.v > 0) { # A value greater than 0 indicates a gap.
            
            projectivity.attr <- "NonProjective"  # A gap in the subtree means the vertex is not projective.
            
            sentence.projectivity.v <- sentence.projectivity.v + 1 # Add to sentence projectivity counter to indicate
            # non-projective sentence.
            
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
                                     Projectivity = projectivity.attr,
                                     DepDist = node.DepDist.v[k],
                                     Neighborhood = neighborhood.v,
                                     Relation_Subtree = rel.attr.v,
                                     POS_Subtree = pos.attr.v, 
                                     Rel_Pos_Subtree = rel.pos.attr.v) # populate node from input xml. Add new @Subtree attribute.
          
          
          
        } else  {
          
          word.xml <-  addAttributes(word.xml, id=b["id"], form = b["form"],
                                     lemma = b["lemma"], postag = b["postag"],
                                     relation = b["relation"], head = b["head"],
                                     cite = b["cite"], Subtree = raw.subtree.v,
                                     Projectivity = projectivity.attr,
                                     DepDist = node.DepDist.v[k],
                                     Neighborhood = neighborhood.v,
                                     Relation_Subtree = rel.attr.v,
                                     POS_Subtree = pos.attr.v, 
                                     Rel_Pos_Subtree = rel.pos.attr.v) # populate node from input xml. Add new @Subtree attribute.
          
          
        } # end of if/else switch
        
        
        
        sent.xml <- append.xmlNode(sent.xml, word.xml) # insert word.xml as child of given sentence node.
        
      }
      
      
      k <- 1 # reset iterator for each token.
        
        
        
        
        
      }
      
      
      
      
      ##########
      
      
      
      
      
    
    if (sentence.projectivity.v > 0)  {
      sent.projectivity.attr <- "NonProjective"
     
    } else {
      
      sent.projectivity.attr <- "Projective"
      
    }
    
    sent.xml <- addAttributes(sent.xml, Sentence_Projectivity = sent.projectivity.attr,
                              Mean_DepDist = mean.DepDist.v) # adds attributes to sentence node.
    subtree.xml <- append.xmlNode(subtree.xml, sent.xml) # Insert sentence into document xml.
    
    file.DepDist.v <- append(file.DepDist.v, mean.DepDist.v)
    total.node.DD.v <- append(total.node.DD.v, node.DepDist.v)
    
  } # end of loop j
  
  
  j <- 1 
  
  # saveXML(subtree.xml, file =  file.path(output.dir, files.v[i], fsep = "/"))  

  DD.l[[i]] <- file.DepDist.v
  node.DD.l[[i]] <- total.node.DD.v
  
} # end of loop i 

timestamp()


##########################


subtree.xml


        