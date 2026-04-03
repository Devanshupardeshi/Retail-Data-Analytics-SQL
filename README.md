<div align="center">
  <h1>📊 Retail Data Analytics & SQL Warehousing</h1>
  <p><strong>An industry-grade, end-to-end data engineering and analytics pipeline simulation.</strong></p>
  
  ![Project Banner](banner.png)

  <p>
    <img src="https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white" alt="PostgreSQL" />
    <img src="https://img.shields.io/badge/Advanced_SQL-blueviolet?style=for-the-badge" alt="Advanced SQL" />
    <img src="https://img.shields.io/badge/Data_Warehousing-orange?style=for-the-badge" alt="Data Warehousing" />
    <img src="https://img.shields.io/badge/ETL_Pipelines-yellow?style=for-the-badge" alt="ETL" />
    <img src="https://img.shields.io/badge/Star_Schema-lightgreen?style=for-the-badge" alt="Star Schema" />
  </p>

  <h3>
    <i>Data Modeling 🔹 ETL Pipeline Deployment 🔹 Advanced SQL Analytics</i>
  </h3>
</div>

---

## 🔍 Executive Summary  
This project builds a complete SQL Data Warehouse (Bronze → Silver → Gold) and performs advanced EDA + analytics to generate customer and product insights for a retail business.

---

## 📚 Table of Contents

