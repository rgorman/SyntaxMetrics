library(XML)




files.v <- dir( pattern=".*xml")

doc <- xmlParse(files.v[1])
Xen1.list <- xmlToList(doc)

top <- xmlRoot(doc)
top[[1]]

Xen1.list[[1]]
Xen1.list$sentence$word[2]

lapply(Xen1.list[[1]][3], function(x) print(x))

holder <- unlist(Xen1.list[[3]][1])
holder["word.id"]



length(Xen1.list)

i <- 2

# extract all @id attrubutes from <word> elements in indexed sentence of "top"
a <- xmlSApply(top[[i]], function(x) xmlGetAttr(x, "id"))

# extract all @head attributes from <word> elementes in indexed sentence of "top"
b <- xmlSApply(top[[i]], function(x) xmlGetAttr(x, "head"))

c <- xmlSApply(top[[i]], function(x) xmlGetAttr(x, "form"))

# convert vectors from character to numeric
a <- as.numeric(a)
b <- as.numeric(b)

# create and edge matrix from the @id ("a") and @head vectors ("b")
# first create matrix with one column (ncol = 1) and a row for each element in "a"
edge.matrix <- matrix(a, ncol=1)
# add elements of "b" as second column
edge.matrix <- cbind(edge.matrix, b)


edge.matrix2 <- matrix(b, ncol=1)
# add elements of "b" as second column
edge.matrix2 <- cbind(edge.matrix2, a)

# delete all rows of "edge.maatrix" where @head = 0. This step eliminates all punctuation from consideration.
# Likewise, the root element of the sentence is linked only with these tokens dependent on in, not with a theoretical "root".

# First, create "index" containing row numbers of all rows with @head greater than 0.
index <- which(edge.matrix[, 2] > 0)
# Use "index" to create new matrix.
short.edge.matrix <- edge.matrix[index, ]

index2 <- which(edge.matrix2[, 1] > 0)
# Use "index" to create new matrix.
short.edge.matrix2 <- edge.matrix2[index2, ]


graph.object <- graph_from_edgelist(short.edge.matrix, directed = TRUE)
plot.igraph(graph.object)

graph.object2 <- graph_from_edgelist(short.edge.matrix2, directed = TRUE)
plot.igraph(graph.object2)


ego(graph.object2, 20, mode = "out")
subtree <- list()
subtree[[i]] <- ego(graph.object2, 20, mode = "out")
class(subtree)
V(graph.object2)$name
x <- sort(subtree[[2]][3])
x[1]

str(subtree)

subs <- ego(graph.object, 20, mode = "out")
subs[[1]]
sort(subs[[3]])

x <- sort(as_ids(subs[[1]]))
y <- as_ids(subs[[1]])
Xen1.list[[1]]

word.nodes <- getNodeSet(doc, "//sentence")
# extract all <sWord> elements from word,nodes. The result is an XMLNodeList object
id.nodes <- sapply(word.nodes, xmlChildren)
id.nodes
word.nodes

sentence.ids <- 

a <- xmlAttrs(top[[2]])

length(Xen1.list[[1]])
Xen1.list[[1]][1]
 
b <- unlist(Xen1.list[[1]][1])       

names(b)

names(a)

b[1]

new.doc.xml <- xmlNode("subTree_document")
new.doc.xml <-  addAttributes(new.xml, origin = files.v[1])

new.sent.xml <- xmlNode("sentence")
new.sent.xml <- addAttributes(new.sent.xml, id = as.numeric(a["id"]), 
                              document_id = a["document_id"], 
                              subdoc = a["subdoc"], span = a["span"])


new.doc.xml[[1]]  <-  addAttributes(new.doc.xml[[1]], id = a["id"], 
              document_id = a["document_id"], 
              subdoc = a["subdoc"], span = a["span"])

new.doc.xml <- append.xmlNode(new.doc.xml, newXMLNode("sentence"))


for (j in 1:length(Xen1.list[[1]])) {
  
  if (j == 1) {
  
   
    
  }
  
  
}

new.word.xml <- xmlNode("word")
new.word.xml <-  addAttributes(new.word.xml, id=b["word.id"], form = b["word.form"],
                               lemma = b["word.lemma"], postag = b["word.postag"],
                               relation = b["word.relation"], head = b["word.head"],
                               cite = b["word.cite"])
                             
new.word.xml2 <- xmlNode("word")
new.word.xml2 <-  addAttributes(new.word.xml, id=b["word.id"], form = b["word.form"],
                               lemma = b["word.lemma"], postag = b["word.postag"],
                               relation = b["word.relation"], head = b["word.head"],
                               cite = b["word.cite"])

z <- append.xmlNode(new.word.xml, new.word.xml2)
z

new.doc.xml
new.sent.xml
new.word.xml
word.xml

# xmltoTable will create an sub-indexable object which can provide a counter for steps on the top object

n = xmlNode("data", attrs = c("numVars" = 2, numRecords = 3))
n = append.xmlNode(n, xmlNode("varNames", xmlNode("string", "A"), xmlNode("string", "B")))
n = append.xmlNode(n, xmlNode("record", "1.2 3.5"))
n = append.xmlNode(n, xmlNode("record", "20.2 13.9"))
n = append.xmlNode(n, xmlNode("record", "10.1 5.67"))


addAttributes(b, a = 1, b = "xyz", "r:version" = "2.4.1", "omg:len" = 3)
cat(saveXML(b), "\n")

saveXML(new.doc.xml, file = "test_Feb-5-2017.xml")

