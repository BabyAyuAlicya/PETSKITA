
begin tran
CREATE TABLE PET 
    (
	 PETID VARCHAR (50) PRIMARY KEY  NOT NULL check (PETID like 'PET[0-9][0-9][0-9][0-9]'), 
     PetName CHAR (50) NOT NULL , 
     Age Varchar(10) NOT NULL , 
     Vaciinated_Status BIT NOT NULL , 
     Pet_Type CHAR (50) NOT NULL check([Pet_Type] in('Cat' , 'Dog')), 
     Sex CHAR (50) NOT NULL check([Sex] in('Male' , 'Female'))
    )
	select * from PET

CREATE TABLE [Owner] 
    (
	OwnerID VARCHAR (50) PRIMARY KEY NOT NULL check ([OwnerID] like 'OWN[0-9][0-9][0-9][0-9]'), 
     PETID VARCHAR (50) NOT NULL foreign key references PET(PETID), 
     OwnerName VARCHAR (50) NOT NULL CONSTRAINT ChkOwnName check (len(OwnerName) >=5),
     OwnerAddress VARCHAR (50) NOT NULL , 
     OwnerPhone VARCHAR (50) NOT NULL CONSTRAINT ChkPhone check (len(OwnerPhone) = 12), 
     OwnerEmail VARCHAR (50) NOT NULL check ([OwnerEmail] like '%@%'), 
     OwnerPassword VARCHAR (50) NOT NULL ,  
    )
	select* from Owner

CREATE TABLE APPOINTMENT
    (
     AppointmentID  VARCHAR (50) PRIMARY KEY NOT NULL check(AppointmentID like 'APM[0-9][0-9][0-9][0-9]'), 
     OwnerID VARCHAR (50) foreign key references [Owner](OwnerID) NOT NULL , 
     Keluhan CHAR (255) NOT NULL , 
    )
	select* from APPOINTMENT

CREATE TABLE PaymentSystem 
    (
     PaymentID VARCHAR (50) PRIMARY KEY  NOT NULL check(PaymentID like 'PAY[0-9][0-9][0-9][0-9]'), 
     PaymentType VARCHAR (50) NOT NULL , 
     PaymentDate DATE NOT NULL , 
    )
	select * from PaymentSystem

CREATE TABLE STAFF 
    (
     StaffID VARCHAR (50) PRIMARY KEY NOT NULL check(STAFFID like 'ST[A-Z][0-9][0-9][0-9][0-9]') , 
     StaffName VARCHAR (50) NOT NULL check (len(StaffName) >= 5), 
     StaffPosition VARCHAR (50) NOT NULL check ([StaffPosition] in('Dokter', 'Asisten Dokter', 'Staff Toko', 'Driver')), 
     StaffPhone VARCHAR (50) NOT NULL , 
     StaffSalary INTEGER NOT NULL , 
    )
	select* from STAFF

CREATE TABLE DOCTOR 
    (
     StaffID  VARCHAR (50) PRIMARY KEY foreign key references STAFF(StaffID) NOT NULL  check ([StaffID] like 'ST[A-Z][0-9][0-9][0-9][0-9]'), 
     Tasks VARCHAR (255) NOT NULL , 
     Bonus INTEGER NOT NULL , 
    
    )

CREATE TABLE DRIVER 
    (
     StaffID Varchar(50) PRIMARY KEY foreign key references STAFF(StaffID) NOT  NULL check ([StaffID] like 'ST[A-Z][0-9][0-9][0-9][0-9]'),
     PickUpPet BIT NOT NULL , 
     DeliveryPet BIT NOT NULL ,  
    )

CREATE TABLE StaffDokter 
    (
	StaffID VARCHAR (50) foreign key references STAFF(StaffID) NOT NULL , 
	Tasks VARCHAR (255) NOT NULL , 
	TindakanMedis BIT NOT NULL , 
	BONUS Integer NOT NULL , 
    )


