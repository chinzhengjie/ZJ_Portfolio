# The Grandslams and GOATs of Tennis

The term "GOAT" means the "Greatest Of All Time" and is a commonly used term to describe exactly that: someone who is considered to be the best to ever compete in a particular field. In tennis, we are fortunate enough to be able to experience not one but **three** GOATs during the same era, all of whom are currently tied for the record for the most number of men's singles grandslam titles at 20 each. As counter-intuitive as it sounds to have three GOATs, I feel that the big 3 of tennis (Roger Federer, Rafael Nadal and Novak Djokovic) are all deserving of this prestigious title. As such, I thought it would be interesting to do some analysis on the big three's stats over the past two decades to see just how well they have performed in tennis' four most momentous tournaments: The Australian Open, French Open, Wimbledon and US Open, all of which are otherwise known as the Grandslams.

## The Big 3 (as of August 2021)

### Roger Federer
**Current World Ranking**: 9 <br/>
**Career High Ranking**: 1 <br/>
**Born**: 8 August 1981 <br/>
**Country**: Switzerland <br/>
**Grandslam Titles**: 20 <br/>
**ATP 1000 Titles**: 28 <br/>
**Turned Pro in Year**: 1998 <br/>
<br/>
  
### Rafael Nadal
**Current World Ranking**: 3 <br/>
**Career High Ranking**: 1 <br/>
**Born**: 3 June 1986 <br/>
**Country**: Spain <br/>
**Grandslam Titles**: 20 <br/>
**ATP 1000 Titles**: 36 <br/>
**Turned Pro in Year**: 2001 <br/>
<br/>

### Novak Djokovic
**Current World Ranking**: 1 <br/>
**Career High Ranking**: 1 <br/>
**Born**: 22 May 1987 <br/>
**Country**: Serbia <br/>
**Grandslam Titles**: 20 <br/>
**ATP 1000 Titles**: 36 <br/>
**Turned Pro in Year**: 2003 <br/>
<br/>

## Methodology

In the analysis, I have utilised three datasets which were taken from [kaggle](https://www.kaggle.com/michau96/federer-on-grandslam-tournaments). The author gathered the data by combining other datasets from:

- Jeff Sackmann (https://github.com/JeffSackmann)
- Tennis-Data.co.uk (http://www.tennis-data.co.uk/)
- Ultimate Tennis Statistics (https://www.ultimatetennisstatistics.com/)

The analysis was carried out in R and the first step was to combine the three datasets into one large dataset to work with. The Stats.csv was the primary dataframe and I combined both the Match.csv and the Player.csv with it by match_id and player_id respectively. Next, I checked for unusable null values and for duplicates in the data. Thereafter, I removed certain columns which I would not be using and added two more columns derived from existing columns.

With the prepared and combined dataset, we can now take a look at the analysis of the players' stats.


## Aces

<p align="center">
<img src="images/1.%20Big%203%20Average%20Aces.png" width="700" height="700">  
</p>

description
<br/>
<br/>

<p align="center">
<img src="images/1.%20Big%203%20First%20Serve%20Percentage.png" width="850" height="700">
</p>

description

<br/>

## Return of Serve

<p align="center">
<img src="images/2.%20Big%203%20on%20Return%20of%20Serve.png" width="800" height="700">  
</p>

description


## Break Points

<p align="center">
<img src="images/3.%20Big%203%20in%20Break%20Points.png" width="700" height="700">  
</p>

description


## Match Length

<p align="center">
<img src="images/4.%20Big%203%20Average%20Match%20Duration.png" width="850" height="700">  
</p>

description
<br/>
<br/>

<p align="center">
<img src="images/5.%20Big%203%20Win-Loss%20in%203%2C%204%20and%205%20Set%20Matches.png" width="700" height="700">
</p>

description

<br/>


## World Ranking

<p align="center">
<img src="images/6.%20Big%203%20World%20Ranking.png" width="950" height="600">  
</p>

description
<br/>
<br/>

<p align="center">
<img src="images/7.%20Rank%20Top%2010%20Match%20Wins%20againt%20Rank%20Top%2010.png" width="950" height="600">
</p>

description
<br/>
<br/>

<p align="center">
<img src="images/8.%20Big%203%20vs%20Top%2010%20Rank%20Players.png" width="700" height="700">
</p>

description

<br/>


## The Grandslams

<p align="center">
<img src="images/9.%20Grandslam%20Win-Loss.png" width="1000" height="500">  
</p>

description
<br/>
<br/>

<p align="center">
<img src="images/10.%20Big%203%20Grandslam%20Wins.png" width="1000" height="500">
</p>

description

<br/>


## Conclusion

description



















