
# 📊 Stock Market Data Warehouse

This project implements a dimensional data warehouse model for analyzing historical stock market performance. It uses SQL-based OLAP queries, data cubes, and visualizations to deliver business intelligence insights to analysts and investors.

---

## 🚀 Project Summary

This data warehousing solution is designed to:
- Consolidate and structure daily stock performance data.
- Enable OLAP operations such as drill-down, roll-up, slice & dice.
- Support visualizations for stock metrics, volumes, and trends.
- Deliver actionable insights for forecasting and financial decision-making.

---

## 🧱 Data Model

**Fact Table**  
- `fact_stock_data`: Includes stock prices (open, close, high, low), adjusted close, volume, etc.

**Dimension Tables**  
- `dim_time`: Time attributes (date, month, year)  
- `dim_stock`: Stock tickers and company mapping  
- `dim_company`: Company names and ticker info  
- `dim_index`: Market index info and volumes  

---

## 📈 Visualizations

- Line plot: Stock close trends by year  
- Heatmap: Correlation matrix of stock variables  
- Area chart: Daily performance by day in month  
- Pie chart: Stock distribution by company  
- Treemap: Market capitalization by company  

---

## 🧠 Techniques Used

- Dimensional Modeling (Kimball Style)  
- SQL (PostgreSQL/Oracle)  
- OLAP (Slice, Dice, Drill-down, Roll-up)  
- Python (Matplotlib, Seaborn, Plotly)  
- Tableau for interactive dashboards  

---

## 📥 Report

🔗 [Final Project Report (PDF)](report/Report.pdf)

---

## 📚 References

- [Kimball Dimensional Modeling Techniques](https://www.kimballgroup.com/data-warehouse-business-intelligence-resources/kimball-techniques/)
- [Vertabelo Data Modeling Guide](https://www.vertabelo.com/blog/a-beginners-guide-to-data-modeling/)