CREATE TABLE STAFFTOKO 
    (
     StaffID VARCHAR (50) foreign key references STAFF(StaffID) NOT NULL , 
	 Tasks VARCHAR (255) NOT NULL,
     AdministrasiToko INTEGER NOT NULL , 
    )

CREATE TABLE SUPPLIER 
    (
     SupplierID VARCHAR (50)PRIMARY KEY NOT NULL check(SupplierID like 'SUP[0-9][0-9][0-9][0-9]') , 
     SupplierName CHAR (50) NOT NULL , 
     SupplierItem VARCHAR (255) NOT NULL 
    )
	select * from SUPPLIER

CREATE TABLE Item 
    (
     ItemID VARCHAR (50)PRIMARY KEY  NOT NULL check ([ItemID] like 'ITM[0-9][0-9][0-9][0-9]'), 
     ItemName VARCHAR (50) NOT NULL CONSTRAINT ChkITM check (len(ItemName) >=5) , 
     ItemPrice INTEGER NOT NULL ,
	 ItemStock INTEGER NOT NULL check ((ItemStock) >= 100),
     ItemDescription CHAR (50) NOT NULL ,  
    )

CREATE TABLE ItemWareHouse
	(
	WarehouseID varchar (50) primary key check (WarehouseID like 'WRH[0-9][0-9][0-9][0-9]'),
	SupplierID VARCHAR (50) foreign key references SUPPLIER(SupplierID) NOT NULL,
	ItemID VARCHAR (50) foreign key references Item(ItemID) NOT NULL,
	)

CREATE TABLE STORE 
    (
     StoreID VARCHAR (50) PRIMARY KEY NOT NULL check(StoreID like 'STR[0-9][0-9][0-9][0-9]'), 
     StaffID VARCHAR (50) foreign key references STAFF(StaffID) NOT NULL , 
     WarehouseID VARCHAR (50) foreign key references ItemWareHouse(WarehouseID) NOT NULL 
    )
	
CREATE TABLE SERVICESLIST 
    (
     ServicesID VARCHAR  (50)PRIMARY KEY NOT NULL check(ServicesID like 'SRV[0-9][0-9][0-9][0-9]'), 
     ServicesName VARCHAR (50) NOT NULL check ([ServicesName] in('Pet Hotel', 'Day Care', 'Grooming')), 
     ServicesType VARCHAR (50) NOT NULL check ([ServicesType] in('Regular', 'VIP', 'VVIP')), 
     ServicesPrice INTEGER NOT NULL ,
    )
	
CREATE TABLE PembelianItem
	(
	PMBID VARCHAR (50) PRIMARY KEY NOT NULL check (PMBID like 'PMB[0-9][0-9][0-9][0-9]'),
	ItemID VARCHAR (50) foreign key references Item(ItemID) NOT NULL,
	Qty Integer NOT NULL
	)

CREATE TABLE MSTransaction 
    (
     TransactionID VARCHAR (50) PRIMARY KEY NOT NULL check(TransactionID like 'TRS[0-9][0-9][0-9][0-9]'), 
     TransactionDate DATE NOT NULL , 
     StoreID VARCHAR (50) foreign key references STORE(StoreID) NOT NULL , 
     PaymentID VARCHAR (50)foreign key references PaymentSystem(PaymentID) NOT NULL , 
     AppointmentID VARCHAR (50)foreign key references APPOINTMENT(AppointmentID) NOT NULL , 
    )
	select * from MSTransaction
	
CREATE TABLE TransactionDetails 
    (
     TransactionID VARCHAR (50)PRIMARY KEY foreign key references MSTransaction(TransactionID) NOT NULL , 
     ServicesID VARCHAR (50) foreign key references SERVICESLIST(ServicesID) , 
     PMBID VARCHAR (50) foreign key references PembelianItem(PMBID) , 
     StaffID VARCHAR (50) foreign key references STAFF(StaffID) NOT NULL , 
    )


	


