freqs.l[[1]]
dim(freqs.df)
result1 <- xtabs(Freq ~ ID+sWord.contents, data=freqs.df)
result2 <- xtabs(Freq ~ ID+sWord.contents, data=freqs.df[1:c,])
result3 <- xtabs(Freq ~ ID+sWord.contents, data=freqs.df[c+1:96651,])
dim(result3)

#convert wide format table to matrix object
final.m1 <- apply(result1, 2, as.numeric)
#convert wide format table to matrix object
final.m2 <- apply(result2, 2, as.numeric)
#convert wide format table to matrix object
final.m3 <- apply(result3, 2, as.numeric)

df2 <- as.data.frame(final.m2)
df3 <- as.data.frame(final.m3)

biggy <- rbind(df2, df3)
b <- which(freqs.df[,1]==17)
c <- b[length(b)]
c
freqs.df[c+1,]


names_for_files.v <- gsub (".xml", "", files.v)


# substitute files names for row numbers
rownames(biggy) <-names_for_files.v

# order columns by column mean, largest to smallest and create object with results
ordered.df <- biggy[, order(colMeans(biggy), decreasing=TRUE)]

# reduce data matrix to features with largest means (most common features)
smaller.m <- ordered.df[,1:3000]
