Create Database DM3
use DM3
--drop database DM3

Create Table DimSupplier
(
	supplier_Key int primary Key,
	supplier_Id int,
	other_Supplier_Details varchar(100),
);

Create Table DimPartType
(
	partType_Key int primary key,
	partType_Id int,
	part_Type_Desc varchar(100),
);

Create Table DimCar
(
	car_Key int primary key,
	car_Id int,
	year_Manufacturer int,
	model varchar(20),
	other_Car_details varchar(100),
	car_Manufacturer_code int,
	car_Manufacturer_Name varchar(30),
);

Create Table DimPartManufacturer
(
	partManufacturer_Key int primary key,
	part_Manufacturer_Code int,
	part_Manufacturer_Name varchar(30),
);

Create Table DimPartLevel
(
	partLevel_Key int primary key,
	part_Level_Code int,
	part_Level_Desc varchar(100),
);

Create Table Part_Fact_Table
(
	car_Key int foreign key references [DimCar] (car_Key),
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