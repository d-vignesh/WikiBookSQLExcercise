
-- TABLE CREATION:

CREATE TABLE Manufacturers (
	Code INTEGER,
	Name VARCHAR(25) NOT NULL,
	PRIMARY KEY (Code)
);


CREATE TABLE Products (
	Code INTEGER,
	Name VARCHAR(25) NOT NULL,
	Price DECIMAL NOT NULL,
	Manufacturer INTEGER NOT NULL,
	PRIMARY KEY (Code),
	FOREIGN KEY (Manufacturer) REFERENCES Manufacturers(Code)
) ENGINE=INNODB;

-- engine describe the storage engine for the table.


INSERTING VALUES:

INSERT INTO Manufacturers(Code, Name) VALUES(1, 'Sony');
INSERT INTO Manufacturers(Code, Name) VALUES(2, 'Creative Labs');
INSERT INTO Manufacturers(Code, Name) VALUES(3, 'Hewlett-Packard');
INSERT INTO Manufacturers(Code, Name) VALUES(4, 'Iomega');
INSERT INTO Manufacturers(Code, Name) VALUES(5, 'Fujitsu');
INSERT INTO Manufacturers(Code, Name) VALUES(6, 'Winchester');


INSERT INTO Products(Code, Name, Price, Manufacturer) VALUES(1, 'Hard Drive', 240, 5);
INSERT INTO Products(Code, Name, Price, Manufacturer) VALUES(2, 'Memory', 120, 6);
INSERT INTO Products(Code, Name, Price, Manufacturer) VALUES(3, 'ZIP drive', 150, 4);
INSERT INTO Products(Code, Name, Price, Manufacturer) VALUES(4, 'Floppy disk', 5, 6);
INSERT INTO Products(Code, Name, Price, Manufacturer) VALUES(5, 'Monitor', 240, 1);
INSERT INTO Products(Code, Name, Price, Manufacturer) VALUES(6, 'DVD drive', 180, 2);
INSERT INTO Products(Code, Name, Price, Manufacturer) VALUES(7, 'CD drive', 90, 2);
INSERT INTO Products(Code, Name, Price, Manufacturer) VALUES( 8, 'Printer', 270, 3);
INSERT INTO Products(Code, Name, Price, Manufacturer) VALUES(9, 'Toner cartridge', 66, 3);
INSERT INTO Products(Code, Name, Price, Manufacturer) VALUES(10, 'DVD burner', 180, 2);


-- QUESTIONS:

-- 1. Select the names of all the products in the store
		select Name from Products;

-- 2. Select the names and the prices of all the products in the store.
		select Name, Price from Products;

-- 3. Select the name of the products with a price less than or equal to $200. 
		select Name from Products where Price <= 200;

-- 4. Select all the products with a price between $60 and $120. 
		select Name from Products where Price >=60 and Price <= 120;
		select Name from Products where Price between 60 and 120;

-- 5. Select the name and price in cents (i.e., the price must be multiplied by 100). 
		select Name, Price * 100 from Products;
		select Name, Price * 100 as PriceCents from Products;

-- 6. Compute the average price of all the products.
		select avg(Price) from Products;

-- 7. Compute the average price of all products with manufacturer code equal to 2. 
		select avg(Price) from Products where Manufacturer = 2;

-- 8. Compute the number of products with a price larger than or equal to $180. 
		select count(*) as count from Products where Price >= 180;

-- 9. Select the name and price of all products with a price larger than or equal to $180, and sort first by price (in descending order), and then by name (in ascending order). 
		select Name, Price 
		from Products 
		where Price >= 180 
		order by Price DESC, Name;

-- 10. Select all the data from the products, including all the data for each product's manufacturer. 
		select * from Products, Manufacturers where Products.Manufacturer = Manufacturers.Code;
		
		select * 
		from Products inner join Manufacturers 
		on Products.Manufacturer = Manufacturers.Code;

-- 11. Select the product name, price, and manufacturer name of all the products.
		select Products.Name, Products.Price, Manufacturers.Name 
		from Products inner join Manufacturers 
		on Products.Manufacturer = Manufacturers.Code;

-- 12. Select the average price of each manufacturer's products, showing only the manufacturer's code. 
		select avg(Price) as AvgPrice, Manufacturer 
		from Products 
		group by Manufacturer;

-- 13. Select the average price of each manufacturer's products, showing the manufacturer's name. 
		select avg(Products.Price) as AvgPrice, Manufacturers.Name
		from Products inner join Manufacturers
		on Products.Manufacturer = Manufacturers.Code
		group by Manufacturers.Name
		order by AvgPrice;

-- 14. Select the names of manufacturer whose products have an average price larger than or equal to $150.
		select avg(Products.Price) as AvgPrice, Manufacturers.Name
		from Products inner join Manufacturers
		on Products.Manufacturer = Manufacturers.Code
		group by Manufacturers.Name
		Having AvgPrice >= 150
		order by AvgPrice;
-- using order by before having gives error

-- 15. Select the name and price of the cheapest product.
		select Name, Price 
		from Products
		order by Price ASC
		Limit 1;

		select Name, Price
		from Products
		where Price = (select min(Price) from Products);
		-- if there are two min values nested select will return both

-- 16. Select the name of each manufacturer along with the name and price of its most expensive product. 
		select P.Name, P.Price, M.Name
		from Products P inner join Manufacturers M
		on P.Manufacturer = M.Code 
		and P.Price = (
				select max(P.Price)
				from Products P
				where P.Manufacturer = M.Code
			)

-- 17. Add a new product: Loudspeakers, $70, manufacturer 2
		insert into Products(Code, Name, Price, Manufacturer) values(11, 'LoudSpeakers', 70, 2);

-- 18. Update the name of product 8 to "Laser Printer".
		update Products
			set Name = "Laser Printer"
			where Code = 8;

-- 19. Apply a 10% discount to all products. 
		update Products
			set Price = Price - (Price * 0.1);

-- 20. Apply a 10% discount to all products with a price larger than or equal to $120. 
		update Products
			set Price = Price - (Price * 0.1)
			where Price >= 120;
			