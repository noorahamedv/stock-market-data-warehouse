# 📊 Stock Market Data Warehouse

> A dimensional modeling project for analyzing daily stock market performance using OLAP and interactive dashboards.

---

## 🚀 Overview

This project implements a **data warehouse** to consolidate and analyze historical **stock market performance**. Designed for analysts, data scientists, and investors, the system enables multidimensional insights through SQL-based OLAP operations and data visualization.

---

## 🎯 Objectives

- ✅ Model daily stock data using dimensional techniques  
- ✅ Perform OLAP operations: **drill-down**, **roll-up**, **slice & dice**  
- ✅ Generate actionable insights for **trend analysis** & **forecasting**  
- ✅ Support visualizations for volumes, metrics, and company-wise analysis

---

## 🧱 Data Warehouse Schema

### 🧮 Fact Table

- **`fact_stock_data`**  
  Stores daily stock metrics:
  - Open, Close, High, Low
  - Adjusted Close
  - Trading Volume

### 🧾 Dimension Tables

- **`dim_time`**  
  Stores date, day, month, quarter, year

- **`dim_stock`**  
  Stores ticker symbol, ISIN, and exchange

- **`dim_company`**  
  Contains company name, sector, and region

- **`dim_index`**  
  Market index name, classification, volume type

---

## 📊 Visualizations

Interactive dashboards and plots reveal patterns and insights:

- 📈 **Line Plot** – Closing price trends over time  
- 🧊 **Heatmap** – Correlation between stock metrics  
- 📅 **Area Chart** – Daily performance in a calendar view  
- 🧩 **Treemap** – Market capitalization by company  
- 🥧 **Pie Chart** – Distribution of tickers by sector or region

---

## 🧠 Techniques & Tools

- 🧰 Dimensional Modeling (Kimball Style)  
- 🗄️ SQL (PostgreSQL / Oracle)  
- 🧪 OLAP operations (Slice, Dice, Drill-down, Roll-up)  
- 🐍 Python (Pandas, Matplotlib, Seaborn, Plotly)  
- 📊 Tableau for interactive dashboards & storytelling

---

## 📥 Deliverables

📄 **[Final Report (PDF)](report/Report.pdf)**  
📦 ERD Diagram, SQL Scripts, Visualizations

---

## 📚 References

- 📘 [Kimball Dimensional Modeling Techniques](https://www.kimballgroup.com/data-warehouse-business-intelligence-resources/kimball-techniques/)  
- 📘 [Vertabelo Data Modeling Guide](https://www.vertabelo.com/blog/a-beginners-guide-to-data-modeling/)

---


