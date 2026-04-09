
-- Create clinics table
CREATE TABLE clinics (
    cid VARCHAR(50) PRIMARY KEY,
    clinic_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50)
);

-- insert data into Clinics
INSERT INTO clinics VALUES
('C1', 'Sunrise Clinic', 'Delhi', 'Delhi', 'India'),
('C2', 'HealthCare Plus', 'Mumbai', 'Maharashtra', 'India'),
('C3', 'Wellness Center', 'Bangalore', 'Karnataka', 'India'),
('C4', 'City Care', 'Hyderabad', 'Telangana', 'India');

select * from clinics

-- creat table customer 
CREATE TABLE customer (
    uid VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    mobile VARCHAR(15)
);

-- insert data into Customers
INSERT INTO customer VALUES
('U1', 'John Doe', '9876543210'),
('U2', 'Alice Smith', '9123456780'),
('U3', 'Rahul Kumar', '9988776655'),
('U4', 'Sneha Reddy', '9090909090'),
('U5', 'Amit Sharma', '9871234567');

select * from customer

-- create tableclinic_sales
CREATE TABLE clinic_sales (
    oid VARCHAR(50) PRIMARY KEY,
    uid VARCHAR(50),
    cid VARCHAR(50),
    amount DECIMAL(10,2),
    datetime DATETIME,
    sales_channel VARCHAR(50),
    FOREIGN KEY (uid) REFERENCES customer(uid),
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

-- insert data int0 Clinic_Sales 

INSERT INTO clinic_sales VALUES
('O1','U1','C1',2000,'2021-01-10 10:00:00','online'),
('O2','U2','C1',3000,'2021-01-15 11:00:00','offline'),
('O3','U3','C2',5000,'2021-02-20 12:00:00','online'),
('O4','U4','C3',4000,'2021-02-25 09:30:00','offline'),
('O5','U5','C2',2500,'2021-03-10 14:00:00','online'),
('O6','U1','C4',3500,'2021-03-18 16:00:00','offline'),
('O7','U2','C3',4500,'2021-04-05 10:30:00','online'),
('O8','U3','C1',1500,'2021-04-12 12:00:00','offline'),
('O9','U4','C2',6000,'2021-05-20 13:00:00','online'),
('O10','U5','C4',7000,'2021-06-15 15:30:00','offline'),
('O11','U1','C3',3200,'2021-07-01 11:00:00','online'),
('O12','U2','C2',2800,'2021-08-08 09:00:00','offline'),
('O13','U3','C4',5200,'2021-09-10 10:00:00','online'),
('O14','U4','C1',4100,'2021-10-12 12:30:00','offline'),
('O15','U5','C3',3600,'2021-11-20 14:00:00','online');

select * from clinic_sales


-- create table expenses
CREATE TABLE expenses (
    eid VARCHAR(50) PRIMARY KEY,
    cid VARCHAR(50),
    description TEXT,
    amount DECIMAL(10,2),
    datetime DATETIME,

    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

--insert data intlo expences
INSERT INTO expenses VALUES
('E1','C1','Supplies',1000,'2021-01-10 08:00:00'),
('E2','C2','Maintenance',2000,'2021-02-20 07:30:00'),
('E3','C3','Salary',1500,'2021-02-25 08:30:00'),
('E4','C4','Electricity',800,'2021-03-18 06:00:00'),
('E5','C2','Equipment',1200,'2021-03-10 07:00:00'),
('E6','C3','Cleaning',900,'2021-04-05 08:00:00'),
('E7','C1','Internet',600,'2021-04-12 09:00:00'),
('E8','C2','Supplies',1300,'2021-05-20 07:30:00'),
('E9','C4','Maintenance',1700,'2021-06-15 06:30:00'),
('E10','C3','Salary',2000,'2021-07-01 08:00:00'),
('E11','C2','Electricity',900,'2021-08-08 07:00:00'),
('E12','C4','Cleaning',1100,'2021-09-10 08:30:00'),
('E13','C1','Equipment',1400,'2021-10-12 07:45:00'),
('E14','C3','Supplies',1000,'2021-11-20 09:00:00'),
('E15','C2','Maintenance',1600,'2021-11-25 06:30:00');

select * from expenses