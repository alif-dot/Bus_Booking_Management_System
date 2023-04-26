
Use Booking_System

--------insert into --------------
insert into [Bus](Bus_ID,Bus_Name,Bus_Type,Seat_No) values 
                                                 (1,'Alif Paribahan','Non AC',30),
                                                 (2,'Azmiri Enterprise','Non AC',30),
												 (3,'Nabil Paribahan','Non AC',30),
												 (4,'Hanif Enterprise','AC',20),
												 (5,'Abir Express','AC',20),
												 (6,'Green Line','AC',20);
go

insert into [Route](Route_ID,Route_Name,Start_Point,End_Point,UnitPrice,Bus_ID)
values (1,'Dhaka to Bhola','Kollanpur','Bhola Sadar',500,1),
       (2,'Dhaka to khulna','Gabtoli','Sonadanga',500,2),
	   (3,'Dhaka to Rangpur','Kollanpur','Kamar para',500,3),
	   (4,'Dhaka to Kustia','Mohakhli','Mozompur',1000,4),
	   (5,'Dhaka to Sylhet','Sayedabad','Kadomtoly',1000,5),
	   (6,'Dhaka to Chattogram','Kolabagan','A K Khan',1000,6)
go

insert into Schedule(Schedule_ID,Departure_Time,Arrive_Time,Bus_ID,Route_ID) 
values (01,'01-02-2020','01-02-2020',1,1),
       (02,'02-02-2020','02-02-2020',2,2),
       (03,'03-02-2020','03-02-2020',3,3),
       (04,'04-02-2020','04-02-2020',4,4),
       (05,'05-02-2020','05-02-2020',5,5),
       (06,'06-02-2020','06-02-2020',6,6);
go

insert into Booking(Booking_ID,Customer_Name,Customer_Mobile,Booked_Date,Price,Bus_ID,Schedule_ID)
values (1,'Easin Alif',01860049794,'01-20-2020',500,1,1),
       (2,'Abidur Rahman',0940228721,'01-21-2020',500,2,2),
       (3,'Adnan Sumon',09882726776,'01-22-2020',500,3,3),
       (4,'Rashed Riman',0927662636,'01-23-2020',1000,4,4),
       (5,'AHM Rasel',0964654365,'01-24-2020',1000,5,5),
       (6,'Jahidul Hasan',0935316516,'01-21-2020',1000,6,6)
go

insert into BookingDetails(BookingDetails_ID,CustomerName,CustomerMobile,Booking_ID,Bus_ID,Route_ID,Schedule_ID)
values (1,'Easin Alif',01860049794,1,1,1,1),
       (2,'Abidur Rahman',0940228721,2,2,2,2),
	   (3,'Adnan Sumon',09882726776,3,3,3,3),
	   (4,'Rashed Riman',0927662636,4,4,4,4),
	   (5,'AHM Rasel',0964654365,5,5,5,5),
	   (6,'Jahidul Hasan',0935316516,6,6,6,6)
go

insert into ScheduleDetails(ScheduleDetails_ID,Bus_ID,Schedule_ID)
values (1,1,1),
       (2,2,2),
	   (3,3,3),
	   (4,4,4),
	   (5,5,5),
	   (6,6,6)
go

select * from Bus
select * from [Route]
select * from Booking
select * from BookingDetails
select * from Schedule
select * from ScheduleDetails

-----Join--------
select CustomerName,CustomerMobile,Bus_name,Bus_type,start_point,End_point,unitprice,Arrive_Time
from BookingDetails bd
join Booking b
on bd.BookingI_ID= b.BookingI_ID
join Bus bs
on bd.Bus_ID= b.Bus_ID
join Route r
on bd.route_id = r.Route_ID
join Schedule s
on bd.Schedule_ID = s.Schedule_ID
where Customer_Name='Easin Alif'


--------having subquery-------
select customername,CustomerMobile,Bus_name,Bus_type,start_point,End_point,SUM(unitprice) AS PRICE,Arrive_Time
from BookingDetails bd
join Booking b
on bd.BookingI_ID= b.BookingI_ID
join Bus bs
on bd.Bus_ID= b.Bus_ID
join Route r
on bd.route_id = r.Route_ID
join Schedule s
on bd.Schedule_ID = s.Schedule_ID
where bus_name in(select bus_name from bus where Bus_Name ='hanif enterprise')
group by customername,CustomerMobile,Bus_name,Bus_type,start_point,End_point,Arrive_Time
having SUM(unitprice)>500


	  -----CASE FUNCTION----
 SELECT Bus.Bus_Name,
case 
when Bus.bus_name='Green Line' then 'Alif paribahan'
when bus.Bus_Name='Ena paribahan' then 'saint martin'
else 'Hanif Enterprise'
End AS Comments
from BookingDetails join Bus 
on BookingDetails .Bus_ID =bus.Bus_ID 