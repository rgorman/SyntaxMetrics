


###################
# a code block to create word nodes and populate them with attributes on an ad hoc basis.
# This is necessary because ellipses nodes have an extra attribute.

# Identify directory with the input files.
input.dir <- "./xml_input"

# Identify directory for the output files.
output.dir <- "./xml_output"


files.v <- dir(path=input.dir, pattern=".*xml") # A vector with each file name from input directory.

# create object with full xml of tree file. 
doc <- xmlParse(file.path(input.dir, files.v[1]))

# extract setences from full tree xml
sentence.nodes <- getNodeSet(doc, "//sentence")

# convert nodes to list object

sentence.list <- xmlApply(sentence.nodes, xmlToList)


subtree.xml <- xmlNode("subTree_document")
j <- 10
k <- 17

# this is a model to follow
b <- unlist(sentence.list[[j]][[k]]) # vector of attributes for given word element.
word.xml <- xmlNode("word") # create word xml node
word.xml <-  addAttributes(word.xml, id=b["id"], form = b["form"],
                           lemma = b["lemma"], postag = b["postag"],
                           relation = b["relation"], head = b["head"],
                           cite = b["cite"], Subtree = raw.subtree.v,
                           Projectivity = projectivity.attr) # populate node from input xml. Add new @Subtree attribute.

sent.xml <- append.xmlNode(sent.xml, word.xml) # insert word.xml as child of given sentence node.

###############

b <- unlist(sentence.list[[j]][[k]]) # vector of attributes for given word element.
word.xml <- xmlNode("word") # create word xml node
if ("insertion_id" %in% names(b)) { # Distinguishes ellipsis vertices. These have different attributes than
                                    # regular vertices. 
  
  word.xml <-  addAttributes(word.xml, id=b["id"], form = b["form"],
                             lemma = b["lemma"], postag = b["postag"],
                             relation = b["relation"], head = b["head"],
                             cite = b["cite"], insertion_id = b["insertion_id"],
                             artificial = b["artificial"]) # populate node from input xml. Add new @Subtree attribute.
  
  
} else  {
  
  word.xml <-  addAttributes(word.xml, id=b["id"], form = b["form"],
                             lemma = b["lemma"], postag = b["postag"],
                             relation = b["relation"], head = b["head"],
                             cite = b["cite"]) # populate node from input xml. Add new @Subtree attribute.
  
  
}
word.xml

k <- 5
names(b)
n <- 1
name.holder[n]
value.holder[n]

1:10 %in% 3
3 %in% 1:10
"insertion_id" %in% names(b)

subtree.xml
