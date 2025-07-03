SELECT * FROM KMS;

--Q1. Which product category had the highest sales?
SELECT Top 1 Product_Category,
SUM(Sales) AS Total_Sales
FROM KMS
Group by Product_Category
Order by Total_Sales;

--Q2. What are the Top 3 and Bottom 3 regions in terms of sales?
--TOP 3 SALES
SELECT Top 3 Region,
SUM(Sales) AS Total_Sales
FROM KMS
Group by Region
Order by Total_Sales Desc;

--BOTTOM 3 SALES
SELECT Top 3 Region,
SUM(Sales) AS Total_Sales
FROM KMS
Group by Region
Order by Total_Sales Asc;

--Q3. What were the total sales of appliances in Ontario?
Select Product_Sub_Category, Region,
SUM(Sales) AS Total_Sales
FROM KMS
WHERE Product_Sub_Category = 'Appliances' AND Region = 'Ontario'
Group by Product_Sub_Category,Region
Order by Total_Sales Desc;

--Q4. Advise the management of KMS on what to do to increase the revenue from the bottom 10 Customers
Select Top 10 Order_ID, Customer_Name, Region,
COUNT( DISTINCT Order_ID) AS Total_Orders,
Sum(Order_Quantity * Unit_Price) AS Total_Revenue,
AVG(Sales) AS Total_Average_Sales
FROM KMS
Group by Order_ID, Customer_Name, Region
Order by Total_Revenue Asc;

/*
RECOMMENDATIONS FOR KMS MANAGEMENT
The bottom 10 customers all made only 1 order, with low total revenue (mostly below $4). This suggests low engagement and low customer value.

 ACTIONS TO TAKE:
	- Customer Re-engagement Campaign:
Send personalized emails or SMS with exclusive offers to encourage a second purchase.
Offer a small discount or bonus item for their next order.

	- Introduce Loyalty Programs:
Reward repeat purchases to turn one-time buyers into loyal customers.

	- Upsell and Cross-sell:
Suggest complementary or higher-margin products based on their previous purchase.

	- Segment-Based Offers:
Target low-performing regions (e.g., Quebec, West, Atlantic) with region-specific deals.

	- Collect Feedback:
Ask for feedback on their first purchase experience to understand barriers to returning.
*/

--Q5. KMS incurred the most shipping cost using which shipping method?
select Top 3 Ship_Mode, Shipping_Cost,
MAX(Shipping_Cost) AS Total_Shipping_Cost
FROM KMS
Group by Ship_Mode, Shipping_Cost
Order by Total_Shipping_Cost Desc;

--Q6. Who are the most valuable customers, and what products or services do they typically purchase?
select Top 10 Customer_Name, Product_Name, Product_Category,
SUM(Sales) AS Category_Sales
From KMS
Group by Customer_Name, Product_Name, Product_Category
Order by Category_Sales Desc;

--Q7. Which small business customer had the highest sales?
Select Top 3 Customer_Name, 
SUM(Sales) AS Total_Sales
FROM KMS
WHERE Customer_Segment = 'small business'
Group by Customer_Name
Order by Total_Sales Desc;

--Q8. Which Corporate Customer placed the most number of orders in 2009 – 2012?
Select Top 1 Customer_Name, Customer_Segment,
COUNT (Order_Quantity) AS Order_Count
FROM KMS
WHERE Order_Year between 2009 and 2012 
And Customer_Segment = 'Corporate'
Group by Customer_Name, Customer_Segment
Order by Order_Count Desc;

--Q9. Which consumer customer was the most profitable one?
SELECT Top 1 Customer_Name, Profit,
Sum(Profit) AS Total_Profit
FROM KMS 
WHERE Customer_Segment = 'Consumer'
Group by Customer_Name, Profit
Order by Total_Profit Desc;


--Q10. Which customer returned items, and what segment do they belong to?
Select Customer_Name, Customer_Segment, Status
FROM KMS
WHERE Status = 'Returned';

/* Q11. If the delivery truck is the most economical but the slowest shipping method and 
Express Air is the fastest but the most expensive one, do you think the company 
appropriately spent shipping costs based on the Order Priority? Explain your answer */

SELECT  Order_ID,
		Order_Priority, 
	    Ship_Mode,
COUNT(Distinct Order_ID) AS Order_Count, 
ROUND(SUM(Sales - Profit),2) AS Estimated_Shipping_Cost,
AVG(DATEDIFF(day, [Order_Date], [Ship_Date])) AS Avg_Ship_Days
FROM KMS
GROUP BY Order_Priority, Ship_Mode, Order_ID
ORDER BY Order_Priority, Ship_Mode Asc;

/*
			   Assessment of Shipping Cost vs Order Priority
Critical orders used Express Air only 12% of the time; too low for high urgency.
			  	Low and Not Specified orders used Express Air unnecessarily, increasing costs.
				Medium priority orders had a good balance of cost and speed.
				High priority orders leaned too much on slower modes.

				Conclusion
The company did not align shipping methods appropriately with order priorities. 
Urgent orders were not shipped fast enough, while low-priority ones sometimes used costly methods.

        Recommendation
Improve shipping policies to:
Use faster methods for high-priority orders.
Use economical methods for low or unspecified priorities. */

