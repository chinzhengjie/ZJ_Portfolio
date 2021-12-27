# Airline and Airport Analysis

This is a case study taken from Coursera which I had worked on while undertaking the Google Data Analytics Professional Certificate. All of the original datasets were provided by Coursera and are about a **fictional** company named Cyclistic. As the dataset was extremely large, I found it easier to work on the analysis through R Desktop.

<br/>

## Background

Cyclistic is a bike-share company based in Chicago. They launched a successful bike-share offering in 2016 and since then, the program has grown to a fleet of 5,824 bicycles that are geotracked and locked into a network of 692 stations across Chicago. The bikes can be unlocked from one station and returned to any other station in the system anytime. Cyclistic’s marketing strategy has relied on building general awareness and appealing to broad consumer segments. One approach that helped to make these possible was Cyclistic's flexibile pricing plans: single-ride passes, full-day passes, and annual memberships. Customers who purchase single-ride or full-day passes are referred to as **casual** users. Customers who purchase annual memberships are Cyclistic **members**. Subsequently, Cyclistic’s finance analysts have concluded that annual members are much more profitable than casual users and they believe that maximising the number of annual members will be key to future growth.

<br/>

## Approach

The 2 main questions of the case study are: 

1. How do annual members and casual users use Cyclistic bikes differently?
2. How can Cyclistic design marketing strategies aimed at converting casual riders into annual members?

The purpose of this project is to identify any potentially useful trends found in the data for each user type (member and casual). I mainly focused on segregating the data by the user type, followed by the days of the week and months of the year in order to find any difference between the usage of members and casual users throughout different time periods. Additionally, I will also point out any unsual characteristics of the data that I come across.

I haved detailed my process and findings below.

<br/>

## Data Processing and Cleaning

After importing the 4 quarters of data provided (Q2, Q3, Q4 of 2019 and Q1 of 2020), the most important step would be to merge these into 1 large dataset. Thus, the first step was to ensure that each quarter's dataset had consistent headers and consistent data types. I chose to use the most recent quarter, Q1 of 2020, as the reference point for the columns. Furthermore, there were certain columns, such as Longitude, Latitude, Gender, etc., which had data which was no longer tracked by Cyclistic and were not available in the most recent quarter. Thus, after merging the 4 datasets, I removed all the unnecessary columns from the main dataset.

<br/>

## Analysis & Findings: Airlines

### Full 12-Month Period

<p align="center"> <b>
Airline Comparison
</b> </p>

<p align="center">
<img src="Images/Airline%20Comparison%20(Scatter).PNG">
</p>

From the visualisations, we can see that based on the average delay and percentage of flights delayed, HA, AS and US perform the best. However, they have very few total flights. Comparatively, airlines such as WN, DL, OO and AA have a significantly greater number of flights yet still manage to do relatively well.

<br/>

### Peak 3-Month Period (Jun-Aug)

<p align="center"> <b>
Airline Comparison During Peak Months
</b> </p>

<p align="center">
<img src="Images/Airline%20Comparison%20(Peak)%20(Scatter).PNG">
</p>

When we analyse the performance of the airlines during the busiest months of the year (Jun, Jul, Aug), we find that HA and AS still have the best performance. However, for the larger airlines, DL and OO are still able to main their performance in terms average delay and percentage of delayed flights. AA and WN’s performance, on the other hand, visibly deteriorates during the peak months.

## Analysis & Findings: Airports

<p align="center"> <b>
Airport Comparison
</b> </p>

<p align="center">
<img src="Images/Airport%20Comparison%201.PNG">
<img src="Images/Airport%20Comparison%202.PNG">
</p>

For this visualisation, we filter out airports with fewer than 1000 total flights. Taking into account the total flights at each airport, LAX and SFO perform the best with the lowest average delay and lowest percentage of flights delayed. 

Similarly, here, we also filter out airports with fewer than 1000 total flights. When it comes to average taxi in and out duration, LAX performs quite poorly compared to others, despite doing well in the terms of delays. Airports such as PHX, SFO and LAS have better average taxi in and out durations.

<p align="center"> <b>
Airport Connectivity
</b> </p>

<p align="center">
<img src="Images/Airport%20%20Connectivity.PNG">
</p>

Airports are also measured by their connectivity, which is the number of connections an airport has to other airports. In this regard, ATL, ORD, DFW, 10397 and 13930 are the top 5.

<p align="center"> <b>
Seasonal Impact on Airports
</b> </p>

<p align="center">
<img src="Images/Seasonal%20Effect%20on%20Airport%20Performance.PNG" width="500">
<img src="Images/Seasonal%20Effect%20on%20Types%20of%20Delay.PNG" width="500">
</p>

When comparing taxi durations, we find a similar trend, with Dec-Feb and Jun-Aug experiencing the highest average taxi in and out durations. The number of cancelled flights is also high in Jan, Feb, Jun and Dec. Notably, Feb has the highest number of cancellations by far.

From the visualisation, we can see that the periods with the greatest effects on delays are Jun-Jul and Dec-Feb. These periods experience the highest percentage of delays.

## Map Visualisations of Airports

<p align="center"> <b>
Map of Airport Connectivity
</b> </p>

<p align="center">
<img src="Images/Map%20of%20Airport%20Connectivity.PNG">
</p>

This visualisation shows the airports with the best connectivity.

<p align="center"> <b>
Map of Weather Delays in Airports
</b> </p>

<p align="center">
<img src="Images/Map%20of%20Weather%20Delays.PNG">
</p>

This visualisation shows the regions which experience the most weather delays. From the map, we can see that weather delays occur most frequently in airports found near the coastline. However, there are more airports located near the coastlines and thus, the high density of weather delays in these regions could also be attributed to this.
