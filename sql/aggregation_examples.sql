Facilitates aggregation and comparison of index performance over time and across other dimensions.
Benefits of Hierarchies
Navigational Efficiency: Users can navigate through data dimensions intuitively, from higher-level summaries to detailed insights.
Analytical Flexibility: Supports drill-down, roll-up, and slice-and-dice operations for deeper analysis of data.
Aggregation Capabilities: Enables aggregation of data at various levels of granularity, enhancing analytical capabilities.

CREATE TABLE cube_stock_day AS
SELECT
d.TIME_ID,
d.TRADE_DATE,
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
d.TIME_ID,
d.TRADE_DATE,
s.STOCK_ID,
s.STOCK_TICKER;

