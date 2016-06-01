setwd("~/Documents/topic-detection")
library(streamR)

#generates csv files for each candidate for each date - 4 x 9 = 36 csv files

files <-c("tweets.03.16.2016.summary.json", "tweets.03.17.2016.summary.json","tweets.03.18.2016.summary.json","tweets.03.19.2016.summary.json","tweets.03.20.2016.summary.json","tweets.03.21.2016.summary.json","tweets.03.22.2016.summary.json","tweets.03.23.2016.summary.json","tweets.03.24.2016.summary.json","tweets.03.25.2016.summary.json") 
for (filename in files)
 {
  tweets_shiny.df <- parseTweets(filename, simplify = TRUE)
  HillaryClinton <- tweets_shiny.df[grep("Hillary Clinton|HillaryClinton", tweets_shiny.df$text), ]
  BernieSanders <- tweets_shiny.df[grep("Bernie Sanders|BernieSanders", tweets_shiny.df$text), ]
  DemocratTotals <- rbind(HillaryClinton, BernieSanders)
  TedCruz <- tweets_shiny.df[grep("Ted Cruz|TedCruz", tweets_shiny.df$text), ]
  DonaldTrump <- tweets_shiny.df[grep("Donald Trump|DonaldTrump", tweets_shiny.df$text), ]
  RepublicanTotals <- rbind(TedCruz, DonaldTrump)
  
   candidate <-c(HillaryClinton, BernieSanders, DemocratTotals,TedCruz,DonaldTrump, RepublicanTotals)
   for(candidate in candidates){


assign(paste("tweets",candidate,filename), candidate)

paste("tweets",candidate,filename)$text <- sapply(paste("tweets",candidate,filename)$text, function(row) iconv(row, "latin1", "ASCII", sub=""))
TweetCorpus <- paste(unlist(tweets_DT$text), collapse =" ") #to get all of the tweets together
TweetCorpus <- Corpus(VectorSource(TweetCorpus))
TweetCorpus <- tm_map(TweetCorpus, PlainTextDocument)
TweetCorpus <- tm_map(TweetCorpus, removePunctuation)
TweetCorpus <- tm_map(TweetCorpus, removeWords, stopwords('english'))
# %TweetCorpus <- tm_map(TweetCorpus, stemDocument) # % No stemming for now!
TweetCorpus <- tm_map(TweetCorpus, content_transformer(tolower),lazy=TRUE)
TweetCorpus <- tm_map(TweetCorpus, PlainTextDocument)
wordcloud(TweetCorpus, max.words = 100, random.order = FALSE)


themes <- read.csv("themes.csv", stringsAsFactors=F)
econ.words <- themes$word[themes$topic=="economy"]
imm.words <- themes$word[themes$topic=="immigration"]
health.words <- themes$word[themes$topic=="healthcare"]
milit.words <- themes$word[themes$topic=="military"]
china.words <- themes$word[themes$topic=="china"]
guncontrol.words <- themes$word[themes$topic=="guncontrol"]
race.words <- themes$word[themes$topic=="race"]
climate.words <- themes$word[themes$topic=="climate"]
religion.words <- themes$word[themes$topic=="religion"]
religion.trade <- themes$word[themes$topic=="trade"]



TweetWords <- strsplit(TweetCorpus[[1]]$content, " ")[[1]]


#positive <- sum(TweetWords %in% pos.words)
#negative <- sum(TweetWords %in% neg.words)


paste("economy",candidate,filename) <- sum(TweetWords %in% econ.words)
paste("immigrant", candidate, filename) <- sum(TweetWords %in% imm.words)
paste("healthcare", candidate, filename) <- sum(TweetWords %in% health.words)
paste("military",candidate, filename) <- sum(TweetWords %in% milit.words)
paste("china",candidate, filename) <- sum(TweetWords %in% china.words)
paste("guncontrol",candidate, filename) <- sum(TweetWords %in% guncontrol.words)
paste("race",candidate,filename) <- sum(TweetWords %in% race.words)
paste("climate",candidate,filename) <- sum(TweetWords %in% climate.words)
paste("religion",candidate,filename) <- sum(TweetWords %in% religion.words)
paste("trade",candidate,filename) <- sum(TweetWords %in% trade.words)



   }

  }

 
  


#   HillaryClinton <- tweets_shiny.df[grep("Hillary Clinton", tweets_shiny.df$text), ]
#   HillaryClinton_wo <- tweets_shiny.df[grep("HillaryClinton", tweets_shiny.df$text), ]
#   HillaryTotals <- rbind(HillaryClinton, HillaryClinton_wo)
#   #write.csv(HillaryTotals, file = "HCTotals" + date + ".csv")
#   write.csv(HillaryTotals, file = paste("HCTotals", filename, ".csv"))
#   #load(HillaryTotals)
#   
#   #tweets_shiny.df <- parseTweets("all_candidates.json", simplify = TRUE)
#   BernieSanders<- tweets_shiny.df[grep("Bernie Sanders", tweets_shiny.df$text), ]
#   BernieSanders_wo <- tweets_shiny.df[grep("BernieSanders", tweets_shiny.df$text), ]
#   BernieTotals <- rbind(BernieSanders, BernieSanders_wo)
#   write.csv(BernieTotals, file = paste("BSTotals", filename, ".csv"))
#   
#   #tweets_shiny.df <- parseTweets("all_candidates.json", simplify = TRUE)
#   DonaldTrump<- tweets_shiny.df[grep("Donald Trump", tweets_shiny.df$text), ]
#   DonaldTrump_wo <- tweets_shiny.df[grep("DonaldTrump", tweets_shiny.df$text), ]
#   DonaldTotals <- rbind(DonaldTrump, DonaldTrump_wo)
#   write.csv(DonaldTotals, file = paste("DTTotals", filename, ".csv"))
#   
#   
#   #tweets_shiny.df <- parseTweets("all_candidates.json", simplify = TRUE)
#   #TedCruz<- tweets_shiny.df[grep("Ted Cruz", tweets_shiny.df$text), ]
#   #TedCruz_wo <- tweets_shiny.df[grep("TedCruz", tweets_shiny.df$text), ]
#   #TedTotals <- rbind(TedCruz, TedCruz_wo)
#   
#   
#   #tweets_shiny.df <- parseTweets("all_candidates.json", simplify = TRUE)
#   MarcoRubio<- tweets_shiny.df[grep("Marco Rubio", tweets_shiny.df$text), ]
#   MarcoRubio_wo <- tweets_shiny.df[grep("MarcoRubio", tweets_shiny.df$text), ]
#   MarcoTotals <- rbind(MarcoRubio, MarcoRubio_wo)
#   write.csv(MarcoTotals, file = paste("MRTotals", filename, ".csv"))
#   #load(MarcoTotals)

