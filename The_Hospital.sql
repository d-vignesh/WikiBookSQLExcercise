create table Physician(
	EmployeeID Integer Primary Key NOT NULL,
	Name Varchar(50) NOT NULL,
	Position Varchar(50) NOT NULL,
	SSN Integer NOT NULL
);

create table Department(
	DepartmentID Integer Primary Key NOT NULL,
	Name Varchar(50) NOT NULL,
	Head Integer NOT NULL,
	Foreign Key(Head) References Physician(EmployeeID)
);

create table Affiliated_With(
	Physician Integer NOT NULL,
	Foreign Key(Physician) References Physician(EmployeeID),
	Department Integer NOT NULL,
	Foreign Key(Department) References Department(DepartmentID),
	PrimaryAffiliation Boolean NOT NULL,
	Primary Key(Physician, Department)
);

create table Procedures(
	Code Integer Primary Key NOT NULL,
	Name Varchar(50) NOT NULL,
	Cost real NOT NULL
);

create table Trained_In(
	Physician Integer NOT NULL,
	Foreign Key(Physician) References Physician(EmployeeID),
	Treatment Integer NOT NULL,
	Foreign Key(Treatment) References Procedures(Code),
	Primary Key(Physician, Treatment),
	CretificationDate Datetime NOT NULL,
	CretificationExpires Datetime NOT NULL
);

create table Patient(
	SSN Integer Primary Key NOT NULL,
	Name Varchar(50) NOT NULL,
	Address Varchar(250) NOT NULL,
	Phone Varchar(15) NOT NULL,
	InsuranceID Integer NOT NULL,
	PCP Integer NOT NULL,
	Foreign Key(PCP) References Physician(EmployeeID)
);

create table Nurse(
	EmployeeID Integer Primary Key NOT NULL,
	Name Varchar(50) NOT NULL,
	Position Varchar(50) NOT NULL,
	Registered Boolean NOT NULL,
	SNN Integer NOT NULL
);

create table Appointment(
	AppointmentID Integer Primary Key NOT NULL,
	Patient Integer NOT NULL,
	Foreign Key(Patient) References Patient(SSN),
	PrepNurse Integer,
	Foreign Key(PrepNurse) References Nurse(EmployeeID),
	Physician Integer NOT NULL,
	Foreign Key(Physician) References Physician(EmployeeID),
	Start Datetime NOT NULL,
	End Datetime NOT NULL,
	ExaminationRoom Varchar(50) NOT NULL
);

create table Medication(
	Code Integer Primary Key NOT NULL,
	Name Varchar(50) NOT NULL,
	Brand Varchar(50) NOT NULL,
	Description Varchar(250) NOT NULL
);

create table Prescribes(
	Physician Integer NOT NULL,
	Foreign Key(Physician) References Physician(EmployeeID),
	Patient Integer NOT NULL,
	Foreign Key(Patient) References Patient(SSN),
	Medication Integer NOT NULL,
	Foreign Key(Medication) References Medication(Code),
	Date Datetime NOT NULL,
	Primary Key(Physician, Patient, Medication, Date),
	Appointment Integer,
	Foreign Key(Appointment) References Appointment(AppointmentID),
	Dose Varchar(50) NOT NULL
);

create table Block(
	Floor Integer NOT NULL,
	Code Integer NOT NULL,
	Primary Key(Floor, Code)
);

create table Room(
	Number Integer Primary Key NOT NULL,
	Type Varchar(250) NOT NULL,
	BlockFloor Integer NOT NULL,
	BlockCode Integer NOT NULL,
	Foreign Key(BlockFloor, BlockCode) References Block(Floor, Code),
	Unavailable Boolean NOT NULL
);

create table On_Call (
	Nurse Integer NOT NULL,
	Foreign Key(Nurse) References Nurse(EmployeeID),
	BlockFloor Integer NOT NULL,
	BlockCode Integer NOT NULL,
	Foreign Key(BlockFloor, BlockCode) References Block(Floor, Code),
	Start Datetime NOT NULL,
	End Datetime NOT NULL,
	Primary Key(Nurse, BlockFloor, BlockCode, Start, End)
);

