-- 1. CREATE TABLES
-- Customer Table

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL
);


-- Vehicle Table
-- customer_id is a Foreign Key referring to customers
CREATE TABLE vehicles (
    vehicle_id SERIAL PRIMARY KEY,
    registration_no VARCHAR(20) UNIQUE NOT NULL,
    vehicle_model VARCHAR(50) NOT NULL,
    customer_id INT NOT NULL,
    
    FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id)
);


-- Service Jobs Table
-- vehicle_id is a Foreign Key referring to vehicles
CREATE TABLE service_jobs (
    service_id SERIAL PRIMARY KEY,
    vehicle_id INT NOT NULL,
    service_date DATE NOT NULL,
    service_description VARCHAR(100) NOT NULL,
    service_cost DECIMAL(10,2) NOT NULL,
    
    FOREIGN KEY (vehicle_id)
    REFERENCES vehicles(vehicle_id)
);

-- 2. INSERT DATA INTO CUSTOMERS


INSERT INTO customers (customer_name, city)
VALUES
('More', 'Pune'),
('Singh', 'Mumbai'),
('Shah', 'Navi Mumbai');

-- 3. INSERT DATA INTO VEHICLES


INSERT INTO vehicles (registration_no, vehicle_model, customer_id)
VALUES
('MH12AB1234', 'Hyundai i20', 1),
('MH01CD5678', 'Maruti Baleno', 2),
('MH46XY1111', 'Tata Nexon', 1),
('MH43PQ2222', 'Honda City', 3);

-- 4. INSERT DATA INTO SERVICE JOBS


INSERT INTO service_jobs
(vehicle_id, service_date, service_description, service_cost)
VALUES

-- Hyundai i20 - Customer More
(1, '2026-09-01', 'Oil Change', 1500),
(1, '2026-09-10', 'Brake Service', 3500),
(1, '2026-09-20', 'General Service', 2200),

-- Maruti Baleno - Customer Singh
(2, '2026-09-05', 'Oil Change', 1500),
(2, '2026-09-15', 'Brake Service', 3500),

-- Tata Nexon - Customer More
(3, '2026-09-08', 'General Service', 2200),
(3, '2026-09-18', 'Brake Service', 1800),

-- Honda City - Customer Shah
(4, '2026-09-12', 'General Service', 2200);

-- 5. DISPLAY ALL CUSTOMERS


SELECT *
FROM customers;

-- 6. DISPLAY ALL VEHICLES


SELECT *
FROM vehicles;

-- 7. DISPLAY ALL SERVICE JOBS


SELECT *
FROM service_jobs;

-- QUESTION 1
-- Display vehicle owners with service history.


SELECT
    customers.customer_name,
    vehicles.registration_no,
    vehicles.vehicle_model,
    service_jobs.service_date,
    service_jobs.service_description,
    service_jobs.service_cost
FROM customers
JOIN vehicles
ON customers.customer_id = vehicles.customer_id
JOIN service_jobs
ON vehicles.vehicle_id = service_jobs.vehicle_id;


-- QUESTION 2
-- Find total service revenue.

SELECT
    SUM(service_cost) AS total_service_revenue
FROM service_jobs;

-- QUESTION 3
-- Find average service cost by vehicle.

SELECT
    vehicle_id,
    AVG(service_cost) AS average_service_cost
FROM service_jobs
GROUP BY vehicle_id;

-- QUESTION 4
-- Identify customers spending more than Rs. 5,000.

SELECT
    customers.customer_id,
    customers.customer_name,
    SUM(service_jobs.service_cost) AS total_spending
FROM customers
JOIN vehicles
ON customers.customer_id = vehicles.customer_id
JOIN service_jobs
ON vehicles.vehicle_id = service_jobs.vehicle_id
GROUP BY customers.customer_id, customers.customer_name
HAVING SUM(service_jobs.service_cost) > 5000;

-- QUESTION 5
-- Display vehicles with more than two service records.

SELECT
    vehicles.registration_no,
    vehicles.vehicle_model,
    COUNT(service_jobs.service_id) AS service_records
FROM vehicles
JOIN service_jobs
ON vehicles.vehicle_id = service_jobs.vehicle_id
GROUP BY vehicles.vehicle_id,
         vehicles.registration_no,
         vehicles.vehicle_model
HAVING COUNT(service_jobs.service_id) > 2;

-- 8. EXTRA BASIC QUERIES FOR PROJECT DEMONSTRATION

-- Display vehicles with their owners
SELECT
    customers.customer_name,
    vehicles.registration_no,
    vehicles.vehicle_model
FROM customers
JOIN vehicles
ON customers.customer_id = vehicles.customer_id;


-- Display service details of Hyundai i20
SELECT
    vehicles.registration_no,
    vehicles.vehicle_model,
    service_jobs.service_description,
    service_jobs.service_cost
FROM vehicles
JOIN service_jobs
ON vehicles.vehicle_id = service_jobs.vehicle_id
WHERE vehicles.vehicle_model = 'Hyundai i20';


-- Find the highest service cost
SELECT
    MAX(service_cost) AS highest_service_cost
FROM service_jobs;


-- Find the lowest service cost
SELECT
    MIN(service_cost) AS lowest_service_cost
FROM service_jobs;


-- Count total number of service records
SELECT
    COUNT(service_id) AS total_service_records
FROM service_jobs;

--display vehical owners with service history
-- Display vehicle owners with service history

SELECT
    customers.customer_name,
    vehicles.registration_no,
    vehicles.vehicle_model,
    service_jobs.service_date,
    service_jobs.service_description,
    service_jobs.service_cost
FROM customers
JOIN vehicles
ON customers.customer_id = vehicles.customer_id
JOIN service_jobs
ON vehicles.vehicle_id = service_jobs.vehicle_id;