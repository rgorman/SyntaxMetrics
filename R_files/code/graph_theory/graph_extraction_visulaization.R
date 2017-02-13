# clean up the workspace
rm(list = ls())


# A script to extract data from treebanks and input it to igraph and associated routines.
# The first routine takes as input a treebank file and extracts an edge matrix as input to a function which will produce an arc diagram
# The arc diagram works very well to help find edge crossings in dependency trees.
# They are not usefull to find non-prejectivity per se, since dependency direction is not marked

require(igraph)
require(XML)
require(arcdiagram)

# this line reads an XML file into an R object
doc.object <- xmlTreeParse(file = "../graph_theory/Cat-1B.xml")


# this line reads doc.object into an XML Node object which can be accessed through subsetting
top <- xmlRoot(doc.object)

# check "top" to see which element has first sentence
top[[1]]
# set variabe for sentence number in "top".

s <- 1

# extract all @id attrubutes from <word> elements in indexed sentence of "top"
a <- xmlSApply(top[[s]], function(x) xmlGetAttr(x, "id"))

# extract all @head attributes from <word> elementes in indexed sentence of "top"
b <- xmlSApply(top[[s]], function(x) xmlGetAttr(x, "head"))

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

c <- c[index]
rownames(short.edge.matrix)
rownames(short.edge.matrix) <- c

as.vector(short.edge.matrix[1,])
graph.object <- graph_from_edgelist(short.edge.matrix)
plot.igraph(graph.object)
vertex_attr_names(graph.object)


# Call "archplot()" to create diagram to visualize edge crossing in sentences.
arcplot(edge.matrix, las = 1, sorted = TRUE, lwd.arcs = 5 )

c <- append("ROOT", c)



########################

title <- "sentence "
c(title, s)
paste(title, s)

# read edge matrix in from csv file
a <- read.csv(file = "../graph_theory/testGraph_1.csv", header = FALSE)
b <- read.csv(file = "../graph_theory/testGraph_2.csv", header = FALSE)
a
b
plot.igraph(a.graph)
a.graph <- graph_from_edgelist(as.matrix(a), directed = FALSE)
a.tree <- as.tree
str(a)
as.matrix(a)
a.graph
delete.vertices(a.graph, 3)
a.tree <- as_tree(a.graph, root=2)
plot.igraph(a.tree)
class(a.graph)



# two steps to produce a tree graph from edge matrix
 
a.tree <- layout_(a.graph, as_tree(root = 2))           

class(a.tree)
plot(a.graph, layout = a.tree)


plot.igraph(a.graph)
b.graph <- graph_from_edgelist(as.matrix(b), directed = FALSE)
b.graph

b.tree <- layout_(b.graph, as_tree(root = 6))
plot(b.graph, layout = b.tree)

require(tkrplot)
tkplot(b.graph, layout = b.tree)


a.tree <- as_tree(a.graph, root=2)
plot.igraph(a.tree)
class(a.graph)


plot(a.graph, layout = as_tree(a.graph, root = 2))



a.tree <- layout_(a.graph, as_tree(root = 2))           

class(a.tree)
plot(a.graph, layout = a.tree)


# download arc diagram
require(devtools)

# download arcdiagram using "install_github'
install_github("arcdiagram", username = "gastonstat")

require(arcdiagram)

b.edges <- get.edgelist(b.graph)

arcplot(b.edges, las = 1, sorted = TRUE, lwd.arcs = 5)

# remove all objects from working memory
rm(list = ls())
