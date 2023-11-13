SELECT * FROM sql4.accounts;
SELECT * FROM sql4.BRANCHES;
SELECT * FROM sql4.customers;
SELECT * FROM sql4.transactions;

1. What are the names of all the customers who live in New York?
SELECT CONCAT(FIRSTNAME,LASTNAME) AS Name
FROM CUSTOMERS
WHERE CITY = "NEW YORK";       

2. What is the total number of accounts in the Accounts table?
SELECT COUNT(ACCOUNTID) AS Total_no_of_accounts
FROM ACCOUNTS;

3. What is the total balance of all checking accounts?
SELECT SUM(BALANCE) AS Total_Balance
FROM ACCOUNTS
WHERE ACCOUNTTYPE = "CHECKING";

4. What is the total balance of all accounts associated with customers who live in Los Angeles?
SELECT SUM(A.BALANCE) AS Total_Balance
FROM ACCOUNTS AS A
JOIN CUSTOMERS AS C
ON C.CUSTOMERID = A.CUSTOMERID
WHERE C.CITY = "LOS ANGELES";

5. Which branch has the highest average account balance?
SELECT B.BRANCHNAME AS Branch,
       AVG(A.BALANCE) AS Highest_avg_account_balance
FROM BRANCHES AS B
JOIN ACCOUNTS AS A
ON A.BRANCHID = B.BRANCHID
GROUP BY B.BRANCHNAME
ORDER BY AVG(A.BALANCE) DESC
LIMIT 1;       
       

6. Which customer has the highest current balance in their accounts?
SELECT CONCAT(C.FIRSTNAME,C.LASTNAME) AS Customer,
       MAX(A.BALANCE) AS BALANCE
FROM CUSTOMERS AS C
JOIN ACCOUNTS AS A
ON A.CUSTOMERID = C.CUSTOMERID
GROUP BY CUSTOMER
ORDER BY BALANCE DESC
LIMIT 1;       

7. Which customer has made the most transactions in the Transactions table?
SELECT CONCAT(C.FIRSTNAME,C.LASTNAME) AS CUSTOMER,
       COUNT(T.TRANSACTIONID) AS Transactions
FROM ACCOUNTS AS A
JOIN CUSTOMERS AS C
ON C.CUSTOMERID = A.CUSTOMERID
JOIN TRANSACTIONS AS T
ON T.ACCOUNTID = A.ACCOUNTID
GROUP BY CUSTOMER
ORDER BY TRANSACTIONS DESC
LIMIT 2
;

8.Which branch has the highest total balance across all of its accounts?
SELECT B.BRANCHNAME AS Branch_Name,
       SUM(A.BALANCE) AS Balance
FROM BRANCHES AS B
JOIN ACCOUNTS AS A
ON A.BRANCHID = B.BRANCHID
GROUP BY BRANCH_NAME
ORDER BY BALANCE DESC
LIMIT 1
;

9. Which customer has the highest total balance across all of their accounts, including savings and checking accounts?
SELECT CONCAT(C.FIRSTNAME,C.LASTNAME) AS Customer,
       SUM(A.BALANCE) AS Total_Balance
FROM ACCOUNTS AS A
JOIN CUSTOMERS AS C
ON C.CUSTOMERID = A.CUSTOMERID
GROUP BY CUSTOMER
ORDER BY TOTAL_BALANCE DESC
LIMIT 1
;        

10. Which branch has the highest number of transactions in the Transactions table?
SELECT B.BRANCHNAME AS Branch_Name,
       COUNT(T.TRANSACTIONID) AS No_of_Transactions
FROM ACCOUNTS AS A
JOIN BRANCHES AS B
ON B.BRANCHID = A.BRANCHID
JOIN TRANSACTIONS AS T
ON T.ACCOUNTID = A.ACCOUNTID
GROUP BY BRANCH_NAME
ORDER BY NO_OF_TRANSACTIONS DESC
LIMIT 2
;       