create table Stay (
	StayID Integer Primary Key NOT NULL,
	Patient Integer NOT NULL,
	Foreign Key(Patient) References Patient(SSN),
	Room Integer NOT NULL,
	Foreign Key(Room) References Room(Number),
	Start Datetime NOT NULL,
	End Datetime NOT NULL
);

create table Undergoes (
	Patient Integer NOT NULL,
	Foreign Key(Patient) References Patient(SSN),
	Treatment Integer NOT NULL,
	Foreign Key(Treatment) References Procedures(Code),
	Stay Integer NOT NULL,
	Foreign Key(Stay) References Stay(StayID),
	Date Datetime NOT NULL,
	Primary Key(Patient, Treatment, Stay, Date),
	Physician Integer NOT NULL,
	Foreign Key(Physician) References Physician(EmployeeID),
	AssistingNurse Integer,
	Foreign Key(AssistingNurse) References Nurse(EmployeeID)	
);


INSERT INTO Physician VALUES(1,'John Dorian','Staff Internist',111111111);
INSERT INTO Physician VALUES(2,'Elliot Reid','Attending Physician',222222222);
INSERT INTO Physician VALUES(3,'Christopher Turk','Surgical Attending Physician',333333333);
INSERT INTO Physician VALUES(4,'Percival Cox','Senior Attending Physician',444444444);
INSERT INTO Physician VALUES(5,'Bob Kelso','Head Chief of Medicine',555555555);
INSERT INTO Physician VALUES(6,'Todd Quinlan','Surgical Attending Physician',666666666);
INSERT INTO Physician VALUES(7,'John Wen','Surgical Attending Physician',777777777);
INSERT INTO Physician VALUES(8,'Keith Dudemeister','MD Resident',888888888);
INSERT INTO Physician VALUES(9,'Molly Clock','Attending Psychiatrist',999999999);

INSERT INTO Department VALUES(1,'General Medicine',4);
INSERT INTO Department VALUES(2,'Surgery',7);
INSERT INTO Department VALUES(3,'Psychiatry',9);

INSERT INTO Affiliated_With VALUES(1,1,1);
INSERT INTO Affiliated_With VALUES(2,1,1);
INSERT INTO Affiliated_With VALUES(3,1,0);
INSERT INTO Affiliated_With VALUES(3,2,1);
INSERT INTO Affiliated_With VALUES(4,1,1);
INSERT INTO Affiliated_With VALUES(5,1,1);
INSERT INTO Affiliated_With VALUES(6,2,1);
INSERT INTO Affiliated_With VALUES(7,1,0);
INSERT INTO Affiliated_With VALUES(7,2,1);
INSERT INTO Affiliated_With VALUES(8,1,1);
INSERT INTO Affiliated_With VALUES(9,3,1);

INSERT INTO Procedures VALUES(1,'Reverse Rhinopodoplasty',1500.0);
INSERT INTO Procedures VALUES(2,'Obtuse Pyloric Recombobulation',3750.0);
INSERT INTO Procedures VALUES(3,'Folded Demiophtalmectomy',4500.0);
INSERT INTO Procedures VALUES(4,'Complete Walletectomy',10000.0);
INSERT INTO Procedures VALUES(5,'Obfuscated Dermogastrotomy',4899.0);
INSERT INTO Procedures VALUES(6,'Reversible Pancreomyoplasty',5600.0);
INSERT INTO Procedures VALUES(7,'Follicular Demiectomy',25.0);

INSERT INTO Patient VALUES(100000001,'John Smith','42 Foobar Lane','555-0256',68476213,1);
INSERT INTO Patient VALUES(100000002,'Grace Ritchie','37 Snafu Drive','555-0512',36546321,2);
INSERT INTO Patient VALUES(100000003,'Random J. Patient','101 Omgbbq Street','555-1204',65465421,2);
INSERT INTO Patient VALUES(100000004,'Dennis Doe','1100 Foobaz Avenue','555-2048',68421879,3);

INSERT INTO Nurse VALUES(101,'Carla Espinosa','Head Nurse',1,111111110);
INSERT INTO Nurse VALUES(102,'Laverne Roberts','Nurse',1,222222220);
INSERT INTO Nurse VALUES(103,'Paul Flowers','Nurse',0,333333330);