Insert Into [PET] Values
('PET0001','Kucingku','2 Tahun','1','Cat','Male'),
('PET0002','mwahyung','3 Tahun','0','Dog','Female'),
('PET0003','oren','4 Tahun','1','Cat','Female'),
('PET0004','abuabusayang','5 Tahun','0','Cat','Male'),
('PET0005','kucingmwahh','1 Tahun','1','Cat','Male')
select* from PET

Insert Into[Owner] VALUES
('OWN0001','PET0001','Baby Ayu Alicya','Jakarta Selatan','089786881298','Baby@gmail.com','Baby123'),
('OWN0002','PET0002','Kanzi Katsira F','Bekasi Selatan','089723231298','kanzi@gmail.com','kanzi123'),
('OWN0003','PET0003','yosephine clay','Bekasi planet lain','089553234298','yose@gmail.com','yose123'),
('OWN0004','PET0004','atta halilintar','kalimantan','082223233298','atta@gmail.com','atta123'),
('OWN0005','PET0005','mamanx halilintar','sulawesi','089723231299','atta@gmail.com','mamanx123')
select* from Owner

insert into APPOINTMENT values
('APM0001', 'OWN0002', 'Lemas dan tidak bersemangat'),
('APM0002', 'OWN0004', 'Muntah'),
('APM0003', 'OWN0005', 'Kutu'),
('APM0004', 'OWN0001', 'Diare'),
('APM0005', 'OWN0003', 'Cacing pita')
select* from APPOINTMENT

INSERT INTO [PaymentSystem] values
('PAY0051','GoPay','2021-10-20'),
('PAY0032','Dana','2019-10-20'),
('PAY0023','Bca','2011-10-20'),
('PAY0034','Mandiri','2018-10-20'),
('PAY0205','BRI','2017-10-20')
select* from PaymentSystem

Insert Into [STAFF] Values
('STA0001','Admin Rafli','Staff Toko','087788300694','5000'),
('STA0002','Admin Bambang','Staff Toko','087788400694','5000'),
('STA0003','Admin AttaHalilintar','Staff Toko','087788500694','5000'),
('STA0004','Admin Asiap','Staff Toko','087788600694','5000'),
('STA0005','Admin Mak tolong','Staff Toko','087788700694','5000'),
('STD0003','Drs.Baby','Dokter','087788811111','50000'),
('STD0004','Drs.Yose','Dokter','087788800694','50000'),
('STD0005','Drs.Asyel','Dokter','087780192018','50000'),
('STD0002','Drs.Qiqi','Dokter','080029183912','50000'),
('STD0001','Drs.Taeyong','Dokter','082100023451','50000'),
('STX0003','Driver Ahmad','Driver','087789900694','2000'),
('STX0002','Driver Kanjoy','Driver','087733200694','5000'),
('STX0010','Driver Rizkah','Driver','087109280000','15000'),
('STX0022','Driver Miskah','Driver','080912340123','25000'),
('STX0054','Driver Raya','Driver','080190902121','50000'),
('STP0010', 'Asisten Lucas', 'Asisten Dokter', '081920001234', '50000'),
('STP0005', 'Asisten Budi', 'Asisten Dokter', '082821111214', '20000'),
('STP0015', 'Asisten Raihan', 'Asisten Dokter', '082209812341', '100000'),
('STP0012', 'Asisten Millinski', 'Asisten Dokter', '081976483241', '50000'),
('STP0022', 'Asisten Lala', 'Asisten Dokter', '081098901231', '50000')
select*from STAFF

insert into [StaffDokter] Values
('STP0010', 'Membantu operasi dokter', 1, '50000'),
('STP0005', 'Membantu perawatan hewan saat rawat inap', 0, '20000'),
('STP0015', 'Membantu operasi dokter, membantu perawatan rawat inap', 1, '100000'),
('STP0012', 'Memberi obat pada hewan, sterilisasi alat-alat, membantu operasi dokter', 1, '50000'),
('STP0022', 'Memandikan hewan, melatih hewan, merawat hewan rawat inap', 0, '50000')
select* from StaffDokter

