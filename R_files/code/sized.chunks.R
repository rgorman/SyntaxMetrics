library(XML)
library(stylo)
source("code/corpusFunctions.R")
input.dir <- "sWord_input"
files.v <- dir(path=input.dir, pattern=".*xml")

#the following script calls the user-defined function "getSwordChunkMaster).
#this function will return a list of lists of tables, each table with a maximum of words = the second variable

book.freqs.l <- list()
for(i in 1:length(files.v)){
  doc.object <- xmlTreeParse(file.path(input.dir, files.v[i]), useInternalNodes=TRUE)
  chunk.data.l <- getSwordChunkMaster(doc.object, 2000)
  book.freqs.l[[files.v[i]]] <-chunk.data.l
  
}






summary(book.freqs.l)

#convert list into matrix object
#this code requires the user defined function "my.apply"
freqs.l <- lapply(book.freqs.l, my.apply)

summary(freqs.l)

freqs.df <- do.call(rbind, freqs.l)
#the result is a long form data frame

dim(freqs.df)
head(freqs.df)
write.csv(freqs.df, file="sWord_output/inspect1.csv")

#make name labels for the file
bookids.v <- gsub(".xml.\\d+", "", rownames(freqs.df))
bookids.v[1:20]


freqs.df$ID[1:10]
#make book-with-chunk id labes

book.chunk.ids <- paste(bookids.v, freqs.df$ID, sep="_")
book.chunk.ids[1:20]

#replace the ID column in freqs.df
freqs.df$ID <- book.chunk.ids
head(freqs.df)

#cross tabulate data
result.t <- xtabs(Freq ~ ID+Var1, data=freqs.df)
dim(result.t)

  #convert to a data frame
final.df <- as.data.frame.matrix(result.t)

dim(final.df)

#make human readable rownames for final.df
metacols.m <- do.call(rbind, strsplit(rownames(final.df), "_"))
head(metacols.m)

#make human readable column names
colnames(metacols.m) <- c("sampletext", "samplechunk")
head(metacols.m)
unique(metacols.m[, "sampletext"])

#make author vector and strip work name and book numbers from it
author.v <- gsub("\\..*", "", metacols.m[, "sampletext"])
author.v <- gsub("\\d+$", "", author.v)
head(author.v)
unique(author.v)
length(author.v)
author.v

#bind these metadata to final.df
authorship.df <- cbind(author.v, metacols.m, final.df)


#reduce the feature set
freq.means.v <- colMeans(authorship.df[, 4:ncol(authorship.df)])

#collect column means of a given magnitude
keepers.v <- which(freq.means.v >=.00025)

keepers.v[1:10]

#use keepers.v to make a smaller data frame object for analysis
smaller.df <- authorship.df[, c(names(authorship.df)[1:3],
                                names(keepers.v))]


dim(smaller.df)



train <- smaller.df[, 4:ncol(smaller.df)]
class.f <- smaller.df[, "author.v"]

library(e1071)
model.svm <- svm(train, class.f)



summary(model.svm)

pred.svm <- predict(model.svm, train)
summary(pred.svm)
as.data.frame(pred.svm)

table(pred.svm, class.f)
classAgreement(table(pred.svm, class.f))
