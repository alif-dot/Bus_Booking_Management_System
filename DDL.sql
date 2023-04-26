Drop database Booking_System
Create database Booking_System
ON
(
Name ='Booking_System_data_1',
FileName = 'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER2016\MSSQL\DATA\Booking_System_data_1.mdf',
Size = 25mb,maxsize = 100mb,Filegrowth = 5%
)
LOG ON
(
Name = 'Booking_System_log_1',
FileName = 'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER2016\MSSQL\DATA\Booking_System_log_1.mdf',
Size = 2mb,maxsize = 5mb,Filegrowth = 1%
)

use Booking_System

create table Bus
(Bus_ID int Primary key not null,
Bus_Name Varchar (30),
Bus_Type Varchar (30),
Seat_No numeric(30)
);
go

create table [Route]
(
Route_ID int primary key not null,
Route_Name varchar(30),
Start_Point varchar (30),
End_Point varchar (30),
UnitPrice numeric(30),
Bus_ID int references Bus (Bus_ID)
);
go

create table [Route_Trigger]
(
Route_ID int primary key not null,
Route_Name varchar(30),
Start_Point varchar (30),
End_Point varchar (30),
UnitPrice numeric(30),
Bus_ID int references Bus (Bus_ID),
Activity varchar(10),
DoneBy varchar(20),
ActivityTime datetime,
);
go

create table Schedule
(
Schedule_ID int primary key,
Departure_Time datetime,
Arrive_Time datetime,
Bus_ID int references Bus(Bus_ID),
Route_ID int references [Route](Route_ID)
);
go

create table [Booking]
(
BookingI_ID int primary key not null,
Customer_Name varchar (30),
Customer_Mobile numeric (30),
Booked_Date datetime,
Booked_Status varchar(255),
Price numeric(8,2),
Cancel_Date datetime,
Return_Amount numeric(8,2),
Return_Status varchar(255),
Bus_ID int references Bus(Bus_ID),
Schedule_ID int references  Schedule(Schedule_ID)
);
go

Create table BookingDetails
(
BookingDetails_ID int primary key not null,
CustomerName varchar (30),
CustomerMobile varchar (30),
BookingI_ID int references [Booking](BookingI_ID ),
Bus_ID int references Bus (Bus_ID ),
Schedule_ID int  references Schedule(Schedule_ID),
);
go

Create table ScheduleDetails
(
ScheduleDetails_ID int primary key not null,
Bus_ID int references Bus(Bus_ID),
Schedule_ID int  references Schedule (Schedule_ID)
);
go

create table Bus_merge
(Bus_ID int Primary key not null,
Bus_Name Varchar (30),
Bus_Type Varchar (30),
Seat_No numeric(30)
);

------------MERGE------------
MERGE INTO Bus AS b
USING Bus_merge AS bs
        ON b.Bus_ID = bs.Bus_ID
WHEN MATCHED THEN
    UPDATE SET
      b.Bus_Name = bs.Bus_Name,
      b.Bus_Type = bs.Bus_Type,
	  b.Seat_No = bs.Seat_No
      WHEN NOT MATCHED THEN 
      INSERT (Bus_ID, Bus_Name,Bus_Type, Seat_No)
      VALUES (bs.Bus_ID, bs.Bus_Name, bs.Bus_Type,bs.Seat_No);

	------------CTE------------
	WITH CTE_Booking_Time (BookingI_ID,
             Customer_Name,
             Customer_Mobile,
             Booked_Date,
             Booked_Status,
             Price,
             Cancel_Date,
             Return_Amount,
             Return_Status,
             Bus_ID,
             Schedule_ID,BookedDate) AS (
    SELECT    
         b.Customer_Name + ' ' + b.Customer_Mobile, 
		 b.Booked_Date,
         b.Booked_Status,
         b.Price,
         b.Cancel_Date,
         b.Return_Amount,
         b.Return_Status,
         b.Bus_ID,
         b.Schedule_ID,
		GETDATE(),
        YEAR(GETDATE()) - YEAR(b.Booked_Date)
    FROM Booking b
)
SELECT
             Customer_Name,
             Booked_Date,
             Booked_Status,
             Price,
             Cancel_Date,
             Return_Amount,
             Return_Status,
             Bus_ID,
             Schedule_ID,BookedDate
FROM 
    CTE_Booking_Time
WHERE
    BookedDate <= 5;

	------------Trigger------------
	CREATE TRIGGER Trg_Employee
ON Employee
AFTER UPDATE, INSERT, DELETE
AS
DECLARE 
@Route_ID int,
@Route_Name varchar,
@Start_Point varchar,
@End_Point varchar,
@UnitPrice numeric,
@Bus_ID int,
@Activity varchar,
@DoneBy varchar,
@user varchar(20);

