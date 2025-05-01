# 📊 Layoffs Data Cleaning Project

This project demonstrates a complete **SQL data cleaning pipeline** for a dataset of company layoffs.
The goal is to transform raw, messy data into a **clean, analysis-ready dataset** by handling duplicates, 
standardizing values, and removing nulls.

---

## 🔍 Project Overview
  
      This project takes a raw `layoffs.csv` dataset and applies **SQL-based data cleaning** to ensure consistency,
      remove duplicates, and handle missing values.  
      The process is divided into three main stages:
      
      1. **Removing Duplicates** – Identifying and eliminating duplicate records.  
      2. **Standardizing Data** – Fixing inconsistent formatting (company names, industries, countries, dates).  
      3. **Handling Null Values** – Imputing or removing missing data where necessary.
      
      The final output is a **clean dataset ready for analysis**.

---

## 🗂 Project Structure

  layoffs-data-cleaning/
  
      ├── layoffs.csv                         # Original dataset in CSV format
      ├── layoffs_staging.sql                 # SQL to create and populate the first staging table
      ├── layoffs_staging2.sql                # SQL to create and populate the second staging table with row numbers
  
  ├── layoffs-data-cleaning-queries/   

        ├── remove_duplicates.sql
        ├── standardizing_data.sql
        └── removing_nulls.sql
  
  └── README.md                           # Project documentation


  
---

## 🧹 Data Cleaning Steps

### 1️⃣ Removing Duplicates (`remove_duplicates.sql`)
- Created a staging table (`layoffs_staging`) to preserve original data.
- Added `ROW_NUMBER()` to identify duplicate rows.
- Deleted duplicates where `row_num > 1`.

### 2️⃣ Standardizing Data (`standardizing_data.sql`)
- Trimmed whitespace from `company` names.
- Unified inconsistent `industry` values (e.g., "Crypto startup" → "Crypto").
- Fixed `country` name typos (e.g., "United State" → "United States").
- Converted `date` strings to SQL `DATE` format using `STR_TO_DATE()`.

### 3️⃣ Handling Null Values (`removing_nulls.sql`)
- Replaced empty strings with `NULL` for consistency.
- Filled missing `industry` values based on other records from the same company.
- Deleted records with both `total_laid_off` and `percentage_laid_off` missing.

---

## ⚙️ Setup & Usage

### 📦 Prerequisites

- MySQL 8.0+
- A SQL client (e.g., MySQL Workbench, DBeaver, CLI)
- `layoffs.csv` file from this repo

---

### 🧪 Steps to Run

#### 1. **Create a new database and use it**
```sql
CREATE DATABASE layoffs_db;
USE layoffs_db;

#### 2. Import layoffs.csv Using MySQL Workbench GUI
Open MySQL Workbench.

Select your database (layoffs_db) from the SCHEMAS tab.

Right-click Tables → choose Table Data Import Wizard.

Browse to select layoffs.csv.

Follow the prompts to import the data and create a new table named layoffs

#### 3. Run the Cleaning Scripts in Order
-- Step 1: Remove duplicates
SOURCE layoffs-data-cleaning-queries/remove_duplicates.sql;

-- Step 2: Standardize values
SOURCE layoffs-data-cleaning-queries/standardizing_data.sql;

-- Step 3: Handle missing/null values
SOURCE layoffs-data-cleaning-queries/removing_nulls.sql;


#### 4. Verify the Final Cleaned Dataset

SELECT * FROM layoffs_staging2;
