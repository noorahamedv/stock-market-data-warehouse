CREATE TABLE cube_stock_week AS
SELECT
TO_CHAR(d.TRADE_DATE, 'IW') AS WEEK_NUMBER, -- Week number based on ISO week date
TO_CHAR(d.TRADE_DATE, 'YYYY') AS YEAR,
s.STOCK_ID,
s.STOCK_TICKER,
SUM(f.STOCK_OPEN) AS TOTAL_OPEN,
SUM(f.STOCK_HIGH) AS TOTAL_HIGH,
SUM(f.STOCK_LOW) AS TOTAL_LOW,
SUM(f.STOCK_CLOSE) AS TOTAL_CLOSE,
SUM(f.STOCK_ADJ_CLOSE) AS TOTAL_ADJ_CLOSE,
SUM(f.STOCK_VOLUME) AS TOTAL_VOLUME
FROM
fact_stock_data f
JOIN dim_time d ON f.TIME_ID = d.TIME_ID
JOIN dim_stock s ON f.STOCK_ID = s.STOCK_ID
GROUP BY
TO_CHAR(d.TRADE_DATE, 'IW'),
TO_CHAR(d.TRADE_DATE, 'YYYY'),
s.STOCK_ID,
s.STOCK_TICKER;

CREATE TABLE cube_stock_month AS
SELECT
TO_CHAR(d.TRADE_DATE, 'YYYY-MM') AS MONTH,
s.STOCK_ID,
s.STOCK_TICKER,
SUM(f.STOCK_OPEN) AS TOTAL_OPEN,
SUM(f.STOCK_HIGH) AS TOTAL_HIGH,
SUM(f.STOCK_LOW) AS TOTAL_LOW,
SUM(f.STOCK_CLOSE) AS TOTAL_CLOSE,
SUM(f.STOCK_ADJ_CLOSE) AS TOTAL_ADJ_CLOSE,
SUM(f.STOCK_VOLUME) AS TOTAL_VOLUME
FROM
fact_stock_data f
JOIN dim_time d ON f.TIME_ID = d.TIME_ID
JOIN dim_stock s ON f.STOCK_ID = s.STOCK_ID
GROUP BY
TO_CHAR(d.TRADE_DATE, 'YYYY-MM'),
s.STOCK_ID,
s.STOCK_TICKER;
Explanation:
Dimension Tables (dim_time, dim_stock): These tables are joined with fact_stock_data to associate time-related and stock-related attributes with the aggregated measures.
Grouping and Aggregation: SUM() functions aggregate numeric measures (STOCK_OPEN, STOCK_HIGH, etc.) based on the specified grouping criteria (TIME_ID, TRADE_DATE, STOCK_ID, STOCK_TICKER).
Time Formatting: TO_CHAR() functions are used to format dates into week numbers ('IW' for ISO week number) and month ('YYYY-MM' for year-month format) for grouping by week and month respectively.
Table Creation: Results are stored in new tables (cube_stock_day, cube_stock_week, cube_stock_month) representing different levels of aggregation.
Considerations:
Performance: Ensure indexes are properly defined on join columns (TIME_ID, STOCK_ID) and where clauses to optimize query performance.
ETL Process: These queries can be integrated into your ETL process to automate the creation and maintenance of data cubes as new data is loaded.
Query Optimization: Monitor query performance and consider partitioning large tables or using materialized views for further optimization.
OLAP Queries Using
Here are examples of OLAP queries using   to demonstrate common operations:
1. Slice-and-Dice Operation
Slice: Selecting a subset of data along one dimension.
-- Example: Slice by a specific time period (e.g., year 2023)
SELECT
t.YEAR_NAME,
s.COMPANY_NAME,
AVG(f.STOCK_CLOSE) AS AVG_STOCK_CLOSE
FROM
fact_stock_data f
JOIN dim_time t ON f.TIME_ID = t.TIME_ID
JOIN dim_stock s ON f.STOCK_ID = s.STOCK_ID
WHERE
t.YEAR_NAME = '2023'
GROUP BY
t.YEAR_NAME,
s.COMPANY_NAME;

Dice: Selecting a subset of data along multiple dimensions.
-- Example: Dice by year and stock ticker
SELECT
t.YEAR_NAME,
s.STOCK_TICKER,
AVG(f.STOCK_CLOSE) AS AVG_STOCK_CLOSE
FROM
fact_stock_data f
JOIN dim_time t ON f.TIME_ID = t.TIME_ID
JOIN dim_stock s ON f.STOCK_ID = s.STOCK_ID
WHERE
t.YEAR_NAME IN ('2022', '2023')
GROUP BY
t.YEAR_NAME,
s.STOCK_TICKER;

