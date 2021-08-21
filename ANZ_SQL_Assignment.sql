-- 1)	How many unique accounts are there?
SELECT COUNT(DISTINCT(`account`)) AS Unique_Accounts
from anz;

-- 2)	What are the currencies used in transactions?
SELECT DISTINCT(`currency`)
FROM anz;

-- 3)	What are the types of txn_descriptions? For each type, how many transactions are there?
SELECT `txn_description` as Types, COUNT(`txn_description`) AS Total_Transaction
FROM anz.anz
GROUP BY `txn_description`;

-- 4)	Based on the above txn_descriptions types, for each type, 
-- how many unique accounts can be observed to have performed at least 2 transactions?
SELECT `txn_description`, COUNT(DISTINCT(account)) AS Unique_Accounts
FROM 
(
SELECT `txn_description`, `account`, COUNT(`transaction_id`) 
FROM anz
GROUP BY `account`,`txn_description`
HAVING COUNT(`transaction_id`) >= 2
) as Unique_Acc 
GROUP BY `txn_description`;

-- 5)	Are there any customers with more than one account? If so, how many?
SELECT `customer_id`, COUNT(`account`) AS more_than_one_account
FROM anz
GROUP BY `customer_id`, `account`
HAVING count(ALL `account`) > 1;

-- 6)	The management believes a majority of movements is “debit”, not “credit”. Is it the case?
-- Yes. 
SELECT `movement`, count(`movement`) AS Total_Movement
FROM anz
GROUP BY `movement`;

-- 7)	What are the top 3 most important merchants (i.e., merchants with the most transactions)?
SELECT `first_name`, `merchant_id`, SUM(`amount`) AS Total_Transaction
FROM anz
GROUP BY `first_name`, `merchant_id`, `amount`
ORDER BY `amount` DESC
LIMIT 0, 3;

-- This method below calculates importance based on transaction amount. In this case, we are looking at transaction count.
SELECT `first_name`, `merchant_id`, SUM(`amount`) AS Total_Transaction
FROM anz
GROUP BY `first_name`, `merchant_id`, `amount`
ORDER BY `amount` DESC
LIMIT 0, 3;

-- 8)	For each state, what are the top 3 most important merchants?
WITH anz AS 
(	SELECT *, ROW_NUMBER() OVER (PARTITION BY `merchant_state` ORDER BY `amount` DESC) row_num
    FROM anz.anz
)
SELECT `merchant_state`, `first_name` as name, `amount` as Amount_Transacted
FROM anz
WHERE row_num <= 3;

-- This method below calculates importance based on transaction amount. 
WITH anz AS 
(	SELECT *, ROW_NUMBER() OVER (PARTITION BY `merchant_state` ORDER BY `amount` DESC) row_num
    FROM anz.anz
)
SELECT `merchant_state`, `first_name` as name, `amount` as Amount_Transacted
FROM anz
WHERE row_num <= 3;

-- 9)	For each state, what is the total amount of transactions? 
SELECT `merchant_state`, SUM(`amount`) AS transaction_amount
FROM anz
GROUP BY `merchant_state`;

-- 10)	Related to (3), does all merchants utilized all the available forms of transactions? Provide details.
SELECT first_name, count(`first_name`) AS COUNT_NAME, 
        (
        SELECT DISTINCT `txn_description` t
        FROM    anz.anz
        WHERE   `txn_description` = 'POS'
        ) AS TYPE_POS,
        (
        SELECT DISTINCT `txn_description` t
        FROM    anz.anz
        WHERE   `txn_description` = 'SALES-POS'
        ) AS TYPE_SALES_POS
FROM    anz.anz
GROUP BY `first_name`;