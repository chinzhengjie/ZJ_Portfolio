# The Grandslams and GOATs of Tennis

The term "GOAT" means the "Greatest Of All Time" and is a commonly used term to describe exactly that: someone who is considered to be the best to ever compete in a particular field. In tennis, we are fortunate enough to be able to experience not one but **three** GOATs during the same era, all of whom are currently tied for the record for the most number of men's singles grandslam titles at 20 each. As counter-intuitive as it sounds to have three GOATs, I feel that "The Big 3" of tennis (Roger Federer, Rafael Nadal and Novak Djokovic) are all deserving of this prestigious title. Their dominance over the last two decades has led to the advent of arguably the strongest era of tennis in all of history. As such, I thought it would be interesting and insightful to do some analysis on the big three's stats over this period to see just how well they have performed in tennis' four most momentous tournaments: The Australian Open (AO), French Open (FO), Wimbledon (W) and US Open (UO), otherwise known as the Grandslams.

<br/>

## The Big 3 (as of August 2021)

<br/>

### Roger Federer
**Current World Ranking**: 9 <br/>
**Career High Ranking**: 1 <br/>
**Born**: 8 August 1981 <br/>
**Country**: Switzerland <br/>
**Grandslam Titles**: 20 (6 AO, 1 FO, 8 W, 5 UO) <br/>
**ATP 1000 Titles**: 28 <br/>
**Turned Pro in Year**: 1998 <br/>
<br/>
  
### Rafael Nadal
**Current World Ranking**: 3 <br/>
**Career High Ranking**: 1 <br/>
**Born**: 3 June 1986 <br/>
**Country**: Spain <br/>
**Grandslam Titles**: 20 (1 AO, 13 FO, 2 W, 4 UO) <br/>
**ATP 1000 Titles**: 36 <br/>
**Turned Pro in Year**: 2001 <br/>
<br/>

### Novak Djokovic
**Current World Ranking**: 1 <br/>
**Career High Ranking**: 1 <br/>
**Born**: 22 May 1987 <br/>
**Country**: Serbia <br/>
**Grandslam Titles**: 20 (9 AO, 2 FO, 6 W, 3 UO) <br/>
**ATP 1000 Titles**: 36 <br/>
**Turned Pro in Year**: 2003 <br/>

<br/>
<br/>

## Methodology

