SELECT * FROM sql5.beverages;
SELECT * FROM sql5.pubs;
SELECT * FROM sql5.ratings;
SELECT * FROM sql5.sales;

1. How many pubs are located in each country??
SELECT COUNTRY,
       COUNT(PUB_ID) AS No_of_pubs
FROM PUBS
GROUP BY COUNTRY
ORDER BY No_of_pubs desc;       

2. What is the total sales amount for each pub, including the beverage price and quantity sold?
SELECT SUM(S.QUANTITY * B.PRICE_PER_UNIT) AS Total_sales,
       P.PUB_NAME AS Pubname,
       SUM(S.QUANTITY) AS QuantitySold
FROM SALES AS S
JOIN BEVERAGES AS B
ON B.BEVERAGE_ID = S.BEVERAGE_ID
JOIN PUBS AS P
ON P.PUB_ID = S.PUB_ID
GROUP BY PUBNAME
ORDER BY TOTAL_SALES DESC
;

3. Which pub has the highest average rating?
SELECT ROUND(AVG(R.RATING),2) AS AverageRating,
       P.PUB_NAME AS Pub
FROM RATINGS AS R
JOIN PUBS AS P
ON P.PUB_ID = R.PUB_ID
GROUP BY PUB
ORDER BY AVERAGERATING DESC
;       

4. What are the top 5 beverages by sales quantity across all pubs?
SELECT B.BEVERAGE_NAME AS Beverage,
       SUM(S.QUANTITY) as Sales_Quantity
FROM SALES AS S
JOIN BEVERAGES AS B
ON B.BEVERAGE_ID = S.BEVERAGE_ID
GROUP BY BEVERAGE
ORDER BY SALES_QUANTITY DESC
LIMIT 5
;       
       
5. How many sales transactions occurred on each date?
SELECT TRANSACTION_DATE,
	COUNT(SALE_ID) AS TRANSACTIONS
FROM SALES
GROUP BY 1;    

6. Find the name of someone that had cocktails and which pub they had it in.
SELECT R.CUSTOMER_NAME AS Customer,
       B.CATEGORY,
       P.PUB_NAME
FROM SALES AS S
JOIN RATINGS AS R
ON R.PUB_ID = S.PUB_ID
JOIN PUBS AS P 
ON P.PUB_ID = S.PUB_ID
JOIN BEVERAGES AS B
ON B.BEVERAGE_ID = S.BEVERAGE_ID
WHERE B.CATEGORY = "COCKTAIL"
;     

7. What is the average price per unit for each category of beverages, excluding the category 'Spirit'?
SELECT 
       CATEGORY,
       ROUND(AVG(PRICE_PER_UNIT),2) AS AveragePrice
FROM BEVERAGES
WHERE CATEGORY <> "SPIRIT"
GROUP BY 1
ORDER BY AVERAGEPRICE DESC
;       

8. Which pubs have a rating higher than the average rating of all pubs?
SELECT P.PUB_NAME, 
       R.RATING
FROM PUBS AS P
JOIN RATINGS AS R
ON P.PUB_ID = R.PUB_ID
WHERE R.RATING > (SELECT ROUND(AVG(RATING),1) FROM RATINGS)
ORDER BY P.PUB_ID;

9. What is the running total of sales amount for each pub, ordered by the transaction date?
SELECT P.PUB_ID as Pub_ID,
       S.TRANSACTION_DATE as Transaction_Date,
       SUM(S.QUANTITY*B.PRICE_PER_UNIT) OVER(PARTITION BY P.PUB_ID ORDER BY S.TRANSACTION_DATE) AS Runny_Total
FROM SALES AS S
JOIN BEVERAGES AS B
ON B.BEVERAGE_ID = S.BEVERAGE_ID
JOIN PUBS AS P
ON P.PUB_ID = S.PUB_ID
;

10. For each country, what is the average price per unit of beverages in each category, and what is the overall average price per unit of beverages across all categories?
SELECT P.COUNTRY,
       B.CATEGORY,
       ROUND(AVG(B.PRICE_PER_UNIT),2) AS Avg_per_Unit,
       AVG(AVG(B.PRICE_PER_UNIT)) OVER() as Overall_Avg_per_Unit
FROM SALES AS S
JOIN BEVERAGES AS B
ON B.BEVERAGE_ID = S.BEVERAGE_ID
JOIN PUBS AS P
ON P.PUB_ID = S.PUB_ID
GROUP BY 1,2
ORDER BY 1,2
;	



11. For each pub, what is the percentage contribution of each category of beverages to the total sales amount, and what is the pub overall sales amount?
SELECT P.PUB_NAME,
       B.CATEGORY,
       SUM(S.QUANTITY*B.PRICE_PER_UNIT) AS Total_sales_amount,
       SUM(SUM(S.QUANTITY*B.PRICE_PER_UNIT)) OVER(PARTITION BY P.PUB_NAME) AS Overall_sales_amount,
       (SUM(S.QUANTITY*B.PRICE_PER_UNIT) / SUM(SUM(S.QUANTITY*B.PRICE_PER_UNIT)) OVER(PARTITION BY P.PUB_NAME))*100 AS PERCENTAGE_CONTRIBUTION
FROM SALES AS S
JOIN BEVERAGES AS B
ON B.BEVERAGE_ID = S.BEVERAGE_ID
JOIN PUBS AS P
ON P.PUB_ID = S.PUB_ID
GROUP BY 1,2
ORDER BY 1,2;
