/*
Create TravelDB Database
*/
create database TravelDB;
use TravelDB;

/*
Create Passenger Table
*/
create table if not exists Passenger
(Passenger_Name varchar(20) not null, 
Category varchar(10) default null, 
Gender varchar(01) default null, 
Boarding_City varchar(20) default null, 
Destination_City varchar(20) default null, 
Distance int default 0, 
Bus_Type varchar(20) default null); 

/*
Create Price table
*/
create table Price
(Bus_Type varchar(20) not null, 
Distance int default 0, 
Price int default 0);

/*
Insert values into Passenger table
*/
insert into Passenger values("Sejal", "AC", "F", "Bengaluru", "Chennai", 350, "Sleeper");
insert into Passenger values("Anmol", "Non-AC", "M", "Mumbai", "Hyderabad", 700, "Sitting");
insert into Passenger values("Pallavi", "AC", "F", "Panaji", "Bengaluru", 600, "Sleeper");
insert into Passenger values("Khusboo", "AC", "F", "Chennai", "Mumbai", 1500, "Sleeper");
insert into Passenger values("Udit", "Non-AC", "M", "Trivandrum", "Panaji", 1000, "Sleeper");
insert into Passenger values("Ankur", "AC", "M", "Nagpur", "Hyderabad", 500, "Sitting");
insert into Passenger values("Hemant", "Non-AC", "M", "Panaji", "Mumbai", 700, "Sleeper");
insert into Passenger values("Manish", "Non-AC", "M", "Hyderabad", "Bengaluru", 500, "Sitting");
insert into Passenger values("Piyush", "AC", "M", "Panaji", "Nagpur", 700, "Sitting");

/* 
Insert values into Price table
*/
insert into Price values("Sleeper", 350, 770);
insert into Price values("Sleeper", 500, 1100);
insert into Price values("Sleeper", 600, 1320);
insert into Price values("Sleeper", 700, 1540);
insert into Price values("Sleeper", 1000, 2200);
insert into Price values("Sleeper", 1200, 2640);
insert into Price values("Sleeper", 1500, 2700);
insert into Price values("Sitting", 500, 620);
insert into Price values("Sitting", 600, 744);
insert into Price values("Sitting", 700, 868);
insert into Price values("Sitting", 1000, 1240);
insert into Price values("Sitting", 1200, 1488);
insert into Price values("Sitting", 1500, 1860);

/*
How many females and how many male passengers travelled for a minimum distance of 600 KM s?
*/
select Gender, count(Passenger_Name) as Passenger_Count 
from Passenger 
where Distance >= 600 
group by Gender;

/*
Find the minimum ticket price for Sleeper Bus
*/
select min(Price) as Min_Sleeper_Price 
from price 
where Bus_Type = "Sleeper";

/*
Select passenger names whose names start with character 'S'
*/
select Passenger_name 
from passenger 
where Passenger_Name like "S%";

/*
Calculate price charged for each passenger displaying Passenger name, Boarding City,
Destination City, Bus_Type, Price in the output
*/
select Passenger_Name, Boarding_City, Destination_City, Bus_Type, Price.Price 
from Passenger 
inner join Price using (Bus_Type, Distance);

/*
What are the passenger name/s and his/her ticket price who travelled in the Sitting bus
for a distance of 1000 KM s
*/
select Passenger_Name, Price 
from Passenger 
inner join Price using (Bus_Type, Distance) 
where Bus_Type = "Sitting" 
and Distance >= 1000;

/*
What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to
Panaji?
*/
select Bus_Type, Price 
from Price 
where Distance in (select Distance from Passenger where Passenger_Name = "Pallavi");

/*
List the distances from the "Passenger" table which are unique (non-repeated
distances) in descending order
*/
select distinct Distance 
from Passenger 
order by Distance desc;

/*
Display the passenger name and percentage of distance travelled by that passenger
from the total distance travelled by all passengers without using user variables
*/
select Passenger_Name, (Distance/ (select Sum(Distance) from Passenger) * 100) as Distance_Percent 
from passenger;

/*
Display the distance, price in three categories in table Price
a) Expensive if the cost is more than 1000
b) Average Cost if the cost is less than 1000 and greater than 500
c) Cheap otherwise
*/
select Distance, Price,
	case
		when price > 1000 then "Expensive"
        when price > 500 and price < 1000 then "Average Cost"
        else "Cheap"
	end as Price_Category
from Price;