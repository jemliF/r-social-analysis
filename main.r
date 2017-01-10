install.packages('base64enc')
install.packages('bit64')
install.packages("twitteR")
install.packages("RCurl")
install.packages('tm')
install.packages('wordcloud')
install.packages('NLP')
install.packages('RColorBrewer')


require(twitteR)
require(RCurl)
require(NLP)
require(RColorBrewer)
require(tm)
require(wordcloud)

consumer_key <- 'O3zJZJuVQccUMMTaC4U0zF40g'
consumer_secret <- 'rTNNF5gmAJEncL9DXHvpOHkij2CqEGcidmure8NZcJL8h3cKFs'
access_token <- '3214803982-TDvvHqPwOeU9bsYD1x6x58z9M0da7cyLnOEOEsi'
access_secret <- '2fGSzHWdwl9QQmZjxoFrR21WnOvZx5dQJADn2E6SlMgBI'
setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

twitts <- searchTwitter("docker", lang='en', n=500, resultType = 'recent')
#twitts[1:3]
#class(twitts)
twitts_text <- sapply(twitts, function(x) x$getText())
#str(twitts_text)

twitts_corpus <- Corpus(VectorSource(twitts_text))
inspect(twitts_corpus[1])

twitts_clean <- tm_map(twitts_corpus, removePunctuation)
twitts_clean <- tm_map(twitts_clean, content_transformer(tolower))
#twitts_clean <- tm_map(twitts_clean, removeWords, stopwords('english')) 
twitts_clean <- tm_map(twitts_clean, removeNumbers)
twitts_clean <- tm_map(twitts_clean, stripWhitespace)
twitts_clean <- tm_map(twitts_clean, removeWords, c('https', 'htppsco', 'the', 'for', 'from', 'and'))

wordcloud(twitts_clean, random.order = F, max.words = 10, scale = c(7.5, 2.5), col=rainbow(50))


