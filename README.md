# Brazilian E-Commerce Sales Performance Analysis

## Overview
Analysis of the Olist Brazilian e-commerce dataset covering 2016–2018 
transactions across 3,095 sellers, 71 product categories, and 96,096 
unique customers. The goal was to identify customer value patterns, 
seller performance, category revenue drivers, and order growth trends 
to support business decisions around loyalty programs, seller management, 
and inventory strategy.

## Tools
- **PostgreSQL** — data storage and querying
- **Power BI** — dashboard and visualization
- **GitHub** — version control and portfolio hosting

## Dataset
Brazilian E-Commerce Public Dataset by Olist (99,441 orders, 2016–2018)  
Source: [Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

## Schema
See `ERD.png` for the full entity relationship diagram showing how the 
9 tables connect.

## Dashboard
[View the live interactive dashboard](https://app.powerbi.com/groups/me/reports/4b1aa439-c3a7-49ce-863a-328a84cc796a/8c000590692d621488b9?experience=power-bi)

## Key Findings

**Customer lifetime value**
- Top 100 customers by lifetime value are predominantly one-time buyers, 
suggesting limited organic retention
- Total spend ranges from $13,664 to $2,430, indicating a long tail of 
high-value single transactions rather than repeat loyalty
- A loyalty program launch should account for the low repeat purchase rate 
across the platform

**Seller performance**
- Review scores and order volume show an inverse relationship among top 
sellers — high-volume sellers average lower scores, suggesting fulfillment 
quality may degrade at scale
- Analysis filtered to sellers with 10+ orders to ensure statistically 
meaningful review score averages

**Product category revenue**
- The top three categories — health beauty, watches gifts, and bed bath 
table — account for approximately 25.76% of total platform revenue
- Health beauty alone drives nearly 9.3% of total revenue, making it the 
single most important category for inventory and marketing investment

**Order volume and revenue trend**
- Platform launched with minimal activity in late 2016, growing rapidly 
through 2017
- Order volume grew from 913 in January 2017 to 8,475 in November 2017 
— approximately 828% growth in 11 months
- Revenue and volume remained strong through mid-2018
- Dataset filtered to delivered orders only — orders placed near the 
dataset cutoff (October 2018) may not appear due to pending delivery status

## Data Quality Notes
- Dataset ends in August 2018 for delivered orders despite orders existing 
through October 2018 — recent orders had not yet been delivered at time 
of dataset creation
- Initial CSV batch import caused empty table imports for several tables — 
each table was imported individually to resolve

## SQL Queries
See [`ecommerce_analysis.sql`](ecommerce_analysis.sql) for all queries including 
customer LTV analysis, seller performance, category revenue breakdown, 
and monthly order trends.
