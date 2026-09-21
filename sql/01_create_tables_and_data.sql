-- Ecommerce Sales Analytics Portfolio Project
-- File: 01_create_tables_and_data.sql
-- SQL Server

-- ============================================================
-- 01. CREATE TABLES
-- ============================================================

CREATE TABLE project_customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(30),
    signup_date DATE
);

CREATE TABLE project_sales (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    product VARCHAR(50),
    category VARCHAR(30),
    quantity INT,
    price DECIMAL(10,2),
    sale_date DATE,
    FOREIGN KEY (customer_id)
        REFERENCES project_customers(customer_id)
);

-- ============================================================
-- 02. INSERT CUSTOMER DATA
-- ============================================================

INSERT INTO project_customers
    (customer_id, customer_name, city, signup_date)
VALUES
    (1, 'Rahul', 'Bangalore', '2025-01-15'),
    (2, 'Priya', 'Mumbai', '2025-02-20'),
    (3, 'Arjun', 'Delhi', '2025-03-10'),
    (4, 'Neha', 'Chennai', '2025-03-25'),
    (5, 'Kiran', 'Bangalore', '2025-04-12'),
    (6, 'Sneha', 'Hyderabad', '2025-05-05'),
    (7, 'Amit', 'Mumbai', '2025-06-18'),
    (8, 'Pooja', 'Delhi', '2025-07-22'),
    (9, 'Ravi', 'Bangalore', '2025-08-14'),
    (10, 'Anil', 'Pune', '2025-09-01');

-- ============================================================
-- 03. INSERT SALES DATA
-- ============================================================

INSERT INTO project_sales
    (sale_id, customer_id, product, category, quantity, price, sale_date)
VALUES
    (1001, 1, 'Laptop', 'Electronics', 1, 65000, '2025-01-20'),
    (1002, 2, 'Smartphone', 'Electronics', 1, 30000, '2025-02-25'),
    (1003, 1, 'Headphones', 'Electronics', 2, 2500, '2025-02-10'),
    (1004, 3, 'Office Chair', 'Furniture', 1, 8500, '2025-03-15'),
    (1005, 4, 'Desk', 'Furniture', 1, 12000, '2025-03-30'),
    (1006, 5, 'Backpack', 'Accessories', 2, 2200, '2025-04-18'),
    (1007, 6, 'Running Shoes', 'Sports', 2, 4500, '2025-05-12'),
    (1008, 7, 'Coffee Maker', 'Home Appliances', 1, 7000, '2025-06-25'),
    (1009, 8, 'Watch', 'Accessories', 1, 5000, '2025-07-28'),
    (1010, 9, 'Laptop', 'Electronics', 1, 65000, '2025-08-20'),
    (1011, 10, 'Smartphone', 'Electronics', 1, 30000, '2025-09-05'),
    (1012, 1, 'Keyboard', 'Electronics', 1, 1800, '2025-10-15'),
    (1013, 2, 'Laptop', 'Electronics', 1, 65000, '2025-11-05'),
    (1014, 3, 'Yoga Mat', 'Sports', 2, 1500, '2025-11-18'),
    (1015, 4, 'Desk', 'Furniture', 1, 12000, '2025-12-02'),
    (1016, 5, 'Headphones', 'Electronics', 3, 2500, '2025-12-15'),
    (1017, 6, 'Laptop', 'Electronics', 1, 65000, '2026-01-10'),
    (1018, 7, 'Backpack', 'Accessories', 2, 2200, '2026-02-05'),
    (1019, 8, 'Office Chair', 'Furniture', 1, 8500, '2026-03-12'),
    (1020, 9, 'Smartphone', 'Electronics', 1, 30000, '2026-04-08'),
    (1021, 10, 'Running Shoes', 'Sports', 1, 4500, '2026-05-20'),
    (1022, 1, 'Laptop', 'Electronics', 1, 65000, '2026-06-15'),
    (1023, 2, 'Coffee Maker', 'Home Appliances', 1, 7000, '2026-06-25'),
    (1024, 3, 'Watch', 'Accessories', 1, 5000, '2026-07-10'),
    (1025, 4, 'Smartphone', 'Electronics', 2, 30000, '2026-07-18'),
    (1026, 5, 'Desk', 'Furniture', 1, 12000, '2026-08-05'),
    (1027, 6, 'Headphones', 'Electronics', 2, 2500, '2026-08-12'),
    (1028, 7, 'Laptop', 'Electronics', 1, 65000, '2026-08-20'),
    (1029, 8, 'Yoga Mat', 'Sports', 3, 1500, '2026-09-01'),
    (1030, 9, 'Blender', 'Home Appliances', 1, 4000, '2026-09-05');
