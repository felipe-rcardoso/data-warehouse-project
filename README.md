# Data Warehouse and Analytics Project

This project is a data warehousing and analytics solution built on Databricks, from ingesting raw data to generating actionable insights. I load sales data from two source systems (ERP and CRM) as CSV files using Python, then clean and model it through the Bronze, Silver and Gold layers to answer business questions with SQL. Designed as a portfolio project, it applies industry best practices in data engineering and analytics.

> Inspired by Data With Baraa's SQL Data Warehouse project, re-implemented with Python and Databricks.

---

## 🏗️ Data Architecture

The data architecture follows the Medallion Architecture with **Bronze**, **Silver**, and **Gold** layers:

<img width="563" height="411" alt="image" src="https://github.com/user-attachments/assets/ddfd14b9-721c-4f9e-a635-930286bb4a60" />

1. **Bronze Layer**: Stores raw data as-is from the source systems. CSV files are ingested into Databricks using Python.
2. **Silver Layer**: Applies data cleansing, standardization, and normalization to prepare data for analysis.
3. **Gold Layer**: Houses business-ready data modeled into a star schema for reporting and analytics.

---

## 📖 Project Overview

This project involves:

1. **Data Architecture**: Designing a modern data warehouse on Databricks using the Medallion Architecture (**Bronze**, **Silver**, **Gold**).
2. **Data Ingestion**: Loading source CSV files into Databricks with Python.
3. **ETL Pipelines**: Transforming and moving data across the Bronze, Silver, and Gold layers.
4. **Data Modeling**: Developing fact and dimension tables optimized for analytical queries.
5. **Analytics & Reporting**: Creating SQL-based analysis to generate actionable insights.

🎯 Skills demonstrated:

- SQL Development
- Python
- Databricks
- Data Architecture
- Data Engineering
- ETL Pipeline Development
- Data Modeling
- Data Analytics

---

## 🛠️ Tools & Technologies

- **Python**: Ingestion of CSV files into Databricks.
- **Databricks**: Platform used to build and run the Medallion Architecture.
- **SQL**: Transformations, data modeling, and analytics.
- **Git / GitHub**: Version control and project management.
- **DrawIO**: Design of data architecture, data models, and data flows.
- **[Datasets](datasets/)**: Source data from the ERP and CRM systems (CSV files).

---

## 🚀 Project Requirements

### Building the Data Warehouse (Data Engineering)

#### Objective

Develop a modern data warehouse on Databricks to consolidate sales data, enabling analytical reporting and informed decision-making.

#### Specifications

- **Data Sources**: Import data from two source systems (ERP and CRM) provided as CSV files.
- **Data Quality**: Cleanse and resolve data quality issues prior to analysis.
- **Integration**: Combine both sources into a single, user-friendly data model designed for analytical queries.
- **Scope**: Focus on the latest dataset only; historization of data is not required.
- **Documentation**: Provide clear documentation of the data model to support both business stakeholders and analytics teams.

---

### BI: Analytics & Reporting (Data Analysis)

#### Objective

Develop SQL-based analytics to deliver detailed insights into:

- **Customer Behavior**
- **Product Performance**
- **Sales Trends**

These insights provide stakeholders with key business metrics to support strategic decision-making.

---

## 👤 About Me

I'm **Felipe**, a Data Analyst / Data Engineer based in Dublin, Ireland, with 9+ years of experience across data universe.

