# Script to find Dependency Distance for words and sentences.
# Script also inserts DD into attribute in <sentence> elemenets.

require(XML)

# this line reads an XML file into an R object
doc.object <- xmlTreeParse(file = "../Projectivity/working/DD_Xen_Cyr1.xml")




# this line reads doc.object into an XML Node object which can be accessed through subsetting
top <- xmlRoot(doc.object)
top[[7]]



# A loop to extract @head and @id attributes from word elements and use them to compute Dependency Distance.
# The loop should start with the subset of "top" which represents the first sentence element.

# wrapper varaibles for processing
a <- NULL
b <- NULL
c <- NULL
d <- NULL
# Sets increment variable to first <sentence> element in file.
i <- 7

for (i in i:length(top))  {
  
  # uses xmlSApply() to loop through the <word> elements of each sentence.
  # xmlSApply() calls the function xmlGetAttr() and outputs a vector of contents of @head attributes.
  # The output is stored in variable "a". as.numeric() converts output from character vector to numbers
  a <- as.numeric(xmlSApply(top[[i]], function(x) xmlGetAttr(x, "head")))
  
  # The same extraction applied to the @id attribute of each <word> element.
  # The result is stored in variable "b".
  b <- as.numeric(xmlSApply(top[[i]], function(x) xmlGetAttr(x, "id")))
  
  # These lines use which() to remove @head=0 items from "a" and "b".
  # The results are stored in variables "c" and "d".
  c <- a[-which(a == 0)]
  d <- b[-which(a == 0)]
  
  # Uses addAttributes() to add @DepDist attribute and value to each <seentence> element in "top".
  # Computes mean of absolute value of difference of corresponding @head and @id
  # from vectors in variables "c" and "d". Result is rounded to 4 decimal places.
  top[[i]] <- addAttributes(top[[i]], DepDist = round(mean(abs(c-d)),4))
  
  
}


#########

# this line will save file as .xml
saveXML(top, file = "../Projectivity/working/Result_DD_Xen_Cyr1.xml", prefix = '<?xml version="1.0" encoding="UTF-8"?>\n')


top[[7]]

 xmlSApply(top[[5]], function(x) xmlGetAttr(x, "head"))
b <- as.numeric(xmlSApply(top[[6]], function(x) xmlGetAttr(x, "head")))
c <- as.numeric(xmlSApply(top[[6]], function(x) xmlGetAttr(x, "id")))

d <- a[-which(a == 0)]
e <- b[-which(a == 0)]

b
d

d - e
abs(d-e)

round(mean(abs(d-e)), 5)


top[[4]] <- xmlAttrs(node="poop", value="poop")
class(top[[4]])

addAttributes(top[[4]], .attrs = "poop")

b = newXMLNode("bob",
               namespace = c(r = "http://www.r-project.org",
                             omg = "http://www.omegahat.org"))

cat(saveXML(b), "\n")

addAttributes(b, a = 1, b = "xyz", "r:version" = "2.4.1", "omg:len" = 3)
cat(saveXML(b), "\n")

top[[4]] <- addAttributes(top[[4]], DepDist = "poop")


xmlAttrs(top[[4]])

top[[4]]
doc.object

# clear all objects from memory
rm(list = ls())
