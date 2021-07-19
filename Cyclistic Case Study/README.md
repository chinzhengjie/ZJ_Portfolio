# Cyclistic Bike-Share Analysis

This is a case study taken from Coursera which I had worked on while undertaking the Google Data Analytics Professional Certificate. All of the original datasets were provided by Coursera and are about a **fictional** company named Cyclistic. The analysis was done in R Programming.

<br/>

## Background

Cyclistic is a bike-share company based in Chicago. They launched a successful bike-share offering in 2016 and since then, the program has grown to a fleet of 5,824 bicycles that are geotracked and locked into a network of 692 stations across Chicago. The bikes can be unlocked from one station and returned to any other station in the system anytime. Cyclistic’s marketing strategy has relied on building general awareness and appealing to broad consumer segments. One approach that helped make these things possible was the flexibility of its pricing plans: single-ride passes, full-day passes, and annual memberships. Customers who purchase single-ride or full-day passes are referred to as **casual** riders. Customers who purchase annual memberships are Cyclistic **members**. Subsequently, Cyclistic’s finance analysts have concluded that annual members are much more profitable than casual riders and they believe that maximizing the number of annual members will be key to future growth.

<br/>

## Approach

The main question of the case study is this: How do annual members and casual riders use Cyclistic bikes differently?

I opted to analyse the data and see what insights I could find.???

As the data was extremely large, I found it easiet to work on the data with R Desktop.

<br/>

## Data Processing and Cleaning

After importing the 4 quarters of data provided (Q2, Q3, Q4 of 2019 and Q1 of 2020), the most important step would be to merge these into 1 large dataset. Thus, the first step was to ensure that each quarter's dataset had consistent headers and consistent data types. I chose to use the most recent quarter, Q1 of 2020, as the reference point for the columns. Furthermore, there were certain columns, such as Longitude, Latitude, Gender, etc., which had data which was no longer tracked by Cyclistic and were not available in the most recent quarter. Thus, after merging the 4 datasets, I removed all the unnecessary columns from the main dataset.

<br/>
 
### Main Dataset
<img src="images/Merged%20Dataset.PNG">

<br/>

Thereafter, I added a few extra useful columns for analysis later.

Next, I found some issues with the data in certain columns. The "member_casual" column had varying names for members and casual users as a result of the dataset originating from different quarters and thus, I standarised this column to only contain "member" and "casual". I also removed negative values from the "ride_length" column, as well as rows which had a start station of "HQ QR" in the "start_station_name" column as these entries were for bikes which were taken out of docks and checked for quality by Cyclistic. 

<br/>

### Cleaned Extra Columns
<img src="images/Extra%20Columns.PNG">

<br/>

## Data Visualisation

### Daily Data
<img src="images/Number%20of%20Rides%20Per%20Day%20for%20each%20User%20Type.png" width="500" height="500"> <img src="images/Average%20Duration%20of%20Rides%20Per%20Day%20for%20each%20User%20Type.png" width="500" height="500">


### Monthly Data
<img src="images/Number%20of%20Rides%20Per%20Month%20for%20each%20User%20Type.png" width="500" height="500"> <img src="images/Average%20Duration%20of%20Rides%20Per%20Month%20for%20each%20User%20Type.png" width="500" height="500">


### Weekend and Weekday Data
<img src="images/Ride%20Start%20Times%20on%20Weekdays.png" width="500" height="500"> <img src="images/Ride%20Start%20Times%20on%20Weekends.png" width="500" height="500">



## Insights and Recommendations

details