SELECT
t.MONTH_NAME,
t.DAY_NAME,
s.COMPANY_NAME,
AVG(f.STOCK_CLOSE) AS AVG_STOCK_CLOSE
FROM
fact_stock_data f
JOIN dim_time t ON f.TIME_ID = t.TIME_ID
JOIN dim_stock s ON f.STOCK_ID = s.STOCK_ID
WHERE
t.MONTH_NAME = 'June'
AND s.COMPANY_NAME = 'Company XYZ'
GROUP BY
t.MONTH_NAME,
t.DAY_NAME,
s.COMPANY_NAME;

SELECT
t.MONTH_NAME,
AVG(f.STOCK_CLOSE) AS AVG_STOCK_CLOSE
FROM
fact_stock_data f
JOIN dim_time t ON f.TIME_ID = t.TIME_ID
JOIN dim_index i ON f.STOCK_ID = i.INDEX_ID
WHERE
t.YEAR_NAME = '2023'
AND i.INDEX_NAME = 'S&P 500'
GROUP BY
t.MONTH_NAME;

SELECT
s.STOCK_TICKER,
AVG(f.STOCK_CLOSE) AS avg_stock_close
FROM
fact_stock_data f
JOIN dim_stock s ON f.STOCK_ID = s.STOCK_ID
GROUP BY
s.STOCK_TICKER
ORDER BY
avg_stock_close DESC
LIMIT 10;

  Monthly Average Stock Prices Over Years:
SELECT
TO_CHAR(t.TRADE_DATE, 'YYYY-MM') AS month_year,
AVG(f.STOCK_CLOSE) AS avg_stock_close
FROM
fact_stock_data f
JOIN dim_time t ON f.TIME_ID = t.TIME_ID
GROUP BY
TO_CHAR(t.TRADE_DATE, 'YYYY-MM')
ORDER BY
month_year;

SELECT
s.STOCK_TICKER,
AVG(f.STOCK_VOLUME) AS avg_stock_volume
FROM
fact_stock_data f
JOIN dim_stock s ON f.STOCK_ID = s.STOCK_ID
GROUP BY
s.STOCK_TICKER
ORDER BY
avg_stock_volume DESC;

SELECT
TO_CHAR(t.TRADE_DATE, 'YYYY') AS year,
TO_CHAR(t.TRADE_DATE, 'MM') AS month,
COUNT(*) AS num_records
FROM
fact_stock_data f
JOIN dim_time t ON f.TIME_ID = t.TIME_ID
GROUP BY
TO_CHAR(t.TRADE_DATE, 'YYYY'),
TO_CHAR(t.TRADE_DATE, 'MM')
ORDER BY
year, month;

SELECT
s.STOCK_TICKER,
MAX(f.STOCK_HIGH) - MIN(f.STOCK_LOW) AS daily_range
FROM
fact_stock_data f
JOIN dim_stock s ON f.STOCK_ID = s.STOCK_ID
GROUP BY
s.STOCK_TICKER
ORDER BY
daily_range DESC;

SELECT
TO_CHAR(t.TRADE_DATE, 'YYYY-MM') AS month_year,
SUM(f.STOCK_VOLUME) AS total_volume
FROM
fact_stock_data f
JOIN dim_time t ON f.TIME_ID = t.TIME_ID
GROUP BY
TO_CHAR(t.TRADE_DATE, 'YYYY-MM')
ORDER BY
month_year;

SELECT
t.DAY_NAME,
AVG(f.STOCK_CLOSE) AS avg_stock_close
FROM
fact_stock_data f
JOIN dim_time t ON f.TIME_ID = t.TIME_ID
GROUP BY
t.DAY_NAME
ORDER BY
CASE t.DAY_NAME
WHEN 'Monday' THEN 1
WHEN 'Tuesday' THEN 2
WHEN 'Wednesday' THEN 3
WHEN 'Thursday' THEN 4
WHEN 'Friday' THEN 5
WHEN 'Saturday' THEN 6
WHEN 'Sunday' THEN 7
END;

SELECT
t.TRADE_DATE,
SUM(f.STOCK_VOLUME) AS total_volume
FROM
fact_stock_data f
JOIN dim_time t ON f.TIME_ID = t.TIME_ID
GROUP BY
t.TRADE_DATE
ORDER BY
total_volume DESC
LIMIT 10;

SELECT
TO_CHAR(t.TRADE_DATE, 'YYYY-MM') AS month_year,
AVG(f.STOCK_ADJ_CLOSE) AS avg_adj_close_price
FROM
fact_stock_data f
JOIN dim_time t ON f.TIME_ID = t.TIME_ID
JOIN dim_stock s ON f.STOCK_ID = s.STOCK_ID
WHERE
s.STOCK_TICKER = 'AAPL'  -- Example: Replace with specific stock ticker
GROUP BY
TO_CHAR(t.TRADE_DATE, 'YYYY-MM')
ORDER BY
month_year;

