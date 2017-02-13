

# script to test textreuse package

require(textreuse)

input.directory <- "../rel_pos_prose/test_reuse"

corpus <- TextReuseCorpus(dir=input.directory, tokenizer = tokenize_ngrams, n=1, keep_tokens = TRUE, )

results.m <- pairwise_compare(corpus, jaccard_similarity, directional = TRUE)

write.csv(results.m, file="../rel_pos_prose/jaccard_1_Dec7.csv")
names(corpus)

hash_string("The")
lsh_threshold(200, 100)

vignette("textreuse-minhash", package = "textreuse")
minhash <- minhash_generator(n=200)

head(corpus[[1]])
length(minhashes(corpus[[1]]))
minhashes(corpus[[1]])
corpus[[1]]
str(corpus)

length(unique(corpus[[1]]$hashes))

results.m <- pairwise_compare(corpus$minhashes, jaccard_similarity)
wordcount(corpus)
str(corpus[[1]])

lash.results <- lsh(corpus, 100)
lsh_candidates(lash.results)
results.m <- lsh_compare(lsh_candidates(lash.results), corpus, jaccard_similarity)
