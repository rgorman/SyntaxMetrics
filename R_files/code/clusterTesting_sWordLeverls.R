library(XML)
library(tm)
library(dendextend)

source("code/corpusFunctions.R")


# location of files: C:\Users\rgorm\Documents\syntacto_stylistics\APA_Poster\sWord_files\divided_authors


input.dir <- "../sWord_levels/ngram_files"
files.v <- dir(path=input.dir, pattern=".*xml")

length(files.v)

# set increment to 1
i <- 1

book.freqs.l <- list ()
for (i in 1:length(files.v)) {
  doc.object <- xmlTreeParse(file.path(input.dir, files.v[i]), useInternalNodes=TRUE)
  swords <-getNodeSet(doc.object, "//sWord", )
  sword.content <- paste(sapply(swords, xmlValue), collapse = NULL)
  sword.content <-tolower(sword.content)
  book.freqs.t <-table(sword.content)
  book.freqs.rel.t <- 100*(book.freqs.t/sum(book.freqs.t))
  
  book.freqs.l[[files.v[i]]] <-book.freqs.rel.t
  
}




#converting an R list into a Data Matrix
freqs.l <- mapply(data.frame, ID=seq_along(book.freqs.l),
                  book.freqs.l, SIMPLIFY=FALSE, MoreArgs=list(stringsAsFactors=FALSE))


freqs.df <- do.call(rbind, freqs.l)

# check names of data frame to provide parameters for conversion to wide format table
names(freqs.df)

#convert from long form table to wide format
result <- xtabs(Freq ~ ID+sword.content, data=freqs.df)

#convert wide format table to matrix object
final.m <- apply(result, 2, as.numeric)

dim(final.m)

# make names for rows
names_for_files.v <- gsub (".xml", "", files.v)


#substitute files names for row numbers
rownames(final.m) <-names_for_files.v

rownames(final.m)




#reduce data matrix to features with largest means (most common features)
smaller.m <- final.m[, apply(final.m,2,mean)>=.0025]

#check size of reduced feature set
dim(smaller.m)

View(smaller.m)


# order columns by column mean, largest to smallest and create object with results
ordered.m <- smaller.m[, order(colMeans(smaller.m), decreasing=TRUE)]
View(ordered.m)

#create distance object as input to hclust algorithm. Possible methods are "euclidian", "maximum", "manhattan", "canberra", "binary" or "minkowski". Default is "euclidian".
dist.smaller.m <- dist(smaller.m)
dist.smaller.m2 <- dist(scale(smaller.m), upper = FALSE, diag = TRUE)

reference.m <- ordered.m[, 1:150]
write.csv(as.matrix(reference.m), file="Rresults/Reference.csv")

dist.smaller.m2

View(dist.smaller.m)
write.csv(as.matrix(dist.smaller.m2), file="Rresults/RevisedDistance3.csv")
write.csv(as.matrix(dist.smaller.m), file="Rresults/RevisedDistance4.csv")
as.matrix(dist.smaller.m2)
print(dist.smaller.m2)


# run hclust and get result in object (available methods are "ward.D", "ward.D2", "single", "complete" "average", "mcquitty", "median", or "centroid")
groups1 <- hclust(dist.smaller.m, method="ward.D2")
groups2 <- hclust(dist.smaller.m2, method="ward.D2")



# plot the results
plot(groups1, hang=-1, xlab="Perseus Treebank", main="Dendrogram of Ancient Languages Dependency Treebank")
plot(groups2, hang=-1, xlab="Perseus Treebank", main="Dendrogram of Ancient Languages Dependency Treebank")




# use package dendextend to improve appearance of dendrogram
dend2 <- as.dendrogram(groups2)

dend2 <- color_branches(dend, k=3)
dend2 <- color_labels(dend2, k=3)

plot(dend2)

dend3 <- hang.dendrogram(dend2, hang_height = 0.1)
plot(dend3, main="Dendrogram of Ancient Languages Dependency Treebank")

labels_colors(dend2) <- 2
dend2 <- color_labels(dend2, k=3)
rect.dendrogram(dend2, k=3)

labels_colors(dend2)[2] <- rainbow(12)[3]

labels_colors(dend2)[10] <- "indianred1"

order.dendrogram(dend2)

orders <- order.dendrogram(dend2)
orders[27:33]
orders

labels_colors(dend2)[1] <- "red" # Hdt
labels_colors(dend2)[2] <- "indianred1" # Diodorus
labels_colors(dend2)[c(3,7)] <- "hotpink1" # # Plutarch
labels_colors(dend2)[4] <- "darksalmon" # Thuc.
labels_colors(dend2)[5] <- "darkred" # Athen.
labels_colors(dend2)[6] <- "darkorange" # Lysias
labels_colors(dend2)[c(8,9)] <- "deeppink" # Polybius
labels_colors(dend2)[c( 11, 12, 13, 14, 15)] <- "forestgreen" # Iliad
labels_colors(dend2)[c(16, 17, 18, 19, 20, 21)] <- "darkgoldenrod" # Odyssey
labels_colors(dend2)[c(22, 23, 24, 25, 26)] <- "cornflowerblue" # Sophocles
labels_colors(dend2)[c(27, 28, 29, 30, 31, 32, 33)] <- "blue" # Aeschylus
labels_colors(dend2)[c(34, 35, 36)] <- "blueviolet" # Hesiod


# colors for scaled dendrogram

labels_colors(dend2)[1] <- "red" # Diodorus
labels_colors(dend2)[c(2, 3)] <- "indianred1" # Plb
labels_colors(dend2)[4] <- "hotpink1" # # Lysias
labels_colors(dend2)[5] <- "darksalmon" # Thuc.
labels_colors(dend2)[6] <- "darkred" # Athen.
labels_colors(dend2)[7] <- "darkorange" # Hdt
labels_colors(dend2)[c(8,9)] <- "deeppink" # Plutarch
labels_colors(dend2)[c( 11, 12, 13, 14, 15)] <- "forestgreen" # Sophocles
labels_colors(dend2)[c(10, 16, 17, 18, 19, 20, 21)] <- "darkgoldenrod" # Aeschylus
labels_colors(dend2)[c(22, 23, 24, 25, 26, 27)] <- "cornflowerblue" # Iliad
labels_colors(dend2)[c(28, 29, 30, 31, 32, 33)] <- "blue" # Odyssey
labels_colors(dend2)[c(34, 35, 36)] <- "blueviolet" # Hesiod


par(dend2)

plot(dend2, cex = 0.3, main="Dendrogram of Ancient Languages Dependency Treebank", sub = "this is the story of a man")
dend3 <- hang.dendrogram(dend2, hang_height = 0.1)

labels_colors(dend2)

labels_cex(dend3) <- 1
get_leaves_branches_attr(dend3, "height")
dend3 %>% get_leaves_attr("height")
dend4 <- hang.dendrogram(dend3, hang_height = 1)

plot(dend4)

get_branches_heights(dend3)

dend4 <- rank_branches(dend4, diff_height = 2)

dend3[[1]][1]
plot(flatten.dendrogram(dend3))

groups[[8]]

dend3[[2]][1]

plot(ladderize(dend3), horiz = TRUE)
     
     
