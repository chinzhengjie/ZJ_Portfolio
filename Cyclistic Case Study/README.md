# Cyclistic Bike-Share Analysis

This is a case study taken from Coursera which I had worked on while undertaking the Google Data Analytics Professional Certificate. All of the original datasets were provided by Coursera and are about a **fictional** company named Cyclistic. The analysis was done in R Programming.

<br/>

## Background

Cyclistic is a bike-share company based in Chicago. They launched a successful bike-share offering in 2016 and since then, the program has grown to a fleet of 5,824 bicycles that are geotracked and locked into a network of 692 stations across Chicago. The bikes can be unlocked from one station and returned to any other station in the system anytime. Cyclistic’s marketing strategy has relied on building general awareness and appealing to broad consumer segments. One approach that helped make these things possible was the flexibility of its pricing plans: single-ride passes, full-day passes, and annual memberships. Customers who purchase single-ride or full-day passes are referred to as **casual** riders. Customers who purchase annual memberships are Cyclistic **members**. Subsequently, Cyclistic’s finance analysts have concluded that annual members are much more profitable than casual riders and they believe that maximizing the number of annual members will be key to future growth.

<br/>

## Approach

The main question of the case study is this: How do annual members and casual riders use Cyclistic bikes differently?

I opted to analyse the data and see what insights I could find.???

As the data was extremely large, I found it easier to work on the data with R Desktop.

<br/>

## Data Processing and Cleaning

After importing the 4 quarters of data provided (Q2, Q3, Q4 of 2019 and Q1 of 2020), the most important step would be to merge these into 1 large dataset. Thus, the first step was to ensure that each quarter's dataset had consistent headers and consistent data types. I chose to use the most recent quarter, Q1 of 2020, as the reference point for the columns. Furthermore, there were certain columns, such as Longitude, Latitude, Gender, etc., which had data which was no longer tracked by Cyclistic and were not available in the most recent quarter. Thus, after merging the 4 datasets, I removed all the unnecessary columns from the main dataset.

<br/>

<p align="center"> <b>
Main Dataset
</b> </p>

<p align="center">
<img src="images/Merged%20Dataset.PNG">
</p>

<br/><br/>

Thereafter, I added a few extra useful columns for analysis later.

Next, I found some issues with the data in certain columns. The "member_casual" column had varying names for members and casual users as a result of the dataset originating from different quarters and thus, I standarised this column to only contain "member" and "casual". I also removed negative values from the "ride_length" column, as well as rows which had a start station of "HQ QR" in the "start_station_name" column as these entries were for bikes which were taken out of docks and checked for quality by Cyclistic. 

<br/><br/>

<p align="center"> <b>
Cleaned Extra Columns
</b> </p>
 
<p align="center">
<img src="images/Extra%20Columns.PNG">
</p>
 
<br/>

## Data Visualisation

<br/>

<p align="center"> <b>
Daily Data
</b> </p>

<img src="images/Number%20of%20Rides%20Per%20Day%20for%20each%20User%20Type.png" width="500" height="500"> <img src="images/Average%20Duration%20of%20Rides%20Per%20Day%20for%20each%20User%20Type.png" width="500" height="500">

I found that members were generally using the bikes significantly more on weekdays than on weekends as shown by the greater number of rides in the chart. However, the reverse is true for casual users as the number of rides was greater on the weekends. At the same time, the average duration of each casual user's ride (approximately 3,500 seconds or 58 minutes) was significantly longer than each member's ride (approximately 980 seconds or 16 minutes) across all 7 days.

<br/>
<br/>
<p align="center"> <b>
Weekend and Weekday Data
</b> </p>

<img src="images/Ride%20Start%20Times%20on%20Weekdays.png" width="500" height="500"> <img src="images/Ride%20Start%20Times%20on%20Weekends.png" width="500" height="500">

I decided to create the above 2 graphs by filtering the data by weekends and weekdays separately and comparing the number of rides started at various times of the day. From this, I managed to garner some interesting findings as the results from weekdays and weekends varied greatly. The number of rides started on weekdays by members was significantly higher at 2 timings in the day, namely around 8am and 5pm. As for casual users, the number of rides started slowly increased throughout the day, although the number of rides was significantly fewer than that of the members. This could suggest that a large number of Cyclistic's members are actually using their services to cycle to and from work.

As for the weekends, the number of rides started for both members and casual users were actually very similar and peaked between 1pm to 3pm.

<br/>
<br/>
<p align="center"> <b>
Monthly Data
</b> </p>

<img src="images/Number%20of%20Rides%20Per%20Month%20for%20each%20User%20Type.png" width="500" height="500"> <img src="images/Average%20Duration%20of%20Rides%20Per%20Month%20for%20each%20User%20Type.png" width="500" height="500">

Finally, I analysed the dataset by month and found that number of rides was the greatest around the middle of the year, from June to September. This makes sense as this period is generally when Chicago experiences its summertime. Conversely, the number of rides falls off from December to March, which is aligned with Chicago's wintertime. 

As for the average duration of rides, it remains low for members throughout all months of the year. Surprisingly though, the average duration of rides for casual users is significantly higher in January and February. Although this is coupled with a very small sample size of rides during that period, it is still worth looking into.

Upon further investigation, I found that between January and February, there were hundreds of rides which had ride lengths of more than 10,000 seconds. 31 of these rides even had ride lengths of more than 1,000,000 seconds. Given that the average duration of rides for the rest of the year is around 3,500 seconds and this only occurs in January and February, this is highly unusual. Therefore, Cyclistic should investigate the status of their bicycles during this period in order to gain a clearer picture of the situation.

<br/>
<br/>

## Insights and Recommendations

details

