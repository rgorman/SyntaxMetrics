

smaller.m
zscores.m <- scale(smaller.m)
zscores.m <- scale(ordered.df)

# combine the two matrices by columns
m <- cbind(smaller.m, zscores.m)

m <- cbind(rawFinal.m, ordered.df, zscores.m)
m[, 990:1000]

dim(m)

# Reorder the columns to interleave them
# the concatinate function -- c() -- appatently conjoins rows 1 and 2 of each column
m <- m[, c(matrix(1:ncol(m), nrow = 2, byrow = T))]  

m <- m[, c(matrix(1:ncol(m), nrow = 3, byrow = T))] 


# make matrix of labels for columns
label.a <- matrix(rep("Rel. Freq. per 100 tokens", 498), ncol = 498)
label.b <- matrix(rep("Z-Score", 498), ncol = 498)
label.c <- matrix(rep("Raw Count", 498), ncol = 498)

# combine matrices
labels.ab <- cbind(label.a, label.b)

labels.abc <- cbind(label.c, label.a, label.b)


# reorder columns to interleave

index.abc <- c(matrix(1:ncol(labels.abc), nrow = 3, byrow = TRUE))
labels.abc <- labels.abc[index.abc]
labels.abc <- matrix(labels.ab, nrow = 1)

index <- c(matrix(1:ncol(labels.ab), nrow = 2, byrow = TRUE))
labels.ab <- labels.ab[, index]
labels.ab <- matrix(labels.abc, nrow = 1)

# loop to make rank labels
i <- 1
rank <- NULL
for (i in 1:498)  {
  rank <- append(rank, rep(i, 3))
  
  
}

# convert "rank" to matrix
rank.m <- matrix(rank, nrow = 1)

#combine the label matrices by row
combined.m <- rbind(rank.m, labels.ab)
combined.m <- rbind(combined.m, m)

combined.m <- rbind(rank.m, labels.abc, m)

# add total token amounts as first column in matrix
combined.m <- cbind(tokenTotal.m, combined.m)
dim (tokenTotal.m)
dim (combined.m)

# save as csv file
write.csv(combined.m, file = "working_output1/rel-pos_Output_10-25-2016_0445PM.csv")