--UPDATE
IF EXISTS(SELECT * FROM inserted) and exists (SELECT * FROM deleted)
BEGIN
    SET @activity = 'UPDATE';
    SET @user = SYSTEM_USER;
    SELECT @Route_ID = u.RouteID, @Route_Name = u.RouteName, @Start_Point = u.StartPoint,@End_Point=u.EndPoint,
	@UnitPrice = u.UnitPrice, @Bus_ID = u.Bus_ID FROM inserted u;
    INSERT INTO Route_Trigger(
	@Route_ID,@Route_Name,@Start_Point,@End_Point,@UnitPrice,@Bus_ID,@Activity,@DoneBy,@user)
	VALUES(@Route_ID,@Route_Name,@Start_Point,@End_Point,@UnitPrice,@Bus_ID,@Activity,@DoneBy,@user,GETDATE());
	PRINT('Trigger fired after UPDATE');
END

--INSERT
IF exists (SELECT * FROM inserted) AND NOT EXISTS(SELECT * FROM deleted)
BEGIN
    SET @activity = 'INSERT';
    SET @user = SYSTEM_USER;
    SELECT @Route_ID = I.RouteID, @Route_Name = I.RouteName, @Start_Point = I.StartPoint,@End_Point=I.EndPoint,
	@UnitPrice = I.UnitPrice, @Bus_ID = I.Bus_ID FROM inserted I;
    INSERT INTO Route_Trigger(
	@Route_ID,@Route_Name,@Start_Point,@End_Point,@UnitPrice,@Bus_ID,@Activity,@DoneBy,@user)
	VALUES(@Route_ID,@Route_Name,@Start_Point,@End_Point,@UnitPrice,@Bus_ID,@Activity,@DoneBy,@user,GETDATE());
	PRINT('Trigger fired after UPDATE');
END

---------DELETE-----
IF EXISTS(select * from deleted) AND NOT EXISTS(SELECT * FROM inserted)
BEGIN
    SET @activity = 'DELETE';
    SET @user = SYSTEM_USER;
    SELECT @Route_ID = d.RouteID, @Route_Name = d.RouteName, @Start_Point = d.StartPoint,@End_Point=d.EndPoint,
	@UnitPrice = d.UnitPrice, @Bus_ID = d.Bus_ID FROM inserted d;
    INSERT INTO Route_Trigger(
	@Route_ID,@Route_Name,@Start_Point,@End_Point,@UnitPrice,@Bus_ID,@Activity,@DoneBy,@user)
	VALUES(@Route_ID,@Route_Name,@Start_Point,@End_Point,@UnitPrice,@Bus_ID,@Activity,@DoneBy,@user,GETDATE());
	PRINT('Trigger fired after UPDATE');
END
GO

------View-------

create view VView as select customername,CustomerMobile,Bus_name,Bus_type,start_point,End_point,SUM(unitprice) AS PRICE,Arrive_Time
from BookingDetails bd
join Booking b
on bd.BookingI_ID= b.BookingI_ID
join Bus bs
on bd.Bus_ID= b.Bus_ID
join Route r
on bd.route_id = r.Route_ID
join Schedule s
on bd.Schedule_ID = s.Schedule_ID
where bus_name in(select bus_name from bus where Bus_Name ='Hanif Enterprise')
group by customername,CustomerMobile,Bus_name,Bus_type,start_point,End_point,Arrive_Time
having SUM(unitprice)>500

select * from Vview 

--------Table value function------
	  create function fn_bus()
	  returns Table
	  return
	  (
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
      where bus_name in(select bus_name from bus where Bus_Name ='Hanif Enterprise')
      group by customername,CustomerMobile,Bus_name,Bus_type,start_point,End_point,Arrive_Time
      having SUM(unitprice)>500
      );

select * from fn_bus();

-------Scalar value function------
Create function Fn_bus1()
Returns int 
AS
BEGIN
declare @bus int;
select @bus = select CustomerName,CustomerMobile,Bus_name,Bus_type,start_point,End_point,SUM(unitprice) AS PRICE,Arrive_Time
from BookingDetails bd
join Booking b
on bd.BookingI_ID= b.BookingI_ID
join Bus bs
on bd.Bus_ID= b.Bus_ID
join Route r
on bd.route_id = r.Route_ID
join Schedule s
on bd.Schedule_ID = s.Schedule_ID
where bus_name in(select bus_name from bus where Bus_Name ='Nabil Paribahan')
group by customername,CustomerMobile,Bus_name,Bus_type,start_point,End_point,Arrive_Time
having SUM(unitprice)>500
return @bus;
END;

-------store procedure------

------SP insert------
Create proc SP_insertbus
@Bus_ID int,
@Bus_name varchar (30),
@bus_type varchar(30),
@seat_no Numeric (30)
as
insert into Bus (Bus_ID ,Bus_Name,Bus_Type,Seat_No )
values(@Bus_ID,@Bus_name,@bus_type,@seat_no )

-------sp update-----

Create proc SP_updatebus
@Bus_ID int,
@Bus_name varchar (30),
@bus_type varchar(30),
@seat_no Numeric (30)
as
update bus set Bus_name =@Bus_name where Bus_ID=@Bus_ID

--------sp delete------

Create proc SP_deletebus
@Bus_ID int,
@Bus_name varchar (30),
@bus_type varchar(30),
@seat_no Numeric (30)
as
delete from bus where Bus_ID =@Bus_ID 