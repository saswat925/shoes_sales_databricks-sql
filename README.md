# shoes_sales_databricks-sql

# 👟 Shoe Sales Data Analysis (SQL)

## 📋 Project Overview
This project provides a deep-dive analysis into a shoe sales dataset consisting of 1,000 transactions. Using SQL, I performed a full data lifecycle process—from raw data ingestion and rigorous cleaning/validation to extracting high-level business insights regarding brand performance, regional trends, and monthly growth patterns.

## 🛠️ Skills & Tools
*   **SQL Dialect:** Databricks / Spark SQL
*   **Data Cleaning:** Handling decimal precision, null/blank checks, and duplicate removal[cite: 1]
*   **Advanced SQL:** Window Functions (`LAG`, `OVER`), Date Truncation, and Aggregations[cite: 1]
*   **Concepts:** Data Integrity, Sales Validation, MoM Growth Analysis[cite: 1]

## 🔍 Data Cleaning & Validation Process
Before analysis, I ensured the dataset's integrity through several validation steps:
*   **Duplicate Check:** Verified 1,000 unique rows with zero duplicates[cite: 1].
*   **Null & Blank Check:** Confirmed zero null or empty values across all primary columns[cite: 1].
*   **Financial Accuracy:** Resolved revenue mismatches by rounding `Price * Units_Sold` to 2 decimal places to account for floating-point precision[cite: 1].
*   **Sanity Checks:** Confirmed no negative values for pricing/units and no future-dated transactions[cite: 1].

## 📈 Key Business Insights

### 1. Sales Performance
*   **Total Revenue:** $1,453,186.03[cite: 1]
*   **Market Leaders:** **Skechers** is the top-performing brand ($269,168.63), while **Nike** recorded the lowest revenue in this dataset[cite: 1].
*   **Geographic Trends:** **UAE** leads in revenue ($230,549.94), whereas **India** currently shows the lowest sales volume ($177,959.76)[cite: 1].

### 2. Product & Channel Analysis
*   **Best Seller:** **Sneakers** are the most popular category, generating $283,215.03 in revenue with 1,979 units sold[cite: 1].
*   **Color Preference:** **Blue** is the most preferred color (1,923 units), while **White** is the least popular (1,494 units)[cite: 1].
*   **Channel Contribution:** **Retail Stores** generated the highest total revenue, but **Online** sales maintain a strong contribution at **32.19%**[cite: 1].

### 3. Growth & Volatility
*   **Highest Growth:** Month 10 (October) saw a massive **+53.21%** spike in revenue[cite: 1].
*   **Biggest Decline:** Month 8 (August) experienced a significant drop of **-31.35%**[cite: 1].
*   **Trend:** Revenue showed a gradual increasing trend from January towards the end of the year[cite: 1].

## 📁 File Structure
*   `shoes_sales.sql`: Contains the full SQL script with cleaning, validation, and analysis queries[cite: 1].
*   `README.md`: Documentation of the analysis and findings.