In the analysis, I have utilised three datasets which were taken from [kaggle](https://www.kaggle.com/michau96/federer-on-grandslam-tournaments). The author gathered the data by combining other datasets from:

- Jeff Sackmann (https://github.com/JeffSackmann)
- Tennis-Data.co.uk (http://www.tennis-data.co.uk/)
- Ultimate Tennis Statistics (https://www.ultimatetennisstatistics.com/)

The analysis was carried out in R and the first step was to combine the three datasets into one large dataset to work with. The Stats.csv was the primary dataframe and I combined both the Match.csv and the Player.csv with it by match_id and player_id respectively. Next, I checked for unusable null values and for duplicates in the data. Thereafter, I removed certain columns which I would not be using and added two more columns derived from existing columns.

With the prepared and combined dataset, we can now take a look at the analysis of the players' stats.

<br/>

## Aces

<p align="center">
<img src="images/1.%20Big%203%20Average%20Aces.png" width="700" height="700">  
</p>

Federer is well known for having the fastest serve among the big three and this is clearly shown in the chart, with him leading in the number of average aces across all tournaments and an overall average of just over 10 aces per match. When we look at the average aces by tournament, we can see that they follow almost exactly the same trend, with the highest number occuring on the grass courts of Wimbledon and the lowest on the clay courts of the French Open. This can be attributed to the speed of the ball being the highest on grass, followed by hard courts and finally, clay.

<br/>
<br/>

<p align="center">
<img src="images/1.%20Big%203%20First%20Serve%20Percentage.png" width="700" height="700">
</p>

However, when it comes to first serve consistency, Nadal comes out on top with the highest average first serve percentage across all tournaments. Nadal averages around 67% while Federer is significantly lower at around 63%. At the same time, from both charts, we can see that Djokovic is more balanced in these aspects as he falls in between the other 2 for both average aces and first serve percentage.

<br/>

## Break Points

<p align="center">
<img src="images/3.%20Big%203%20Break%20Point%20Stats.png" width="700" height="700">  
</p>

In tennis, the serve is seen as a huge advantage and losing a game on your serve, which means your serve has been broken, is often extremely costly in a match. Thus, a break point is when the player serving is one point away from losing the game. Having said that, even with a good serve, it is almost inevitable for players to face break points at some point in a match. This is where the Big 3 shine. They are three of the mentally strongest players on tour and these tense moments during break points are really where they show their mettle. Not only do all three of them face significantly fewer break points on average than the overall average, they also save a much higher percentage of break points. 

<br/>

## Return of Serve

<p align="center">
<img src="images/2.%20Big%203%20on%20Return%20of%20Serve.png" width="850" height="680">  
</p>

The Big 3 are also incredibly good at winning points on first serve returns and this is shown by their significantly higher average wins than the overall average of all players. Yet, on the return of second serves, Djokovic is the strongest by far, with an average of over 22 wins on second serve returns. This is probably one of the reasons why he is known as one of the best returners on tour.

<br/>

## Match Length

<p align="center">
<img src="images/4.%20Big%203%20Average%20Match%20Duration.png" width="950" height="650">  
</p>

When it comes to match length, the more aggressive Federer generally plays the shortest matches. He dishes out the most number of aces per match among the three and is also well known for his net play, both of which will certainly contribute to closing out a match quicker. As for both Nadal and Djokovic, they are more known for being baseline players who rely on their consistency, shot-making and ability to out hit their opponents. This is why their matches are generally longer and more drawn out.

<br/>
<br/>

<p align="center">
<img src="images/5.%20Big%203%20Win-Loss%20in%203%2C%204%20and%205%20set%20matches.png" width="700" height="700">
</p>

In tennis, most tournaments are played on a best-of-3-sets basis. However, the grandslams are played on best-of-5-sets. This is what makes them so unique and at the same time, so challenging. Although the Big 3 have done well in countless other tournaments, their true achievements are in the grandslams. Having to win 3 sets compared to 2 often makes all the difference in a match. We can see that the Big 3 excel in 3 set matches, which means that they rarely ever lose a match by losing 3 sets in a row to their opponent. However, in 4 set matches, Federer's win rate begins to lag the other two. In 5 set matches, we can see that Djkovic is clearly the strongest, with a win rate of 75.0%, compared to Nadal and Federer's 63.3% and 63.6% respectively. This really speaks to Djokovic's mental strength and physical fitness.

<br/>


## World Ranking

<p align="center">
<img src="images/6.%20Big%203%20%20World%20Ranking.png" width="1000" height="665">  
</p>

Through this analysis so far, we have been able to see some of the Big 3's individual strengths. However, when we look at their ranking over the years, we get a better picture of their dominance as contemporaries. They have spent a huge portion of the time between 2000 and 2019 trading positions within the top 3 ranks. Of course, there are periods where they fall out of the top 3 but these are often due to injuries. When the Big 3 are on form, they certainly compete on another level compared to the rest of the tour.

<br/>
<br/>

<p align="center">
<img src="images/7.%20Rank%20Top%2010%20Match%20Wins%20againt%20Rank%20Top%2010.png" width="1000" height="665">
</p>

Their match wins against top 10 ranked players in the grandslams are phenomenal as well. Federer, Nadal and Djokovic have 59, 47 and 46 wins respectively and the next player who comes closest to this is Andy Murray, who has 19 wins. 19 might seem much less impressive but Murray is actually an incredible player as well who has won 3 grandslams. This simply reiterates the dominance of the Big 3 and shows how they really are in a league of their own.

<br/>
<br/>

<p align="center">
<img src="images/8.%20Big%203%20vs%20Top%2010%20Rank%20Players.png" width="700" height="700">
</p>

Although all three of them have impressive win rates against top 10 players, Nadal manages to boast the highest win rate, at 73.4%.

<br/>


## The Grandslams

<p align="center">
<img src="images/9.%20Grandslam%20Win-Loss.png" width="1000" height="665">  
</p>

From this chart, we can see that Nadal has an absolutely stunning win rate at the French Open. With only 2 losses and 93 wins, it is obvious why Nadal is often dubbed the "King of Clay". At the same time, his weakest grandslam is Wimbledon. This is because on clay courts, the ball tends to travel slower and this gives him a little more time to set up his shots, which he does better than anyone else. Conversely, Federer excels the most in Wimbledon, with 12 losses and a whopping 101 wins. The faster grass courts fit his aggressive play style and allow him to end points quickly. As for Djokovic, he is a more all-rounded player and is able to play well on each surface. However, he does particularly well on the hard courts in the Australian Open, where he has the highest win rate among the three, at 89%.

<br/>
<br/>

<p align="center">
<img src="images/10.%20Big%203%20Grandslams.png" width="1000" height="500">
</p>

Finally, this chart shows the culmination of the Big 3's grandslam achievements. As the dataset only covers from 2000 up to 2019, I decided to add 2020 and 2021's data for this chart. We can see that by 2021, all three of them are tied for the record for the most number of men's singles grandslam titles at 20 a piece. 60 grandslams evenly distributed among these three amazing players. On top of this, since 2003, only a handful of grandslams have been won by someone aside from the Big 3 and this fully illustrates their dominance in this era. For years, many have talked about a new generation of younger players coming in to compete against the Big 3. However, they still have a long way to go as the Big 3 continue to dominate the grandslams every year.

<br/>


## Conclusion

There has been much discussion and debate over who has the right to be called the GOAT. There are valid points to each side of the argument but overall, I feel that there is no need for there to be only one GOAT. Roger Federer, Rafael Nadal and Novak Djokovic have all proven themselves to be an integral part of tennis. On many occasions, each of them has even mentioned that their rivalries drive them to become even better and to compete at an even higher level. This has inadvertently led to the greatest era in tennis. Sadly, the three of them cannot compete forever and they will all inevitably retire one day. However, their incredible achievements and the legacies they leave behind will forever be etched in history and regarded as the greatest of all time.