insert into [DRIVER] values
('STX0003',1, 1),
('STX0002',1, 0),
('STX0010',1, 1),
('STX0022',0, 1),
('STX0054',1, 1)
Select*from DRIVER

insert into [DOCTOR] values
('STD0003','Operasi hewan, meresepkan obat, memberi obat, memeriksa hewan','50000'),
('STD0004','Operasi hewan, meresepkan obat, memberi obat, memeriksa hewan', '50000'),
('STD0005','Operasi hewan, meresepkan obat, memberi obat, memeriksa hewan', '50000'),
('STD0002','Operasi hewan, meresepkan obat, memberi obat, memeriksa hewan', '50000'),
('STD0001','Operasi hewan, meresepkan obat, memberi obat, memeriksa hewan', '50000')
select* from DOCTOR

insert into STAFFTOKO values
('STA0001', 'Membalas chat konsumen', 1),
('STA0002', 'Manajamen toko', 1),
('STA0003', 'mengantar produk ke konsumen serta menjemput dan mengantar pet', 0),
('STA0004', 'Memandikan Pet', 1),
('STA0005', 'Membantu operasi dokter', 0)
select* from STAFFTOKO


Insert Into [SUPPLIER] Values
('SUP0446','PecintaKucing','Makanan Kucing Bolt'),
('SUP0042','PecintaAnjing','Makanan Anjing kimochi'),
('SUP0403','MwaMwaMeow','Mainan Anjing Dumbai'),
('SUP0304','GukgukMeow','Mainan Kucing Dumbaiass'),
('SUP0025','AttaSukaMeow','Vitamin Kucing Excelso')
select* from SUPPLIER


insert into Item values
('ITM0023', 'Royal Canin Adult', 150000, 150, 'Makanan kucing khusus untuk adult'),
('ITM0001', 'Royal Canin Medium', 100000, 190, 'Makanan anjing khusus untuk medium breed'),
('ITM0091', 'Tikus Mainan', 20000, 100, 'Mainan kucing dengan boneka tikus'),
('ITM0203', 'Tulang Mainan', 35000, 150, 'Mainan anjing berbentuk tulang'),
('ITM0099', 'Nutri-plus Gel', 150000, 300, 'Vitamin khusus hewan peliharaan')
select* from Item


insert into [ItemWareHouse] values
('WRH0010', 'SUP0446', 'ITM0023'),
('WRH0201', 'SUP0042', 'ITM0001'),
('WRH0001', 'SUP0403', 'ITM0091'),
('WRH0029', 'SUP0304', 'ITM0203'),
('WRH0005', 'SUP0025', 'ITM0099')
select* from ItemWareHouse


INSERT INTO STORE VALUES
('STR0011','STA0001','WRH0010'),
('STR0022','STA0002' ,'WRH0201'),
('STR0031','STA0003', 'WRH0001'),
('STR0010','STA0004', 'WRH0001'),
('STR0012','STA0005', 'WRH0005')
Select *from STORE

insert into SERVICESLIST values
('SRV0001', 'Grooming', 'Regular', 300000),
('SRV0002', 'Grooming', 'VIP', 1000000),
('SRV0003', 'Grooming', 'VVIP', 2000000),
('SRV0004', 'Day Care', 'Regular', 500000),
('SRV0005', 'Day Care', 'VIP', 1500000),
('SRV0006', 'Day Care', 'VVIP', 3000000),
('SRV0007', 'Pet Hotel', 'Regular', 800000),
('SRV0008', 'Pet Hotel', 'VIP', 2000000),
('SRV0009', 'Pet Hotel', 'VVIP', 3000000)
select* from SERVICESLIST

insert into PembelianItem values 
('PMB0001','ITM0023', 3),
('PMB0002','ITM0001', 1),
('PMB0003','ITM0091', 2),
('PMB0004','ITM0001', 1),
('PMB0005','ITM0099', 5)
select* from PembelianItem

