create table Pieces (
	Code Integer Primary Key NOT NULL,
	Name Varchar(25) NOT NULL
);

create table Providers (
	Code Varchar(10) Primary Key NOT NULL,
	Name varchar(25) NOT NULL
);

create table Provides (
	Piece Integer,
	constraint fk_Pieces_Code Foreign Key(Piece) References Pieces(Code),
	Provider Varchar(10),
	constraint fk_Providers_Code Foreign Key(Provider) References Providers(Code),
	Price Integer NOT NULL,
	Primary Key(Piece, Provider)
);

INSERT INTO Providers(Code, Name) VALUES('HAL','Clarke Enterprises');
INSERT INTO Providers(Code, Name) VALUES('RBT','Susan Calvin Corp.');
INSERT INTO Providers(Code, Name) VALUES('TNBC','Skellington Supplies');


INSERT INTO Pieces(Code, Name) VALUES(1,'Sprocket');
INSERT INTO Pieces(Code, Name) VALUES(2,'Screw');
INSERT INTO Pieces(Code, Name) VALUES(3,'Nut');
INSERT INTO Pieces(Code, Name) VALUES(4,'Bolt');


INSERT INTO Provides(Piece, Provider, Price) VALUES(1,'HAL',10);
INSERT INTO Provides(Piece, Provider, Price) VALUES(1,'RBT',15);
INSERT INTO Provides(Piece, Provider, Price) VALUES(2,'HAL',20);
INSERT INTO Provides(Piece, Provider, Price) VALUES(2,'RBT',15);
INSERT INTO Provides(Piece, Provider, Price) VALUES(2,'TNBC',14);
INSERT INTO Provides(Piece, Provider, Price) VALUES(3,'RBT',50);
INSERT INTO Provides(Piece, Provider, Price) VALUES(3,'TNBC',45);
INSERT INTO Provides(Piece, Provider, Price) VALUES(4,'HAL',5);
INSERT INTO Provides(Piece, Provider, Price) VALUES(4,'RBT',7);

-- 1. Select the name of all the pieces
		select Name from Pieces;

-- 2. Select all the providers' data. 
		select * from Providers;

-- 3. Obtain the average price of each piece 
		select Piece, avg(Price) as avg_price
		from Provides
		group by Piece;

-- 4. Obtain the names of all providers who supply piece 1. 
		select Name 
		from Providers
		where Code In (
				select Provider
				from Provides
				where Piece = 1
			);

		select Providers.Name 
		from Providers Right Join Provides
		On Providers.Code = Provides.Provider
		where Provides.Piece = 1;

-- 5. Select the name of pieces provided by provider with code "HAL". 
		select Name 
		from Pieces 
		where Code In (
				select Piece 
				from Provides
				where Provider = "HAL"
			);

		select Precies.Name
		from Pieces inner join Provides
		on Pieces.Code = Provides.Piece
		where Provides.Provider = "HAL";

		select Name
   		from Pieces
   		where EXISTS
   			(
     			select * from Provides
       			where Provider = 'HAL'
         		and Piece = Pieces.Code
   			);

 -- 6. For each piece, find the most expensive offering of that piece and include the piece name, 
 -- provider name, and price 
 -- (note that there could be two providers who supply the same piece at the most expensive price).
		select Pieces.Name, Providers.Name, Price
		from Provides inner join Pieces on Provides.Piece = Pieces.Code
					  inner join Providers on Provides.Provider = Providers.Code
		where Price = (
			select max(Price)
			from Provides
			where Piece = Pieces.Code
			);	

-- 7. Add an entry to the database to indicate that "Skellington Supplies" (code "TNBC") 
-- will provide sprockets (code "1") for 7 cents each. 
		insert into Provides(Piece, Provider, Price) values(1, "TNBC", 7);

-- 8. Increase all prices by one cent. 
		update Provides
			set Price = Price * 1.01;

-- 9. Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply bolts (code 4).

		delete from Provides
			where Provider = "RBT" and Piece = 4;

-- 10. Update the database to reflect that "Susan Calvin Corp." 
-- (code "RBT") will not supply any pieces (the provider should still remain in the database).
		delete from Provides
			where Provider = "RBT";