Create Database DM2
use DM2
--drop database DM2

Create Table [DimCar]
(
	car_Key	int primary key,
	license_Num varchar(10),
	customer_Key int,
	current_Mileage float,
	engine_Size varchar(20),
	other_Car_Details varchar(100),
	model_Key int,
	model_Code int,
	model_Name varchar(20),
	other_Model_Details varchar(100), 
	manufacturer_Key int,
	manufacturer_Code int,
	manufacturer_Name varchar(20),
	other_Manufacturer_Details varchar(100),
);

Create Table [DimPart]
(
	part_Key int primary key,
	part_Id int,
	part_Name varchar(20),
	part_Desc varchar(100),
	other_Part_Details varchar(100),
);

Create Table [DimMechanic]
(
	mechanic_Key int primary key,
	mechanic_Id int,
	mechanic_Name varchar(20),
	other_Mechanic_Details varchar(100),
);

Create Table [DimContact]
(
	contact_Key int primary key,
	contact_Id int,
	first_Name varchar(30), 
	last_Name varchar(20), 
	gender varchar(10), 
	email_Address varchar(30), 
	phone_Num varchar(13), 
	[address] varchar(200), 
	town_City varchar(20), 
	State_County_Province varchar(20), 
	country varchar(10), 
	other_Contact_Details varchar(100),
);

Create Table [DimYear]
(
	year_Key int primary key, 
	year_Id varchar(2), 
	year_Desc varchar(20),
);

Create Table [DimQuarter]
(
	quarter_Key int primary key, 
	quarter_Id varchar(2), 
	quarter_Desc varchar(20),
	year_Key int foreign key references	[DimYear] (year_Key),
);

Create Table [DimMonth]
(
	month_Key int primary key, 
	month_Id varchar(2), 
	month_Desc varchar(20),
	quarter_Key int foreign key references	[DimQuarter] (quarter_Key),
);

Create Table [DimTime]
(
	time_Key int primary key, 
	day_Id varchar(2), 
	day_Desc varchar(20), 
	month_Key int foreign key references [DimMonth] (month_Key),
);


Create Table [DimDefect]
(
	defect_Key int primary key, 
	defect_Desc varchar(100), 
	other_Defect_Details varchar(100),
);

Create Table [Service_Part_Fact_Table]
(
	car_Key int foreign key references [DimCar] (car_Key), 
	contact_Key int foreign key references [DimContact] (contact_Key), 
	part_Key int foreign key references [DimPart] (part_Key), 
	time_Key int foreign key references [DimTime] (time_Key), 
	booking_Id_DD int not null, 
	booking_Details varchar(100), 
	part_Stock int,
	primary key (car_key,contact_Key,part_key,time_Key,booking_id_DD),
);

Create Table [Service_Mechanic_Fact_Table]
(
	car_Key int foreign key references [DimCar] (car_Key), 
	contact_Key int foreign key references [DimContact] (contact_Key), 
	mechanic_Key int foreign key references [DimMechanic] (mechanic_Key), 
	time_Key int foreign key references [DimTime] (time_Key), 
	booking_Id_DD int not null, 
	booking_Details varchar(100), 
	primary key (car_key,contact_Key,mechanic_Key,time_Key,booking_id_DD),
);

Create Table [Contact_Car_Visit_Fact_Table]
(
	contact_Key int foreign key references [DimContact] (contact_Key), 
	year_Key int foreign key references	[DimYear] (year_Key),
	t_Cars int,
	primary key (contact_Key,year_Key),
);


Create Table [Defect_Fact_Table]
(
	car_Key int foreign key references [DimCar] (car_Key), 
	time_Key int foreign key references [DimTime] (time_Key), 
	defect_Key int foreign key references [DimDefect] (defect_Key),
	primary key (car_Key, time_Key, defect_Key),
);
	
create table [PartsUsed_Aggregate_FactTable]
(
	Part_key int,
	Booking_id_DD int,
	Most_used int
);

create table [issues_By_Year_Aggregate_FactTable]
(
	year_Key int,
	car_key int,
	issue_count int
);
