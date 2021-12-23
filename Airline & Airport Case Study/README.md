# Cyclistic Bike-Share Analysis

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

<p align="center"> <b>
Main Dataset
</b> </p>

<p align="center">
<img src="images/Merged%20Dataset.PNG">
</p>

<br/><br/>

Thereafter, I added a few extra columns to aid the analysis.

Next, I found some issues with the data in certain columns. The "member_casual" column had varying names for members and casual users as a result of the dataset originating from different quarters and thus, I standarised this column to only contain "member" and "casual". I also removed negative values from the "ride_length" column, as well as rows which had a start station of "HQ QR" in the "start_station_name" column as these entries were for bikes which were taken out of docks and checked for quality by Cyclistic. 

<br/><br/>

<p align="center"> <b>
Cleaned Extra Columns
</b> </p>
