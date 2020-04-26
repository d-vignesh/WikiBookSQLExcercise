create table Employee(
	EmployeeID Integer Primary Key NOT NULL,
	Name varchar(50) NOT NULL,
	Position varchar(50) NOT NULL,
	Salary real NOT NULL,
	Remarks varchar(250) 
);

create table Planet(
	PlanetID Integer Primary Key NOT NULL,
	Name varchar(50) NOT NULL,
	Coordinates real NOT NULL
);

create table Has_Clearance(
	Employee Integer NOT NULL,
	constraint fk_Employee_EmployeeID Foreign Key(Employee) References Employee(EmployeeID),
	Planet Integer NOT NULL,
	constraint fk_Planet_PlanetID Foreign Key(Planet) References Planet(PlanetID),
	Level Integer NOT NULL,
	Primary Key(Employee, Planet)
);

create table Shipment(
	ShipmentID Integer Primary Key NOT NULL,
	Date varchar(15),
	Manager Integer NOT NULL,
	constraint fks_Employee_EmployeeID Foreign Key(Manager) References Employee(EmployeeID),
	Planet Integer NOT NULL,
	constraint fks_Planet_PlanetID Foreign Key(Planet) References Planet(PlanetID)
);

create table Client(
	AccountNumber Integer Primary Key NOT NULL,
	Name varchar(50) NOT NULL
);

create table Package(
	Shipment Integer NOT NULL,
	constraint fk_Shipment_ShipmentID Foreign Key(Shipment) References Shipment(ShipmentID),
	PackageNumber Integer NOT NULL,
	Contents Varchar(50) NOT NULL,
	Weight Real NOT NULL,
	Sender Integer NOT NULL,
	constraint fks_Client_AccountNumber Foreign Key(Sender) References Client(AccountNumber),
	Recipient Integer NOT NULL,
	constraint fkc_Client_AccountNumber Foreign Key(Recipient) References Client(AccountNumber),
	Primary Key(Shipment, PackageNumber)
);


INSERT INTO Client VALUES(1, "Zapp Brannigan");
INSERT INTO Client VALUES(2, "Al Gore's Head");
INSERT INTO Client VALUES(3, "Barbados Slim");
INSERT INTO Client VALUES(4, "Ogden Wernstrom");
INSERT INTO Client VALUES(5, "Leo Wong");
INSERT INTO Client VALUES(6, "Lrrr");
INSERT INTO Client VALUES(7, "John Zoidberg");
INSERT INTO Client VALUES(8, "John Zoidfarb");
INSERT INTO Client VALUES(9, "Morbo");
INSERT INTO Client VALUES(10, "Judge John Whitey");
INSERT INTO Client VALUES(11, "Calculon");

INSERT INTO Employee VALUES(2, 'Turanga Leela', 'Captain', 10000.0, NULL);
INSERT INTO Employee VALUES(3, 'Bender Bending Rodriguez', 'Robot', 7500.0, NULL);
INSERT INTO Employee VALUES(4, 'Hubert J. Farnsworth', 'CEO', 20000.0, NULL);
INSERT INTO Employee VALUES(5, 'John A. Zoidberg', 'Physician', 25.0, NULL);
INSERT INTO Employee VALUES(6, 'Amy Wong', 'Intern', 5000.0, NULL);
INSERT INTO Employee VALUES(7, 'Hermes Conrad', 'Bureaucrat', 10000.0, NULL);
INSERT INTO Employee VALUES(8, 'Scruffy Scruffington', 'Janitor', 5000.0, NULL);

INSERT INTO Planet VALUES(1, 'Omicron Persei 8', 89475345.3545);
INSERT INTO Planet VALUES(2, 'Decapod X', 65498463216.3466);
INSERT INTO Planet VALUES(3, 'Mars', 32435021.65468);
INSERT INTO Planet VALUES(4, 'Omega III', 98432121.5464);
INSERT INTO Planet VALUES(5, 'Tarantulon VI', 849842198.354654);
INSERT INTO Planet VALUES(6, 'Cannibalon', 654321987.21654);
INSERT INTO Planet VALUES(7, 'DogDoo VII', 65498721354.688);
INSERT INTO Planet VALUES(8, 'Nintenduu 64', 6543219894.1654);
INSERT INTO Planet VALUES(9, 'Amazonia', 65432135979.6547);

INSERT INTO Has_Clearance VALUES(1, 1, 2);
INSERT INTO Has_Clearance VALUES(1, 2, 3);
INSERT INTO Has_Clearance VALUES(2, 3, 2);
INSERT INTO Has_Clearance VALUES(2, 4, 4);
INSERT INTO Has_Clearance VALUES(3, 5, 2);
INSERT INTO Has_Clearance VALUES(3, 6, 4);

INSERT INTO Shipment VALUES(1, '3004/05/11', 1, 1);
INSERT INTO Shipment VALUES(2, '3004/05/11', 1, 2);
INSERT INTO Shipment VALUES(3, NULL, 2, 3);
INSERT INTO Shipment VALUES(4, NULL, 2, 4);
INSERT INTO Shipment VALUES(5, NULL, 7, 5);

INSERT INTO Package VALUES(1, 1, 'Undeclared', 1.5, 1, 2);
INSERT INTO Package VALUES(2, 1, 'Undeclared', 10.0, 2, 3);
INSERT INTO Package VALUES(2, 2, 'A bucket of krill', 2.0, 8, 7);
INSERT INTO Package VALUES(3, 1, 'Undeclared', 15.0, 3, 4);
INSERT INTO Package VALUES(3, 2, 'Undeclared', 3.0, 5, 1);
INSERT INTO Package VALUES(3, 3, 'Undeclared', 7.0, 2, 3);
INSERT INTO Package VALUES(4, 1, 'Undeclared', 5.0, 4, 5);
INSERT INTO Package VALUES(4, 2, 'Undeclared', 27.0, 1, 2);
INSERT INTO Package VALUES(5, 1, 'Undeclared', 100.0, 5, 1);
INSERT INTO Has_Clearance VALUES(4, 7, 1);


-- Who received a 1.5kg package?
	select Client.Name
	from Package left join Client 
	on Package.Recipient = Client.AccountNumber
	where Package.Weight = 1.5;

-- What is the total weight of all the packages that he sent? 
	select sum(weight)
	from Package
	where Sender = (select AccountNumber from Client where Name="Al Gore's Head");

-- Which pilots transported those packages? 
	select Employee.Name
	from Employee right join Shipment on Employee.EmployeeID = Shipment.Manager
				  inner join Package on Shipment.ShipmentID = Package.Shipment
	where Shipment.ShipmentID in (
			select p.Shipment
			from Client c 
			join Package p
			on c.AccountNumber = p.Sender
			where c.AccountNumber = (
					select Client.AccountNumber
					from Client join Package 
					on Client.AcountNumber = Package.Recipient
					where Package.weight = 1.5
				)
		)
	group by Employee.Name;