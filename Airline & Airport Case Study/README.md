# Aviation Analysis

This project was part of an assignment I worked on while enrolled in a data analytics module in National University of Singapore (NUS). All datasets were provided by NUS professor Liu Qi Zhang. In this project, I used R programming to analyse and visualise the provided datasets to determine which airports and airlines are the best choices for travellers, as well as provide some unique insights gathered from the data.

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

In the analysis for the airlines, I have split the comparison into two parts. The first includes data from the entire year and the second which includes only data from the busiest 3-month period of the year, June to August. The airlines will be compared by their average delay time, percentage of flights delayed and total number of flights in 2015.

In the analysis for the airports, each airport will be compared by their average delay time, percentage of flights delayed, total number of flights, average taxi in time, average taxi out time and airport connectivity. On top of this, there are five different types of delays which are commonly experienced by flights. These include air system delays, airline delays, late aircraft delays, security delays and weather delays. These will be used to help determine the impact of seasonality on airports.

I have detailed my process and findings below.

<br/>

## Data Processing and Cleaning

Although the dataset was relatively clean, there were some issues regarding the way in which the data was presented in columns which had date and time variables. For example, the column "SCHEDULED_DEPARTURE" represents the time which flights were scheduled to depart from their origin airport. If a flight was supposed to depart at 05:45am, it was simple represented as the integer "545". The columns affected by this include: "SCHEDULED_DEPARTURE", "DEPARTURE_TIME", "WHEELS_OFF", "WHEELS_ON", "SCHEDULED_ARRIVAL" and "ARRIVAL_TIME". Therefore, I created new columns for each of these to represent the time and date in their proper datetime formats. I also combined the "YEAR", "MONTH" and "DAY" columns into a new column with the correct datetime format.

Furthermore, flights that departed and arrived on different days were incorrectly shown. For example, a flight which departed at "01/01/2015 23:00" and arrived the following day at "02/01/2015 01:00" was incorrectly shown to arrive at "01/01/2015 01:00". Thus, I fixed the issue by conditionally adding one day to each data entry affected.

<br/>

## Analysis & Findings: Airlines

For all the scatter plots, the airports and airlines with more ideal results are found in the <b> bottom left quadrant </b> of the charts as these are characterised by shorter and fewer delays for airlines and airports, as well as shorter average taxi in and taxi out times for airports. <b> Larger data points </b> represent a larger sample size of flights which equates to more accurate statistics and suggests that the corresponding airports or airlines are able to handle a greater number of flights.

### Full 12-Month Period

<p align="center"> <b>
Airline Comparison
</b> </p>

<p align="center">
<img src="Images/Airline%20Comparison%20%20(Scatter).PNG">
</p>

From the scatter plot above, we can see that based on the average delay and percentage of flights delayed, the airlines HA, AS and US perform the best. However, they have very few total flights compared to airlines such as WN, DL, AA and OO, which have a much greater number of flights and yet still manage to do relatively well. This makes these airlines even more impressive and suggests that these could be the more ideal choices.

<br/>

### Peak 3-Month Period (Jun-Aug)

<p align="center"> <b>
Airline Comparison During Peak Months
</b> </p>

<p align="center">
<img src="Images/Airline%20Comparison%20%20(Peak)%20(Scatter).PNG">
</p>

When we analyse the performance of the airlines during the busiest months of the year (Jun, Jul, Aug), we find that HA, AS and US are still among the best in terms of perforamnce. For the larger airlines, DL, AA and OO are still able to main their performance in terms of average delay and percentage of delayed flights. However, WN???s performance, on the other hand, deteriorates significantly during the peak months. This may suggest that the WN airline struggles at handling the large increase in demand during the peak seasons compared to some of its competitors.

## Analysis & Findings: Airports

<p align="center"> <b>
Airport Comparison
</b> </p>

<p align="center">
<img src="Images/Airport%20Comparison%201.PNG">
<img src="Images/Airport%20Comparison%202.PNG">
</p>

For both of the above visualisations, I filtered out airports with fewer than 1000 total flights. When considering the airports with a greater number of total flights (represented by red and purple data points), LAX and SFO are among the best when it comes to having the lowest average delay and lowest percentage of flights delayed.

However, when it comes to average taxi in and out duration, LAX performs significantly worse compared to other airports, despite doing well in the terms of delays. Airports with a greater number of total flights such as PHX, SFO and LAS have better average taxi in and out durations. Thus, based on these metrics, SFO seems to be one of the best choices for airports.

<p align="center"> <b>
Airport Connectivity
</b> </p>

<p align="center">
<img src="Images/Airport%20%20Connectivity.PNG">
</p>

Airports are also measured by their connectivity, which is the number of unique connections an airport has to other airports. In this regard, ATL, ORD, DFW, 10397 and 13930 are the top 5.

## Seasonal Impact on Flights

<p align="center"> <b>
Seasonal Impact on Flights
</b> </p>

<p align="center">
<img src="Images/Seasonal%20Effect%20on%20Airport%20Performance.PNG" width="500">
<img src="Images/Seasonal%20Effect%20on%20Types%20of%20Delay.PNG" width="500">
</p>

When comparing the seasonal impact on all flights, we can see a clear trend. Dec-Feb and Jun-Aug experience the highest average taxi in and out durations. Also, the number of cancelled flights is high in Jan, Feb, Jun and Dec with Feb having the highest number of cancellations by far. For the seasonal impact on different types of delays, there is a similar trend, where delays peak around Dec-Feb and Jun-Aug. This suggests that these are the busiest periods during the year for air travel.

## Map Visualisations of Airports

<p align="center"> <b>
Map of Airport Connectivity
</b> </p>

<p align="center">
<img src="Images/Map%20of%20Airport%20Connectivity.PNG">
</p>

This map shows the airports with the best connectivity. There are 7 airports which cater to more than 100 unique routes, all of which are represented by red data points and are labelled with their corresponding airport IATA code.

<p align="center"> <b>
Heatmap of Weather Delays in Airports
</b> </p>

<p align="center">
<img src="Images/Map%20of%20Weather%20Delays.PNG">
</p>

Finally, this heatmap shows the regions which experience the most weather delays. From the map, it seems that weather delays occur most frequently in airports found near the east coastline. However, there are more airports located in this region and thus, the higher density of weather delays in these regions is also partially attributed to this.