INSERT INTO Appointment VALUES(13216584,100000001,101,1,'2008-04-24 10:00','2008-04-24 11:00','A');
INSERT INTO Appointment VALUES(26548913,100000002,101,2,'2008-04-24 10:00','2008-04-24 11:00','B');
INSERT INTO Appointment VALUES(36549879,100000001,102,1,'2008-04-25 10:00','2008-04-25 11:00','A');
INSERT INTO Appointment VALUES(46846589,100000004,103,4,'2008-04-25 10:00','2008-04-25 11:00','B');
INSERT INTO Appointment VALUES(59871321,100000004,NULL,4,'2008-04-26 10:00','2008-04-26 11:00','C');
INSERT INTO Appointment VALUES(69879231,100000003,103,2,'2008-04-26 11:00','2008-04-26 12:00','C');
INSERT INTO Appointment VALUES(76983231,100000001,NULL,3,'2008-04-26 12:00','2008-04-26 13:00','C');
INSERT INTO Appointment VALUES(86213939,100000004,102,9,'2008-04-27 10:00','2008-04-21 11:00','A');
INSERT INTO Appointment VALUES(93216548,100000002,101,2,'2008-04-27 10:00','2008-04-27 11:00','B');

INSERT INTO Medication VALUES(1,'Procrastin-X','X','N/A');
INSERT INTO Medication VALUES(2,'Thesisin','Foo Labs','N/A');
INSERT INTO Medication VALUES(3,'Awakin','Bar Laboratories','N/A');
INSERT INTO Medication VALUES(4,'Crescavitin','Baz Industries','N/A');
INSERT INTO Medication VALUES(5,'Melioraurin','Snafu Pharmaceuticals','N/A');

INSERT INTO Prescribes VALUES(1,100000001,1,'2008-04-24 10:47',13216584,'5');
INSERT INTO Prescribes VALUES(9,100000004,2,'2008-04-27 10:53',86213939,'10');
INSERT INTO Prescribes VALUES(9,100000004,2,'2008-04-30 16:53',NULL,'5');

INSERT INTO Block VALUES(1,1);
INSERT INTO Block VALUES(1,2);
INSERT INTO Block VALUES(1,3);
INSERT INTO Block VALUES(2,1);
INSERT INTO Block VALUES(2,2);
INSERT INTO Block VALUES(2,3);
INSERT INTO Block VALUES(3,1);
INSERT INTO Block VALUES(3,2);
INSERT INTO Block VALUES(3,3);
INSERT INTO Block VALUES(4,1);
INSERT INTO Block VALUES(4,2);
INSERT INTO Block VALUES(4,3);

INSERT INTO Room VALUES(101,'Single',1,1,0);
INSERT INTO Room VALUES(102,'Single',1,1,0);
INSERT INTO Room VALUES(103,'Single',1,1,0);
INSERT INTO Room VALUES(111,'Single',1,2,0);
INSERT INTO Room VALUES(112,'Single',1,2,1);
INSERT INTO Room VALUES(113,'Single',1,2,0);
INSERT INTO Room VALUES(121,'Single',1,3,0);
INSERT INTO Room VALUES(122,'Single',1,3,0);
INSERT INTO Room VALUES(123,'Single',1,3,0);
INSERT INTO Room VALUES(201,'Single',2,1,1);
INSERT INTO Room VALUES(202,'Single',2,1,0);
INSERT INTO Room VALUES(203,'Single',2,1,0);
INSERT INTO Room VALUES(211,'Single',2,2,0);
INSERT INTO Room VALUES(212,'Single',2,2,0);
INSERT INTO Room VALUES(213,'Single',2,2,1);
INSERT INTO Room VALUES(221,'Single',2,3,0);
INSERT INTO Room VALUES(222,'Single',2,3,0);
INSERT INTO Room VALUES(223,'Single',2,3,0);
INSERT INTO Room VALUES(301,'Single',3,1,0);
INSERT INTO Room VALUES(302,'Single',3,1,1);
INSERT INTO Room VALUES(303,'Single',3,1,0);
INSERT INTO Room VALUES(311,'Single',3,2,0);
INSERT INTO Room VALUES(312,'Single',3,2,0);
INSERT INTO Room VALUES(313,'Single',3,2,0);
INSERT INTO Room VALUES(321,'Single',3,3,1);
INSERT INTO Room VALUES(322,'Single',3,3,0);
INSERT INTO Room VALUES(323,'Single',3,3,0);
INSERT INTO Room VALUES(401,'Single',4,1,0);
INSERT INTO Room VALUES(402,'Single',4,1,1);
INSERT INTO Room VALUES(403,'Single',4,1,0);
INSERT INTO Room VALUES(411,'Single',4,2,0);
INSERT INTO Room VALUES(412,'Single',4,2,0);
INSERT INTO Room VALUES(413,'Single',4,2,0);
INSERT INTO Room VALUES(421,'Single',4,3,1);
INSERT INTO Room VALUES(422,'Single',4,3,0);
INSERT INTO Room VALUES(423,'Single',4,3,0);

