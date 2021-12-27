# Airline and Airport Analysis

This project stems from an assignment I worked on while enrolled in a data analytics module in National University of Singapore (NUS). All datasets were provided by NUS professor Liu Qi Zhang. In this project, I used R programming to analyse and visualise relevant data to determine which airports and airlines are the best choices for travellers.

<br/>

## Background

There are 3 datasets which will be utilised in this project: 

<b> airlines.csv </b> - This contains the IATA code and name of 15 airlines in the United States.

<br/>

<b> airports.csv </b> - This contains the IATA code, name and location of all airports in the United States.

<br/>

<b> flights.csv </b> - This contains a significant amount of data regarding the flights which occurred in the United States over the entire year of 2015. This includes information such as the airports and airlines involved, various types of delays experienced during the flights and many other details.

<br/>

Over the course of this project, I will be attempting to answer the following questions: 

1. Which airline should be chosen or avoided when travelling?

2. Which airport should be chosen or avoided when travelling?

3. What is the seasonal effect on flight performance?

Thus, the goal is ultimately to find useful insights about airports and airlines in the United States and to identify any major trends in the datasets. Since the flights.csv file contains the most useful information, it will be the main dataset that is used in the analysis. 

In the analysis for the airlines, I have split the comparison into two parts. The first includes data from the entire year and the second which includes only data from the busiest 3-month period of the year, June to August. The airlines will be compared by their average delay time, percentage of flights delayed and total number of flights.

In the analysis for the airports, each airport will be compared by their average delay time, percentage of flights delayed, total number of flights, average taxi in time, average taxi out time and airport connectivity. On top of this, there are five different types of delays which are commonly experienced by flights. These include air system delays, airline delays, late aircraft delays, security delays and weather delays. These will be used to help determine the impact of seasonality on airports.

I haved detailed my process and findings below.

<br/>

## Data Processing and Cleaning

Although the dataset was relatively clean, there were some issues regarding the way in which the data was presented in columns which had date and time variables. For example, the column "SCHEDULED_DEPARTURE" represents the time which flights were scheduled to depart from their origin airport. If a flight was supposed to depart at 05:45am, it was simple represented as the integer "545". The columns affected by this include: "SCHEDULED_DEPARTURE", "DEPARTURE_TIME", "WHEELS_OFF", "WHEELS_ON", "SCHEDULED_ARRIVAL" and "ARRIVAL_TIME". Therefore, I created new columns for each of these to represent the time and date in their proper datetime formats. I also combined the "YEAR", "MONTH" and "DAY" columns into a new column with the correct datetime format.

Furthermore, flights that departed and arrived on different days were incorrectly shown. For example, a flight which departed at "01/01/2015 23:00" and arrived the following day at "02/01/2015 01:00" was incorrectly shown to arrive at "01/01/2015 01:00". Thus, I fixed the issue by conditionally adding one day to each data entry affected.

<br/>

## Analysis & Findings: Airlines

For all the scatterplot visualisations, the airports and airlines with more ideal results are found in the <b> bottom left quadrant </b> of the charts as these are characterised by shorter and fewer delays for airlines and airports, as well as shorter average taxi in and taxi out times for airports. <b> Larger data points </b> represent a larger sample size of flights which equates to more accurate statistics and suggests that the corresponding airports or airlines are able to handle a greater number of flights.

### Full 12-Month Period

<p align="center"> <b>
Airline Comparison
</b> </p>

<p align="center">
<img src="Images/Airline%20Comparison%20%20(Scatter).PNG">
</p>

From the scatterplot above, we can see that based on the average delay and percentage of flights delayed, the airlines HA, AS and US perform the best. However, they have very few total flights. Comparatively, airlines such as WN, DL, AA and OO have a significantly greater number of flights yet still manage to do relatively well which is even more impressive and suggests that these could be more ideal choices.

<br/>

### Peak 3-Month Period (Jun-Aug)

<p align="center"> <b>
Airline Comparison During Peak Months
</b> </p>

<p align="center">
<img src="Images/Airline%20Comparison%20%20(Peak)%20(Scatter).PNG">
</p>

When we analyse the performance of the airlines during the busiest months of the year (Jun, Jul, Aug), we find that HA and AS still have the best performance. For the larger airlines, DL, AA and OO are still able to main their performance in terms average delay and percentage of delayed flights. However, AA and WN’s performance, on the other hand, visibly deteriorates during the peak months.

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
