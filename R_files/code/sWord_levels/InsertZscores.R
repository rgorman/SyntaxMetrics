
# read csv file from appropriate folder
# make sure there is no text in file, only numbers

poetry.m <- read.csv(file = "working_input2/poetry.csv", stringsAsFactors = FALSE, header = FALSE)
prose.m <- read.csv(file = "working_input2/prose.csv", stringsAsFactors = FALSE, header = FALSE)




# make a sequence of integers identifying the column numbers of columns holding raw frequencies and z-scores
# raw scores are in the second of every set of 3 columns, z-scores in third 

rawIndex <- seq(2, 1493, 3)
zIndex <- seq(3, 1494, 3)

# make a new matrix contianing only raw frequencies
rawProse.m <- prose.m[, rawIndex]
rawPoetry.m <- poetry.m[, rawIndex]

# make new matrix with z-scores from raw frequencies
Prosezscore.m <- scale(rawProse.m)

# make back up file

newProse.m <- prose.m
newPoetry.m <- poetry.m

# loop new z-scores back into their old places

# loop 1 for poetry
i <- 1

for (i in 1:length(zIndex)) {
  
  newPoetry.m[, zIndex[i]] <- zscore.m[, i]
  
}

# loop 2 for prose

i <- 1

for (i in 1:length(zIndex)) {
  
  newProse.m[, zIndex[i]] <- Prosezscore.m[, i]
  
}

# save file
write.csv(newPoetry.m, file = "working_input2/newPoetry.csv")
write.csv(newProse.m, file = "working_input2/newProse.csv")