INSERT INTO On_Call VALUES(101,1,1,'2008-11-04 11:00','2008-11-04 19:00');
INSERT INTO On_Call VALUES(101,1,2,'2008-11-04 11:00','2008-11-04 19:00');
INSERT INTO On_Call VALUES(102,1,3,'2008-11-04 11:00','2008-11-04 19:00');
INSERT INTO On_Call VALUES(103,1,1,'2008-11-04 19:00','2008-11-05 03:00');
INSERT INTO On_Call VALUES(103,1,2,'2008-11-04 19:00','2008-11-05 03:00');
INSERT INTO On_Call VALUES(103,1,3,'2008-11-04 19:00','2008-11-05 03:00');

INSERT INTO Stay VALUES(3215,100000001,111,'2008-05-01','2008-05-04');
INSERT INTO Stay VALUES(3216,100000003,123,'2008-05-03','2008-05-14');
INSERT INTO Stay VALUES(3217,100000004,112,'2008-05-02','2008-05-03');

INSERT INTO Undergoes VALUES(100000001,6,3215,'2008-05-02',3,101);
INSERT INTO Undergoes VALUES(100000001,2,3215,'2008-05-03',7,101);
INSERT INTO Undergoes VALUES(100000004,1,3217,'2008-05-07',3,102);
INSERT INTO Undergoes VALUES(100000004,5,3217,'2008-05-09',6,NULL);
INSERT INTO Undergoes VALUES(100000001,7,3217,'2008-05-10',7,101);
INSERT INTO Undergoes VALUES(100000004,4,3217,'2008-05-13',3,103);

