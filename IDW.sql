Create Database IDW
use IDW
--drop database IDW

--Dimensions

Create Table [DimCustomer]
(
	customer_Key int primary key,
	cutomer_Id int,
	cell_Num varchar(13),
	email_Address varchar(30),
	other_Customer_Details varchar(100),
	address_Key int,
	[address] varchar(200),
	post_Zip_Code varchar(10),
	other_Address_Details varchar(100),
	town_City varchar(20),
	state_County_Province varchar(20),
	country varchar(20),
);

Create Table [DimCarFeature]
(
	carFeature_Key int primary key,
	car_Feature_Id int,
	car_Feature_Desc varchar(100),
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

Create Table [DimDefect]
(
	defect_Key int primary key, 
	defect_Desc varchar(100), 
	other_Defect_Details varchar(100),
);

Create Table [DimPartManufacturer]
(
	partManufacturer_Key int primary key,
	part_Manufacturer_Code int,
	part_Manufacturer_Name varchar(30),
);

Create Table [DimPartLevel]
(
	partLevel_Key int primary key,
	part_Level_Code int,
	part_Level_Desc varchar(100),
);

Create Table [DimSupplier]
(
	supplier_Key int primary Key,
	supplier_Id int,
	other_Supplier_Details varchar(100),
);

Create Table [DimPartType]
(
	partType_Key int primary key,
	partType_Id int,
	part_Type_Desc varchar(100),
);

Create Table DimManufacturer
(
	manufacturer_Key int identity(1,1) primary key,
	manufacturer_Code int,
	manufacturer_ShortName varchar(10),
	manufacturer_FullName varchar(30),
	other_Manufacturer_Details varchar(100),
);

Create Table DimCarModel
(
	model_Key int identity(1,1) primary key,
	model_Code int,
	model_Name varchar(30),
    manufacturer_Key int,
	other_Model_Details varchar(100),
);

Create Table [DimCar]
(
	car_Key	int primary key,
	license_Num varchar(10),
	customer_Key int,
	current_Mileage float,
	engine_Size varchar(20),
	other_Car_Details varchar(100),
	model_Key int,
);

Create Table [DimCar2]
(
	car_Key int primary key,
	car_Id int,
	year_Manufacturer int,
	model varchar(20),
	other_Car_details varchar(100),
	manufacturer_Key int,
);

Create Table DimVehicle
(
	vehicle_Category_Key int primary key,
	vehicle_Category_Code int,
	vehicle_Category_Desc varchar(100),
);

--Fact Tables
Create Table Car_Fact_Table
(
	manufacturer_Key int foreign key references [DimManufacturer] (manufacturer_Key),
	model_Key int foreign key references [DimCarModel] (model_Key),
	vehicleCategory_Key int foreign key references [DimVehicle] (vehicle_Category_Key),
	time_Key_Acquired int foreign key references [DimTime] (time_Key),
	carFeature_Key int foreign key references [DimCarFeature] (carFeature_Key),
	car_For_Sale_Id_DD int,
	asking_Price money,
	current_Mileage float,
	registration_year int,
	other_Car_Details varchar(100),
	primary key(manufacturer_key,model_Key,vehicleCategory_Key,time_Key_Acquired,carFeature_Key,car_For_Sale_Id_DD),
);

Create Table Customer_Preferences_Fact_Table
(
	carFeature_Key int foreign key references [DimCarFeature] (carFeature_Key),
	customer_Key int foreign key references [DimCustomer] (customer_Key),
	customer_Preferences_Id_DD int,
	primary key(carFeature_Key,customer_Key,customer_Preferences_Id_DD),
	customer_Preferences_Details varchar(100),
);

Create Table Car_Sales_Fact_Table
(
	manufacturer_Key int foreign key references [DimManufacturer] (manufacturer_Key),
	model_Key int foreign key references [DimCarModel] (model_Key),
	vehicleCategory_Key int foreign key references [DimVehicle] (vehicle_Category_Key),
	time_Key_Acquired int foreign key references [DimTime] (time_Key),
	time_Key_Sold int foreign key references [DimTime] (time_Key),
	customer_Key int foreign key references [DimCustomer] (customer_Key),
	car_For_Sale_Id_DD int,
	car_Sold_Id_DD int,
	asking_Price money,
	agreed_Price money,
	current_Mileage float,
	registration_year int,
	other_Car_Details varchar(100),
	primary key(manufacturer_Key,model_Key,vehicleCategory_Key,time_Key_Acquired,time_Key_Sold,customer_Key,car_For_Sale_Id_DD,car_Sold_Id_DD),
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

Create Table Part_Fact_Table
(
	car_Key int foreign key references [DimCar2] (car_Key),
	partLevel_Key int foreign key references [DimPartLevel] (partLevel_Key),
	partManufacturer_Key int foreign key references [DimPartManufacturer] (partManufacturer_Key),
	partType_Key int foreign key references [DimPartType] (partType_Key),
	supplier_Key int foreign key references [DimSupplier] (supplier_Key),
	part_Id_DD int,
	primary key(car_key,partLevel_Key,partManufacturer_Key,partType_Key,supplier_Key,part_Id_DD),
	parent_Part_Id int,
	part_Name varchar(30),
	[weight] int,
	condition varchar(30),
	mileage_Donor_Vehicle float,
	other_Part_Details varchar(100),
);

create Table Parts_By_supplier_Aggregate
(
	Part_key int,
	Supplier_key int,
	PartsCount int
);

create Table Most_Used_Part_types
(
	Part_key int,
	Part_type_Key int,
	Noused int,
)

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

create Table Car_Sales_By_Year_Aggregate_Fact_Table
(
	manufacturer_key int foreign key references [DimManufacturer],
	model_Key int foreign key references [DimCarModel] (model_Key),
	vehicleCategory_Key int foreign key references [DimVehicle] (vehicle_Category_Key),
	Year_Key int,
	total_Sales int,
	primary key(manufacturer_key,model_Key,vehicleCategory_Key,Year_Key),
);