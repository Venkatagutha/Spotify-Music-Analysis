# Spotify-Music-Analysis
THis project is about visualising popular artists and 
providing meaningful insights about various features 
of a song that make it to the top of the list. With the
help of Rstudio I was able to work on the data and provide
useful insights.

For this project I made use of 2 different datasets:
1) SpotifyTop100.csv
  -This dataset consists of Spotify Top 100 songs of the year 2017.
  -consists of 16 columns and 100rows
  
2)Data.csv
  -This dataset consists of 200 daily most streamed 
   songs for the entire year 2017 in 53 countries.
  -consists of 7 columns and 3.44 million rows.
  
 I have uploaded the plots in the results file.
  
**Visualizations**:

[1]Artists with multiple Songs

First, I read the .csv file into *Spotify*
Then with the help of pipeline('%>%') I was able to 
group_by artist then summarise the number of observations
and then filter out artists with multiple songs

with the help of ggplot2 and its functionsI was able to
visualise artists with multiple songs.
 
 **Key Insights**
 We can see Chainsmokers, Ed sheeran, Drake and Martin Garrix
 have 3 or more songs on Spotify top100 songs but is this enough 
 to say that these artis are popular? 
 
 


[2] Co-relation between various features of a song.
 For the co relation between various features of,we 
 do not require the first three columns of the spotify dataset.
 With the help of corrplot we function we can give various other 
 arguements like the method and type of the corrplot
 you require.

 *Key Insights*
 
 With this cor plot we can clearly see that valence is 
 positively related to energy, loudness and valence.
 We can also see that danceability is negatively related to 
 the tempo of the song.
 
 [3] With the help of a decision tree we can classify or rather predict
 the standings of the song based on the various features of the song.
 
  *Key Insights*
 From this tree model we can see that songs that have lower key value than 3.5,
 less than 203 seconds and valence lesser than 0.68 generally end up on the top of 
 the list and songs that have a greater key value than 3.5, valence more than or 
 equal 0.73, longer than 244 seconds and with speechiness more than 0.05 tend to
 end up in the bottom part of the list.
 

 
 **[4]Key Note Analysis:
 Every song has a particular key note. There are about
 12 key notes in music. with the help of a box plot I was 
 able to explain the average standings of the song based on
 the song's key note.
 
 *Key Insights*
 
  From the box plot we can see that songs that belong to these key notes (A#,Bb),
 (B), (C), (C#,Dd) and (D) end up in upper half of the list and songs that belong to 
 the key notes (E), (F), (F#,Gb) ,(G),(G#,Ab) end up in the bottom half of the top100
 list.

 
 **[5]Popular Artist:
 
 With the help of daily top 200 songs dataset I
 was able to visualise the most popular artists of the year 2017
 
 For this first I filtered out the daily top 200 for the country US.
 To make sure if i got the right dataset, with the help as.Date function
 I was able to extract month and year from the date coulmn.
 With this I was able to completley filter daily top 200 songs for the 
 year 2017 from January 1st 2017 - December 31 2017.
 
 Now our dataset is ready to be worked on. To view the popular artists I
 filtered out the daily top 5 songs of the daily top200 for the entire year
 2017 and grouped them by artist,position,month and quarter. And then with the help
 pipeline i was able to input the filtered dataset and summarise it based on the number of appearances.
 
 With the help of ggplot2 I could efficiently visualise the populart artists and how many times
 they featured on top5 in the year 2017. To make it better I was also able to visualise
 the different position the artist appeared on top5 with the help of
 color legend.
   I was able to do this by converting the position into factor and then
   giving it as "fill" for aesthics function for geom_bar.
   
*Key Insights*
From our above inference we found out Chainsmokers, Ed sheeran, Drake and Martin Garrix
 have 3 or more songs on Spotify top100 songs but is this enough 
 to say that these artis are popular? This bar graph gives the answer to this question, none
 of the mentioned artists appeared for more than 100 times on top5 except for ed sheeran.
 From the above graph we can really see Post Malone, Kendrick Lamar, Lil Uzi Vert,
 DJ Khaled appeared more times on the top5 list. We can clearly see that Post Malone had one
 of the best years of his career. He is definitely an artist to look out for in the future.
   
 **[6] Most Common Words:
 
As we know that generlly most of songs have similar or sometimes the same name.
With text mining we can determine the most common words used to name a song.
I was able to do this with the help of tidy text, where we first give the required
field as a dataframe. Inorder to find the most common words used we first devide
the dataframe into one-token-per row(also known as tokenization) i.e one word per
row. Later with the help of other function of dplyr library I was able to remove
stop words( words like and,a,the,in) which generally dont make sense in a song name.
After getting rid of the stopwords using count function of dplyr I was able to count
the most common words used in a song name and visualised this in a word cloud.

*Key Insights*

From the word cloud we can clearly see words like lil,love,bad and gucci seemed to be 
the common words used.


[7] **Sentiment Analysis of song names:
To understand the sentiment of the Song name, I made use of *bing lexicon* which 
already has a table of words and its corresponding sentiment whether it is positive
or negative. By performing inner join with bing lexicon and pipelining the output to
group it by sentiment. With the help of a filter I was able to visualise words with higher
frequency and their sentiment in a bar graph.

*Key Insights*

We can see that the word love has been way too many times but we can see
negative sentiment words seemed to be more frequent than positive words.




