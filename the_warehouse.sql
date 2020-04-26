
create table Warehouses (
	Code Integer,
	Location Varchar(25) NOT NULL,
	Capacity Integer NOT NULL,
	Primary Key(Code)
);

create table Boxes (
	Code Varchar(10),
	Contents Varchar(25) NOT NULL,
	Value Decimal NOT NULL,
	Warehouse Integer,
	Primary key(Code),
	Foreign key(Warehouse) References Warehouses(Code)
);


INSERT INTO Warehouses(Code,Location,Capacity) VALUES(1,'Chicago',3);
INSERT INTO Warehouses(Code,Location,Capacity) VALUES(2,'Chicago',4);
INSERT INTO Warehouses(Code,Location,Capacity) VALUES(3,'New York',7);
INSERT INTO Warehouses(Code,Location,Capacity) VALUES(4,'Los Angeles',2);
INSERT INTO Warehouses(Code,Location,Capacity) VALUES(5,'San Francisco',8);

INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('0MN7','Rocks',180,3);
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('4H8P','Rocks',250,1);
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('4RT3','Scissors',190,4);
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('7G3H','Rocks',200,1);
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('8JN6','Papers',75,1);
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('8Y6U','Papers',50,3);
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('9J6F','Papers',175,2);
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('LL08','Rocks',140,4);
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('P0H6','Scissors',125,1);
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('P2T6','Scissors',150,2);
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('TU55','Papers',90,5);


-- 1. Select all warehouses. 
		select * from Warehouses;

-- 2. Select all boxes with a value larger than $150. 
		select * from Boxes where Value > 150;

-- 3. Select all distinct contents in all the boxes. 
		select distinct(Contents) from Boxes;

-- 4. Select the average value of all the boxes.
		select avg(Value) from Boxes;

-- 5. Select the warehouse code and the average value of the boxes in each warehouse. 
		select Warehouse, avg(Value) as avg_value
		from Boxes
		group by Warehouse;

-- 6. Same as previous exercise, but select only those warehouses where the average value of the boxes is greater than 150. 
		select Warehouse, avg(Value) as avg_value
		from Boxes
		group by Warehouse
		having avg_value > 150;

-- 7. Select the code of each box, along with the name of the city the box is located in. 
		select B.Code, W.Location
		from Boxes B inner join Warehouses W
		on B.Warehouse = W.Code;

-- 8. Select the warehouse codes, along with the number of boxes in each warehouse. 
-- Optionally, take into account that some warehouses are empty 
-- (i.e., the box count should show up as zero, instead of omitting the warehouse from the result). 
		select Warehouse, count(Code) as box_count
		from Boxes
		group by Warehouse;

		select Warehouses.Code, count(Boxes.Code) as box_count
		from Warehouses Left join Boxes
		on Warehouses.Code = Boxes.Warehouse
		group by Warehouses.Code;

-- 9. Select the codes of all warehouses that are saturated 
-- (a warehouse is saturated if the number of boxes in it is larger than the warehouse's capacity).
		select Warehouses.Code , Warehouses.Capacity
		from Warehouses inner join Boxes
		on Warehouses.Code = Boxes.Warehouse
		group by Warehouses.Code
		having count(Boxes.Code) > Warehouses.Capacity;

		select Code 
		from Warehouses
		where Capacity < (
				select count(*)
				from Boxes
				where Warehouse = Warehouses.Code
			)

-- 10. Select the codes of all the boxes located in Chicago. 
		select Code 
		from Boxes 
		where Warehouse in (
			select Code 
			from Warehouses
			where Location = "Chicago"
			)

		select Boxes.Code
		from Boxes right join Warehouses
		on Boxes.Warehouse = Warehouses.Code
		where Warehouses.Location = "Chicago";

-- 11. Create a new warehouse in New York with a capacity for 3 boxes.
		insert into Warehouses(Code, Location, Capacity) values(6, "New York", 3);

-- 12. Create a new box, with code "H5RT", containing "Papers" with a value of $200, and located in warehouse 2. 
		insert into Boxes(Code, Contents, Value, Warehouse) values ("H5RT", "Papers", 200, 2);

-- 13. Reduce the value of all boxes by 15%.
		update Boxes
			set Value = Value - (Value * 0.15);

-- 14. Apply a 20% value reduction to boxes with a value larger than the average value of all the boxes. 
        update Boxes
        	set Value = Value * 0.20
        	where Value > ( select avg(Value) from Boxes);

-- 15. Remove all boxes with a value lower than $100. 
		delete from Boxes
			where Value < 100;

-- 16. Remove all boxes from saturated warehouses. 
		delete from Boxes
			where Warehouse in (
					select Code 
					from Warehouses
					where capacity < (
							select count(Code)
							from Boxes
							where Warehouse = Warehouses.Code
						)
				);