- [🧩 Business Problem](#-business-problem)
- [🚀 Project Overview](#-project-overview)
- [🏗️ Project Architecture & Diagrams](#️-project-architecture--diagrams)
- [🏗️ Tech Stack](#️-tech-stack)
- [🧠 Key Skills Demonstrated](#-key-skills-demonstrated)
- [🗂️ Project Folder Structure](#️-project-folder-structure)
- [🛠️ Key Features](#-key-features)
- [📊 Reports Generated](#-reports-generated)
- [🧬 Data Architecture Flow](#-data-architecture-flow)
- [📁 Important Files](#-important-files)
- [📈 Key Outcomes](#-key-outcomes)
- [🎓 What I Will Learn](#-what-i-will-learn)
- [📥 Clone This Repository](#-clone-this-repository)
- [🏁 How to Run This Project](#-how-to-run-this-project)
- [⭐ Project Highlights (for Resume / Portfolio)](#-project-highlights-for-resume--portfolio)

---

# 🧩 Business Problem

> 🏪 **Retail Company Issue:**  
> Data scattered across ERP & CRM → no unified reporting → poor insights → inconsistent decisions.

You built a scalable **Data Warehouse + Analytics System** to solve:

- Scattered data  
- Inconsistent formats  
- No single source of truth  
- No customer or product performance tracking  
- No advanced reporting  

The result is a **clean, scalable, analytics-ready warehouse**.

---

# 🚀 Project Overview

This project demonstrates how to build and analyze a data warehouse environment using SQL.  
It includes:

### ✅ 1. Data Warehouse Development
- Data ingestion (Bronze layer)  
- Data cleaning & harmonization (Silver layer)  
- Business modeling & fact/dimension tables (Gold layer)  
- Stored procedures for ETL  
- Data quality testing  
- Documentation (data model, flow diagrams, architecture)

### ✅ 2. EDA + Advanced SQL Data Analysis
Using advanced SQL analytics techniques:
- Ranking  
- Segmentation  
- Cumulative metrics  
- Change-over-time analysis  
- Performance metrics  
- Customer & Product reports  
- KPI calculations  
- Exploratory Data Analysis insights  

### ✅ 3. Advanced Reporting
SQL-based dashboards & reports:
- **Customer Analytics Report**
- **Product Performance Report**

---

# 🏗️ Project Architecture & Diagrams

### 📌 Overall Architecture  
![Architecture](Data%20Warehouse/docs/data_architecture.png)

### 🕸 Mesh Architecture Layers  
![Mesh Architecture](Data%20Warehouse/docs/Mesh_Architecture_Layers.png)

### 🔗 Data Integration Workflow  
![Data Integration](Data%20Warehouse/docs/data_integration.png)

### 🔄 Data Flow Diagram  
![Data Flow](Data%20Warehouse/docs/data_flow.png)

### 🧩 Star Schema Data Model  
![Data Model](Data%20Warehouse/docs/data_model.png)

---

# 🏗️ Tech Stack

| Layer | Tools Used |
|------|------------|
| Data Warehouse | PostgreSQL / SQL |
| Data Modeling | Star Schema, Dimensional Modeling |
| ETL Pipeline | SQL Stored Procedures |
| EDA & Analytics | SQL (Window functions, Aggregations, CTEs) |
| Documentation | Markdown, PNG diagrams |

---

# 🧠 Key Skills Demonstrated

- Advanced SQL (Window Functions, CTEs, Ranking Functions)  
- Data Warehousing (Bronze–Silver–Gold architecture)  
- ETL Pipeline Development  
- Fact & Dimension Modeling  
- Data Cleaning & Standardization  
- Analytical Reporting & KPI Design  
- Data Architecture Documentation  

---

# 🗂️ Project Folder Structure

```
Advance-SQL-Project-Data-Warehousing-EDA-Advanced-Data-Analytics/
│
│── 📄 README.md                               ← Main Project Documentation
│── 📑 LICENSE                                  ← License for Project
│
├── 🧱 Data Warehouse/
│   │
│   ├── scripts/                                ← ETL Scripts for Bronze → Silver → Gold
│   │   ├── bronze/
│   │   │   ├── ddl_bronze.sql                  ← Create Bronze Layer Tables
│   │   │   └── proc_load_bronze.sql            ← Load Raw ERP + CRM Data into Bronze
│   │   │
│   │   ├── silver/
│   │   │   ├── ddl_silver.sql                  ← Create Cleaned Silver Layer Tables
│   │   │   └── proc_load_silver.sql            ← Transform Bronze → Silver
│   │   │
│   │   └── gold/
│   │       └── ddl_gold.sql                    ← Create Final Fact & Dimensions (DW)
│   │
│   ├── tests/                                  ← Data Quality & Validation Scripts
│   │   ├── quality_checks_gold.sql             ← Gold Layer Validation Tests
│   │   └── quality_checks_silver.sql           ← Silver Layer Validation Tests
│   │
│   ├── docs/                                   ← Architecture, Models & Pipeline Diagrams
│   │   ├── Analysing Source System.png         ← Source System Exploration
│   │   ├── data_architecture.png               ← Full Data Architecture Overview
│   │   ├── data_catalog.md                     ← Documentation for All Tables & Columns
│   │   ├── data_flow.png                       ← End-to-End Data Flow Diagram
│   │   ├── data_integration.png                ← ERP + CRM Integration Overview
│   │   ├── data_layers.pdf                     ← Bronze, Silver, Gold Explanation
│   │   ├── data_model.png                      ← Data Warehouse Star Schema
│   │   ├── ETL.png                             ← ETL Pipeline Overview
│   │   ├── Mesh_Architecture_Layers.png        ← Data Mesh Architecture Layers
│   │   └── naming_conventions.md               ← Standards for Naming Tables & Columns
│   │
│   └── row_dataset/                            ← Raw ERP & CRM Source System Data
│       ├── source_erp/
│       │   ├── CUST_AZ12.csv                   ← ERP Customer Data
│       │   ├── LOC_A101.csv                    ← ERP Location Data
│       │   └── PX_CAT_G1V2.csv                 ← ERP Product/Category Data
│       │
│       └── source_crm/
│           ├── cust_info.csv                   ← CRM Customer Info
│           ├── prd_info.csv                    ← CRM Product Info
│           └── sales_details.csv               ← CRM Sales Transactions
│
└── 📊 EDA + Advanced Data Analysis/
    │
    ├── Data Analysis .png                       ← EDA Output Summary Diagram
    │
    ├── scripts/                                 ← All SQL Scripts for Analysis
    │   ├── 00_init_database.sql                 ← Initialize Analysis Schema
    │   ├── 01_database_exploration.sql          ← Explore Tables & Metadata
    │   ├── 02_dimensions_exploration.sql        ← Explore Dimension Tables
    │   ├── 03_date_range_exploration.sql        ← Explore Date Ranges
    │   ├── 04_measures_exploration.sql          ← Explore Key Business Metrics
    │   ├── 05_magnitude_analysis.sql            ← Magnitude-Level Analysis
    │   ├── 06_ranking_analysis.sql              ← Ranking & Ordering Analysis
    │   ├── 07_change_over_time_analysis.sql     ← Trend + Time-Based Analysis
    │   ├── 08_cumulative_analysis.sql           ← Running Totals & Rolling Sums
    │   ├── 09_performance_analysis.sql          ← Performance & KPI Insights
    │   ├── 10_part_to_whole_analysis.sql        ← Proportional Contribution Analysis
    │   ├── 11_data_segmentation.sql             ← Customer & Product Segmentation
    │   ├── 12_report_customers.sql              ← Generate Customer Report (Gold Layer)
    │   └── 12_report_products.sql               ← Generate Product Report (Gold Layer)
    │
    └── dataset/                                 ← Output Reports from Gold Layer
        ├── gold.dim_customers.csv               ← Cleaned Customer Dimension
        ├── gold.dim_products.csv                ← Cleaned Product Dimension
        ├── gold.fact_sales.csv                  ← Cleaned Fact Sales Table
        ├── gold.report_customers.csv            ← Final Customer Analytics Report
        └── gold.report_products.csv             ← Final Product Analytics Report
```

---

# 🛠️ Key Features

### 🟩 Data Warehouse (Bronze → Silver → Gold)
- Raw data ingestion  
- Data profiling  
- Standardization & validation  
- Star schema modeling  
- Automated ETL procedures  
- Data quality tests  
- Complete documentation  

### 🟦 EDA + Advanced SQL Analytics
- Dimension exploration  
- Measures analysis  
- Ranking, segmentation  
- Time-series & cumulative trends  
- KPI calculations (Recency, AOV, Monthly Spend, etc.)  
- Customer & Product performance reports  

---

# 📊 Reports Generated

### 📘 Customer Report
Includes:
- Customer segments (VIP, Regular, New)
- Recency
- Lifespan
- Total orders, products, quantity, sales
- Avg order value
- Avg monthly spend  

### 📙 Product Report
Includes:
- Product segments (High Performer / Mid Range / Low Performer)
- Recency
- Lifespan
- Unique customers
- Avg selling price
- Monthly revenue  

---

# 🧬 Data Architecture Flow

```
RAW (ERP + CRM)
      ↓
BRONZE → Clean storage
      ↓
SILVER → Harmonized & Enriched Data
      ↓
GOLD → Final Fact + Dimension Tables
      ↓
ANALYTICS → Reports, KPIs, Dashboards
```

---

# 📁 Important Files

### 🔹 Data Warehouse Scripts

```
bronze/
    ddl_bronze.sql
    proc_load_bronze.sql
silver/
    ddl_silver.sql
    proc_load_silver.sql
gold/
    ddl_gold.sql
```

### 🔹 EDA SQL Scripts

```
00_init_database.sql  
01_database_exploration.sql  
02_dimensions_exploration.sql  
...  
12_report_customers.sql  
12_report_products.sql 
```

---

# 📈 Key Outcomes

- Built a fully functional SQL Data Warehouse  
- Designed & implemented ETL pipelines  
- Performed advanced SQL analytics  
- Designed star schema (Fact + Dimensions)  
- Developed customer & product analytical reports  
- Demonstrated real-world Data Engineer + Analyst workflow  

---

# 🎓 What I Will Learn

- How to design a Data Warehouse from scratch  
- How to build ETL pipelines (Bronze → Silver → Gold)  
- How to clean & transform raw data  
- How to write advanced SQL analytical scripts  
- How to generate customer & product insights using SQL  
- How to document a real-world data engineering project 

---

# 📥 Clone This Repository
```
git clone https://github.com/Devanshupardeshi/Retail-Data-Analytics-SQL.git
cd Retail-Data-Analytics-SQL
```

---

# 🏁 How to Run This Project

### 1. Initialize the Database
```
00_init_database.sql
```

### 2. Load Bronze Layer
```
proc_load_bronze.sql
```

### 3. Load Silver Layer
```
proc_load_silver.sql
```

### 4. Create Gold Layer
```
ddl_gold.sql
```

### 5. Run Analysis Scripts (00 → 12)
```
EDA + Advanced Data Analysis/scripts/
```

---

# ⭐ Project Highlights (for Resume / Portfolio)

- Real-world **Data Engineering + Analytics** workflow  
- End-to-end SQL project (**Data Warehousing + EDA + Advanced Data Analysis**)
- Realistic **ETL + Data Modeling** experience  
- Clean architecture & documentation  
- Retail analytics insights  
- Strong **Analytics + Business Insights** generation  
- Showcases SQL expertise at scale