Insert Into [MSTransaction] Values
('TRS0001','2021-10-20','STR0011','PAY0051','APM0001'),
('TRS0002','2019-10-20','STR0031','PAY0032','APM0002'),
('TRS0003','2011-10-20','STR0011','PAY0023','APM0003'),
('TRS0004','2018-10-20','STR0010','PAY0034','APM0004'),
('TRS0005','2017-10-20','STR0012','PAY0205','APM0005')
select* from MSTransaction

INSERT INTO [TransactionDetails] values
('TRS0001', 'SRV0001', 'PMB0001', 'STA0001'),
('TRS0002', 'SRV0002', 'PMB0002', 'STA0002'),
('TRS0003', 'SRV0005', 'PMB0003', 'STA0002'),
('TRS0004', 'SRV0003', 'PMB0004', 'STA0004'),
('TRS0005', 'SRV0002', 'PMB0005', 'STA0003')
select* from TransactionDetails
GO

Create VIEW [OwnerInformationDANPET] AS
Select [OwnerID]=O.OwnerID,O.OwnerName,O.OwnerAddress,P.PetName,p.Sex
From Owner O
Join PET P on P.PETID = O.PETID
GO
Select* FROM [OwnerInformationDANPET]
go
Create View [Suppliesanditems] AS
Select i.ItemName,i.ItemStock,i.ItemDescription,IT.WarehouseID,s.SupplierName
From ItemWareHouse IT
Join Item I on I.ItemID = IT.ItemID
Join SUPPLIER S on S.SupplierID = IT.SupplierID
GO
Select* FROM [Suppliesanditems]
go
Create View [Namapembeliyangmelakukanappointment] AS
Select O.OwnerName,O.OwnerAddress,P.PetName,P.Age,A.Keluhan,M.TransactionID,m.TransactionDate,M.StoreID
From MSTransaction M
Join TransactionDetails TD on TD.TransactionID = M.TransactionID
Join APPOINTMENT A on A.AppointmentID = M.AppointmentID
Join [Owner] O on O.OwnerID = A.OwnerID 
Join [Pet] P on P.PETID = O.PETID
GO
Select* FROM  [Namapembeliyangmelakukanappointment]
go

Create View [TransaksiDanPembayaran] As
Select M.TransactionID,M.TransactionDate,M.StoreID,M.AppointmentID,P.PaymentID,P.PaymentType
From MSTransaction M
Join PaymentSystem P on P.PaymentID = M.PaymentID
GO
Select* From [TransaksiDanPembayaran]

Create View [TokodanSuppliernya] As
Select S.StoreID,S.StaffID,S.WarehouseID,SP.SupplierID,SP.SupplierItem,SP.SupplierName
From STORE S
Join ItemWareHouse IT on IT.WarehouseID = S.WarehouseID
Join Supplier SP on SP.SupplierID = IT.SupplierID

GO
Select* From [TokodanSuppliernya] 

GO
Create View [PembelianItemByOwner] AS
Select M.TransactionID, M.TransactionDate,M.StoreID,TD.StaffID,PMB.ItemID,PMB.Qty,I.ItemName
From MSTransaction M 
JOIN TransactionDetails TD on TD.TransactionID = M.TransactionID
Join PembelianItem PMB on PMB.PMBID = TD.PMBID
jOIN Item I on I.ItemID = PMB.ItemID
GO


Select * From  [PembelianItemByOwner]
GO
Create View [PembelianServicesByOwner] AS
Select M.TransactionID, M.TransactionDate,M.StoreID,TD.StaffID,pmb.ServicesID,PMB.ServicesName,pmb.ServicesType
From MSTransaction M 
JOIN TransactionDetails TD on TD.TransactionID = M.TransactionID
Join SERVICESLIST PMB on PMB.ServicesID = TD.ServicesID
Go

Select* From [PembelianServicesByOwner]
