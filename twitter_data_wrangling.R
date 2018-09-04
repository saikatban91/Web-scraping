install.packages("twitteR")
library(twitteR)
library(tidyverse)
# Add consumer_key, consumer_secret, 
# access_token and access_secret

consumer_key <- "xxxxxxxxxxxxxxxxxxxxxxxxxxx"
consumer_secret <- "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
access_token <- "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
access_secret <- "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
# create a vector of anticipated search terms
words <- c("Prebiotic", "Prebiotics", "prebiotic", "prebiotics",
           "#Prebiotics", "#Prebiotic", "#prebiotics", "#prebiotic")
words_search <- paste(words, sep = " OR ")
setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)
tw = twitteR::searchTwitter(words_search, n = 10000, since = '2018-05-28', lang = "en",
                            retryOnRateLimit = 1e3)
# convert the data into a dataframe 
pre = twitteR::twListToDF(tw)

pre <- distinct(pre)
# Export the data frame into a csv file for the team to use
write.csv(pre, "pre1.csv")
