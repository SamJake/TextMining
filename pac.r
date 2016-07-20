#install.packages("tm")
#install.packages("wordcloud")
library("tm")
library(wordcloud)
pac2k <- read.csv("E:/R/TextMining/PAC2K.csv",stringsAsFactors=FALSE)

nrow(pac2k)
names(pac2k)
head(pac2k[,1:5])
head(pac2k[,18:23])
str(pac2k)

pac <- data.frame(id <- pac2k$ID,
                  sum <- pac2k$BRIEF_PROBLEM_SUMMARY,
                  des <- pac2k$DESCRIPTION,
                  res <- pac2k$RESOLUTION,stringsAsFactors=FALSE)

nrow(pac)
names(pac) <- c("id","sum","des","res")
str(pac)

sum_text <- paste(pac$sum,collapse=" ")
nchar(pac$sum[1])
nchar(sum_text)

sum_source <- VectorSource(sum_text)

sum_corp <- Corpus(sum_source)
nchar(sum_corp[[1]]$content)
sum_corp <- tm_map(sum_corp,removeWords,stopwords("english"))
nchar(sum_corp[[1]]$content)
#sum_corp[[1]]$content

sum_corp <- tm_map(sum_corp,removeNumbers)
nchar(sum_corp[[1]]$content)
#sum_corp[[1]]$content
#sum_corp <- tm_map(sum_corp,removePunctuation)#preserve_intra_words_dashes=TRUE
nchar(sum_corp[[1]]$content)
#sum_corp[[1]]$content


dtm_sum <- DocumentTermMatrix(sum_corp)
dtm_sum <- removeSparseTerms(dtm_sum,0.2)
m_dtm_sum <- as.matrix(dtm_sum)
f_dtm_sum <- colSums(m_dtm_sum)
f_dtm_sum <- sort(f_dtm_sum,decreasing = TRUE)
head(f_dtm_sum,25)
tail(f_dtm_sum,25)


words <- names(f_dtm_sum)
wordcloud(words[1:100],f_dtm_sum[1:100])