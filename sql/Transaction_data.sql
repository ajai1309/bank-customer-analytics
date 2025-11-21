CREATE DATABASE bank_analytics;

USE bank_analytics;

CREATE TABLE trans_data (
transaction_id INT NOT NULL PRIMARY KEY,
customer_id INT NOT NULL,
branch_id INT NOT NULL,
transaction_amount DECIMAL(10, 2),
investment_amount DECIMAL(10, 2),
total_balance DECIMAL(10, 2),
firm_revenue DECIMAL(12, 2),
expenses DECIMAL(12, 2),
profit_margin DECIMAL(5, 2),
account_type VARCHAR(50),
investment_type VARCHAR(50),
customer_type VARCHAR(50),
age INT,
transaction_date DATE,
city VARCHAR(100),
region VARCHAR(50),
bank_name VARCHAR(100),
city_branch VARCHAR(100),
region_branch VARCHAR(50)

);

select * from trans_data;

SHOW VARIABLES LIKE 'secure_file_priv';

SET GLOBAL LOCAL_INFILE=ON;

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/cleaned.csv"
INTO TABLE 	trans_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

#1.What is the Total Transaction amount monthly
#Overall
SELECT SUM(transaction_amount) AS total_amount FROM trans_data;

#Monthly
SELECT YEAR(transaction_date) AS Year, MONTH(transaction_date) AS Month, SUM(transaction_amount) AS Monthly_Total
FROM trans_data
GROUP BY Year, Month
ORDER BY Year, Month;

#2. what is the Number of Transactions

#Overall
SELECT count(*) AS No_of_Transaction FROM trans_data;

#Monthly
SELECT YEAR(transaction_date) AS Year, MONTH(transaction_date) AS Month, count(*) AS No_of_Monthly_Transaction
FROM trans_data
GROUP BY Year, Month
ORDER BY Year, Month;

#3.What is the Average Transaction Amount by Customer type
#Overall
SELECT AVG(transaction_amount) AS Avg_Transaction FROM trans_data;

#By Customer Type
SELECT customer_type, AVG(transaction_amount) AS Avg_Transaction
FROM trans_data
GROUP BY customer_type
ORDER BY Avg_Transaction DESC;

#4.Which Branch has the Highest Number of Customers?

SELECT city_branch, region_branch, COUNT(DISTINCT customer_id) AS Total_Customer
FROM trans_data
GROUP BY city_branch, region_branch
ORDER BY Total_Customer DESC;

#5.Who are the Top 10 Customers by Spending

SELECT customer_id, SUM(transaction_amount) AS Total_Spend
FROM trans_data
GROUP BY customer_id
ORDER BY Total_Spend DESC
LIMIT 10;

#6.Which Customer Type spends the most?

SELECT investment_type, SUM(transaction_amount) AS Total_Spend
FROM trans_data
GROUP BY investment_type
ORDER BY Total_Spend DESC;

#7.Which Investment Type contributes the highest total investment amount?

SELECT investment_type, SUM(investment_amount) AS Total_Investment
FROM trans_data
GROUP BY investment_type
ORDER BY Total_Investment DESC;
 

#8.Which City generates the highest transaction value?
SELECT city, SUM(transaction_amount) AS Total_Value
FROM trans_data
GROUP BY city
ORDER BY Total_Value DESC;

#9 Who are the Top 10 High-Value Customers?

SELECT customer_id, SUM(transaction_amount) AS total_spend
FROM trans_data
GROUP BY customer_id
ORDER BY total_spend DESC
LIMIT 10;

#10 How many customers are there by Age group

SELECT
 CASE
   WHEN Age BETWEEN 18 AND 29 THEN '18-25'
   WHEN Age BETWEEN 30 AND 39 THEN '26-35'
   WHEN Age BETWEEN 40 AND 49 THEN '36-45'
   WHEN Age BETWEEN 50 AND 59 THEN '46-60'
   ELSE '60+' END AS Age_Group,
 COUNT(*) AS Customers
FROM trans_data
GROUP BY Age_Group
ORDER BY Age_Group ASC ;

