Create Database DM1
use DM1
--drop database DM1

Create Table DimCustomer
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

Create Table DimCarFeature
(
	carFeature_Key int primary key,
	car_Feature_Id int,
	car_Feature_Desc varchar(100),
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

Create Table DimCarModel
(
	model_Key int primary key,
	model_Code int,
	model_Name varchar(30),
	manufacturer_Code int,
);

Create Table DimVehicle
(
	vehicle_Category_Key int primary key,
	vehicle_Category_Code int,
	vehicle_Category_Desc varchar(100),
);

Create Table DimManufacturer
(
	manufacturer_Key int primary key,
	manufacturer_ShortName varchar(10),
	manufacturer_FullName varchar(30),
	other_Manufacturer_Details varchar(100),
);

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

create Table Car_Sales_By_Year_Aggregate_Fact_Table
(
	manufacturer_key int foreign key references [DimManufacturer],
	model_Key int foreign key references [DimCarModel] (model_Key),
	vehicleCategory_Key int foreign key references [DimVehicle] (vehicle_Category_Key),
	car_Sold_Id_DD int,
	Year_Key int,
	total_Sales int,
	primary key(manufacturer_key,model_Key,vehicleCategory_Key,car_Sold_Id_DD,Year_Key),
);