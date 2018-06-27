spotify<- read.csv("spotify.csv")

install.packages("dplyr")
install.packages("plyr")
install.packages("corrplot")
install.packages("heatmaply")
install.packages("caTools")
install.packages("class")
install.packages("tidytext")
install.packages("wordcloud")



library(ggplot2)
library(plyr)
library(dplyr)
library(arules)
library(corrplot)
library(heatmaply)
library(rpart)
library(rpart.plot)
library(caTools)
library(class)
library(tidytext)
library(wordcloud)
# to view artists with 2 or more songs on billboard
top_artists<-spotify%>%group_by(artists)%>% 
  summarise(observations = n())%>%
  filter(observations>1)
Artists_multiple<- ggplot(data = top_artists)
Artists_multiple+geom_bar(aes(x= artists, y= observations),stat = "identity" , 
               fill=ifelse(top_artists$observations==2,"navyblue","purple"))+
  xlab("Artists") + ylab("No.Of.Songs")+ ggtitle("Artists with multiple Songs", subtitle = "US top100 2017") +
  theme(axis.title.x = element_text(size=18, colour = "brown" ),
        axis.text.x = element_text(size = 12),
        axis.title.y = element_text(size=18, colour = "brown" ),
        axis.text.y= element_text(size = 12),
        title = element_text(size = 18, colour = "navyblue"),
        
        legend.text= element_text(size=12,color = "blue"),
        legend.title = element_text(size = 15, colour = "red"),
        legend.justification = c(1.05,1.05),
        legend.position = c(1,1),
        
        plot.title = element_text(family = "Courier"),
        plot.subtitle = element_text(family = "Courier"))

# can improve------------------------------------------------


spot<- spotify[,-c(1,2,3)]
S1<-cor(spot)
col<- colorRampPalette(c("green","yellow","red"))(30)
corrplot(S1, method = "number",type= "lower",order = "hclust",col = col,bg="grey3",
         tl.col = "black",tl.srt = 35)

spot$rank<-c(1:100)
tree<- rpart(rank~., data = spot)
plot(tree)
label(tree)
rpart.plot(tree)
# Key Note Analysis
Spotify.Top100<-spotify
Spotify.Top100$rank<-c(1:100)
Spotify.Top100$key<- as.character(Spotify.Top100$key)
Spotify.Top100$key<- revalue(Spotify.Top100$key,c("0"="C","1"="C#,Db","2"="D","3"="D#,Eb",
                               "4"="E", "5"= "F", "6"= "F#,Gb", "7"= "G",
                                "8"="G#,Ab", "9"="A", "10"= "A#,Bb","11"= "B"))
Spotify.Top100$key<- as.factor(Spotify.Top100$key)
Keys<- ggplot(data = Spotify.Top100,aes(x= key, y = rank, color =key))
Keys + geom_jitter()+ geom_boxplot(alpha=0.5)+
 xlab("Key Note") + ylab("Rank")+ ggtitle("Key Note Analysis", subtitle = "U.S Top100 2017") +
  theme(axis.title.x = element_text(size=18, colour = "brown" ),
        axis.text.x = element_text(size = 12),
        axis.title.y = element_text(size=18, colour = "brown" ),
        axis.text.y= element_text(size = 12),
        title = element_text(size = 18, colour = "navyblue"),
        
        legend.text= element_text(size=12,color = "blue"),
        legend.title = element_text(size = 15, colour = "brown",inherit.blank = T),
        
        plot.title = element_text(family = "Courier"),
        plot.subtitle = element_text(family = "Courier"))


##### Daily top5 Appearance(2017)
Data2017<- read.csv("data.csv")
str(Data2017)
Data2017US<-Data2017%>%filter(Region=="us")
#//Extracting month and year from date------
Data2017US$Month<- format(as.Date(Data2017US$Date),"%m")
Data2017US$Year<- format(as.Date(Data2017US$Date),"%y")
Data2017US$Year<- as.character(Data2017US$Year)
Data2017US<-Data2017US%>%filter(Year=="17")

