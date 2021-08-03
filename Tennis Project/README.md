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

@image of ace stats   @image of ace stats

description


## Return of Serve

@image of chart

description


## Break Points

@image of chart

description


## Match Length

@image of match duration

description

@image of num of sets 345

description


## World Ranking

@image of ranking

description

@image of top 10 vs top 10

description

@image of big3 vs top 10

description


## The Grandslams

@image of GS wins

description

@image of the final chart

description


## Conclusion

description



