INSERT INTO Trained_In VALUES(3,1,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(3,2,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(3,5,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(3,6,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(3,7,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(6,2,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(6,5,'2007-01-01','2007-12-31');
INSERT INTO Trained_In VALUES(6,6,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,1,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,2,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,3,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,4,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,5,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,6,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,7,'2008-01-01','2008-12-31');

-- Obtain the names of all physicians that have performed a medical procedure they have never been certified to perform. 
	select Name 
	from Physician
	where EmployeeID in (
			select Physician 
			from Undergoes U
			where Not Exists (
					select *
					from Trained_In
					where Physician = U.Physician
					and Treatment = U.Treatment
				)
		);

	select Name
	from Physician
	where EmployeeID in (
			select U.Physician
			from Undergoes U
			left join Trained_In T 
			On U.Physician = T.Physician And U.Treatment = T.Treatment
			where T.Treatment Is Null
		);

-- Same as the previous query, but include the following information in the results: Physician name, name of procedure, 
-- date when the procedure was carried out, name of the patient the procedure was carried out on.
	select P.Name as Physician, Pr.Name as Treatment, U.Date, Pt.Name as Patient
	from Physician P, Undergoes U, Procedures Pr, Patient Pt
	where U.Patient = Pt.SSN
		And U.Physician = P.EmployeeID
		And U.Treatment = Pr.Code
		And Not Exists (
			select * 
			From Trained_In T
			where U.Physician = T.Physician And U.Treatment = T.Treatment
			);

-- Obtain the names of all physicians that have performed a medical procedure that they are certified to perform, but such that the procedure was done 
-- at a date (Undergoes.Date) after the physician's certification expired (Trained_In.CertificationExpires).  
	Select Name
	From Physician 
	Where EmployeeID In (
			Select U.Physician 
			From Undergoes U
			inner Join Trained_In T
			On U.Physician = T.Physician 
				And U.Treatment = T.Treatment
				And U.Date > T.CretificationExpires
		);

	Select Name
	From Physician
	Where EmployeeID In (
			Select Physician From Undergoes U
			Where Date > (
					Select CretificationExpires
					From Trained_In
					Where T.Physician = U.Physician
						And T.Treatment = U.Treatment
				)
		);

-- Same as the previous query, but include the following information in the results: Physician name, name of procedure, date when the 
-- procedure was carried out, name of the patient the procedure was carried out on, and date when the certification expired. 

	Select P.Name as Physician, U.Date as Treated_On, Pt.Name as Patient, T.CretificationExpires as CertificationExpiry,Pro.Name as Treatment 
	From Physician P, Undergoes U, Patient Pt, Trained_In T, Procedures Pro
	Where U.Physician = T.Physician
		And U.Treatment = T.Treatment
		And U.Date > T.CretificationExpires
		And U.Physician = P.EmployeeID
		And U.Patient = Pt.SSN
		And U.Treatment = Pro.Code;

-- Obtain the information for appointments where a patient met with a physician other than his/her primary care physician. 
-- Show the following information: Patient name, physician name, nurse name (if any), start and end time of appointment, 
-- examination room, and the name of the patient's primary care physician. 

	Select Pt.Name as Patient, P.Name as Physician, N.Name as Nurse, A.Start as StartTime, A.End as EndTime, A.ExaminationRoom as ExaminationRoom
	From Patient Pt, Physician P, Appointment A
	Left Join Nurse N 
	On N.EmployeeID = A.PrepNurse
	Where A.Patient = Pt.SSN
		And A.Physician <> Pt.PCP
		And A.Physician = P.EmployeeID;


-- The Patient field in Undergoes is redundant, since we can obtain it from the Stay table. 
-- There are no constraints in force to prevent inconsistencies between these two tables. 
-- More specifically, the Undergoes table may include a row where the patient ID does not match the one we would obtain from the Stay table through the Undergoes.Stay foreign key. 
-- Select all rows from Undergoes that exhibit this inconsistency. 

	Select * 
	From Undergoes
	Where Not Exists (
		Select StayID 
		From Stay
		Where Undergoes.Stay = Stay.StayID
			And Undergoes.Patient = Stay.Patient
		);

	Select * 
	From Undergoes
	Where Patient <> (
			Select Patient
			From Stay
			Where StayID = Undergoes.Stay
		);

-- Obtain the names of all the nurses who have ever been on call for room 123. 
	Select Name
	From Nurse
	Where EmployeeID In (
			Select Nurse
			From On_Call
			Where BlockCode = (Select BlockCode From Room Where Number = 123)
				And BlockFloor = (Select BlockFloor From Room Where Number = 123)
		);

	Select N.Name From Nurse N
	Where EmployeeID In
		(
			Select OC.Nurse From On_Call OC, Room R 
			Where OC.BlockFloor = R.BlockFloor
				And OC.BlockCode = R.BlockCode
				And R.Number = 123
		);

-- The hospital has several examination rooms where appointments take place. 
-- Obtain the number of appointments that have taken place in each examination room.
	Select ExaminationRoom, Count(AppointmentID) as appointments
	From Appointment
	group by ExaminationRoom;

-- Obtain the names of all patients (also include, for each patient, the name of the patient's primary care physician), 
-- such that \emph{all} the following are true:

    -- The patient has been prescribed some medication by his/her primary care physician.
    -- The patient has undergone a procedure with a cost larger that $5,000
    -- The patient has had at least two appointment where the nurse who prepped the appointment was a registered nurse.
    -- The patient's primary care physician is not the head of any department.

   Select Pt.Name as Patient,Phy.Name
   From Physician Phy, Patient Pt
   Where Pt.PCP = Phy.EmployeeID
   And Exists(
   		Select * 
   		From Prescribes
   		Where Pt.SSN = Prescribes.Patient
   			And Pt.PCP = Prescribes.Physician
   	)
   	And Exists(
   		Select * 
   		From Procedures Pr, Undergoes U
   		Where U.Procedure = Pr.Code
   			And U.Patient = Pt.SSN
   			And Pr.Cost > 5000
   	)
   	And 2 <= (
   		Select Count(AppiontmentID)
   		From Appointment A, Nurse N
   		Where A.PrepNurse = N.EmployeeID
   			And N.Registered = 1
   	) 
   	And Pt.PCP Not in (
   		Select Head From Department
   	);