Data2017US$Quarter<- Data2017US$Month
Data2017US$Quarter<- revalue(Data2017US$Quarter, c("01"= "Quarter-1", "02"= "Quarter-1",
                                                 "03"="Quarter-1", "04"="Quarter-2", "05"="Quarter-2",
                                                 "06"="Quarter-2","07"="Quarter-3", "08"="Quarter-3",
                                                 "09"="Quarter-3", "10"="Quarter-4",
                                                 "11"="Quarter-4", "12"="Quarter-4"))


Data2017US$Month<- as.character(Data2017US$Month)
Data2017US$Month<- revalue(Data2017US$Month, c("01"= "01-January", "02"= "02-February",
                                                   "03"="03-March", "04"="04-April", "05"="05-May",
                                                   "06"="06-June","07"="07-July", "08"="08-August",
                                                   "09"="09-September", "10"="10-October",
                                                   "11"="11-November", "12"="12-December"))


#Top5 for the Entire Year
USTop52017<-Data2017US%>%
  filter(Position<=5)%>%
  group_by(Artist,Position, Month,Quarter )%>%
  summarise(appearance = n())%>%arrange(desc(Position))
# Perfect collection of data---
USTop52017$Position<- as.factor(USTop52017$Position)
USTop52017$Quarter<- as.factor(USTop52017$Quarter)
Top5_chart<- ggplot(data=USTop52017, aes(x=Artist, y = appearance))
Top5_chart + geom_bar(stat = "identity", aes(fill=Position))+ coord_flip()+
  xlab("Artists") + ylab("Appearances")+ ggtitle("Popular Arstists", subtitle = "US daily top5 2017") +
  theme(axis.title.x = element_text(size=18, colour = "brown" ),
        axis.text.x = element_text(size = 12),
        axis.title.y = element_text(size=18, colour = "brown" ),
        axis.text.y= element_text(size = 12),
        title = element_text(size = 18, colour = "navyblue"),
        
        legend.text= element_text(size=12,color = "blue"),
        legend.title = element_text(size = 15, colour = "red"),
        legend.justification = c(1.05,1.05),
        legend.position = c(1,1),
        
        plot.title = element_text(family = "Courier"),
        plot.subtitle = element_text(family = "Courier"))
    
# Most Common words-----
Data2017US$Track.Name<- as.character(Data2017US$Track.Name)
text_set <- data_frame(line=1:72400, text= Data2017US$Track.Name)
# creating tokens
textT<-text_set%>%  
  unnest_tokens(word,text)

data(stop_words)
stop_words[1150,]<-c("feat","custom")
stop_words[1151,]<-c("remix","custom")
textT<- textT%>%
 anti_join(stop_words)
  
TextC<-textT%>%
  count(word, sort= T)

par(bg="black")
wordcloud(head(TextC$word,100), head(TextC$n,50),min.freq = 10, random.order =F ,
          colors = brewer.pal(6,"Dark2"), ordered.colors = F, scale = c(1.5,.5),rot.per = 0.35)
# Understanding the Sentiment 
get_sentiments("bing")

sentiment<-textT%>%
  inner_join(get_sentiments("bing"))%>%
  count(word, sentiment, sort = T)%>%
  ungroup()

sentiment_set<- sentiment%>%
  group_by(sentiment)%>%
  top_n(20)%>%
  ungroup()%>%
  mutate(word = reorder(word, n))

sentiment_plot<-  ggplot(data = sentiment_set ,aes(x= word, y= n, fill= sentiment))
sentiment_plot + geom_bar(stat = "identity", position = "dodge" )+ 
  geom_text(aes(label= n)) + coord_flip() +
xlab("Word") + ylab("Count")+ ggtitle("Sentiment analysis", subtitle = "U.S Daily Top 200") +
  theme(axis.title.x = element_text(size=18, colour = "brown" ),
        axis.text.x = element_text(size = 12),
        axis.title.y = element_text(size=18, colour = "brown" ),
        axis.text.y= element_text(size = 12),
        title = element_text(size = 18, colour = "navyblue"),
        
        legend.text= element_text(size=12,color = "blue"),
        legend.title = element_text(size = 15, colour = "red"),
        legend.justification = c(1.05,1.5),
        legend.position = c(1,1),
        
        plot.title = element_text(family = "Courier"),
        plot.subtitle = element_text(family = "Courier"))