SELECT
TO_CHAR(t.TRADE_DATE, 'IW') AS week_number,
TO_CHAR(t.TRADE_DATE, 'YYYY') AS year,
s.STOCK_TICKER,
MAX(f.STOCK_HIGH) AS weekly_high,
MIN(f.STOCK_LOW) AS weekly_low
FROM
fact_stock_data f
JOIN dim_time t ON f.TIME_ID = t.TIME_ID
JOIN dim_stock s ON f.STOCK_ID = s.STOCK_ID
GROUP BY
TO_CHAR(t.TRADE_DATE, 'IW'),
TO_CHAR(t.TRADE_DATE, 'YYYY'),
s.STOCK_TICKER
ORDER BY
year, week_number, s.STOCK_TICKER;

Example: Calculate the Change in Stock Price Over Time
SELECT
t.TRADE_DATE,
s.STOCK_TICKER,
f.STOCK_CLOSE,
LAG(f.STOCK_CLOSE) OVER (PARTITION BY f.STOCK_ID ORDER BY t.TRADE_DATE) AS prev_close,
f.STOCK_CLOSE - LAG(f.STOCK_CLOSE) OVER (PARTITION BY f.STOCK_ID ORDER BY t.TRADE_DATE) AS price_change
FROM
fact_stock_data f
JOIN dim_time t ON f.TIME_ID = t.TIME_ID
JOIN dim_stock s ON f.STOCK_ID = s.STOCK_ID
ORDER BY
t.TRADE_DATE;
This query calculates the change in stock price (price_change) compared to the previous trading day (LAG(f.STOCK_CLOSE)).

2. NTILE Function
NTILE: Divides the result set into a specified number of groups or "buckets".
Example: Assign Quartiles Based on Stock Closing Price
SELECT
t.TRADE_DATE,
s.STOCK_TICKER,
f.STOCK_CLOSE,
NTILE(4) OVER (PARTITION BY s.STOCK_TICKER ORDER BY f.STOCK_CLOSE) AS quartile
FROM
fact_stock_data f
JOIN dim_time t ON f.TIME_ID = t.TIME_ID
JOIN dim_stock s ON f.STOCK_ID = s.STOCK_ID
ORDER BY
s.STOCK_TICKER, f.STOCK_CLOSE;
In this query, NTILE(4) partitions the data by STOCK_TICKER and assigns quartiles based on the STOCK_CLOSE values.

3. CORR Function
CORR: Calculates the correlation coefficient between two numeric columns.
Example: Calculate Correlation Between Stock Prices and Volumes
SELECT
s.STOCK_TICKER,
CORR(f.STOCK_CLOSE, f.STOCK_VOLUME) AS correlation_stock_close_volume
FROM
fact_stock_data f
JOIN dim_stock s ON f.STOCK_ID = s.STOCK_ID
GROUP BY
s.STOCK_TICKER;
This query computes the correlation coefficient (correlation_stock_close_volume) between STOCK_CLOSE and STOCK_VOLUME for each stock ticker.

Price Change Analysis: Use LAG/LEAD to analyze trends and changes over time, such as daily price changes or sequential movements in stock data.
Segmentation and Ranking: NTILE can help categorize data into groups based on specified criteria, useful for quartiles, percentiles, or other segmentations.
Correlation Analysis: CORR facilitates understanding relationships between variables, aiding in identifying factors influencing stock performance.
Data Visualization:
a) Stock Performance Over Time:

To further analyze the stock market data, an area chart was created using Tableau to visualize the volume, adjusted closing prices, and high prices of stocks over the days in a month. This visualization helps in understanding the daily performance and activity levels in the stock market.
The area chart of stock market performance by day in the month is a valuable tool for visualizing and analyzing daily market activities. It aids investors and analysts in understanding trading patterns, market stability, and the level of participation, thereby supporting informed decision-making in stock investments.

e) Correlation Matrix of Stock Variables

To analyze the relationships between different stock variables, a correlation matrix was created using Python. This visualization helps in understanding how various stock metrics are correlated with each other.

The heatmap illustrates the correlation matrix of stock close prices, volumes, open prices, high prices, and low prices, providing a visual representation of the strength and direction of correlations.

To analyze the trends in stock prices over the years, a line plot was created using Python. This visualization helps in understanding the changes in average stock close prices over a span of several years.

The line plot illustrates the average stock close prices by year, providing a visual representation of how stock prices have trended over time.

