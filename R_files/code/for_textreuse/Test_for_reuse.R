

# create a script to extract sWord data from sWord.l[[i]] and format it for saving in text file.


# The script will contain a loop which in turn contains a  nested loop;




#reset holder and inccrementizer j

holder <-NULL
j <- 1

# the following creates a file ("holder") containing the contents of the chunks of a given file.
# it is part of the inner loop.

for (j in 1:length(main_index)) {
  h <- sapply(sWord.l[[1]][main_index[j]], paste, sep="", collapse=" ")
  holder <- append(holder, h)
  
  
 
  
  cite.param.m[1,1]
  author.v <- cite.param.m[1,1]
  no_punc <- gsub("\\.|:", "", author.v)
  underscore <- as.character(gsub(" ", "_", no_punc))
  author.v
  as.character(underscore)
  underscore
  
}

write(holder, file="holder.txt")

q <- unlist(sWord.l[[1]][25])


p <- as.character(q)
h <- sapply(sWord.l[[1]][25], paste, sep="", collapse=" ")
h[1]
head(h)
sWord.l[[1]][25]

write(p, file="test.txt")
write(h, file="test2.txt")
write(q, file="test3.txt")

require(textreuse)
