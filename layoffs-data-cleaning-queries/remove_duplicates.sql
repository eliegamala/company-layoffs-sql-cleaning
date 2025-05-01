/*REMOVING DUPLICATES*/
/* 1. View the Original Table */
SELECT * FROM layoffs;

/* 2. Create a Staging Table */
CREATE TABLE layoffs_staging LIKE layoffs;

/* 3. Insert Data into Staging Table */
INSERT INTO layoffs_staging
SELECT * FROM layoffs;

/* 4. View Data from Staging Table */
SELECT * FROM layoffs_staging;

/* 5. Create a Second Staging Table (with extra column for row numbers) */
CREATE TABLE layoffs_staging2 (
  company TEXT,
  location TEXT,
  industry TEXT,
  total_laid_off INT DEFAULT NULL,
  percentage_laid_off TEXT,
  `date` TEXT,
  stage TEXT,
  country TEXT,
  funds_raised_millions INT DEFAULT NULL,
  row_num INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/* 6. Insert Data into Second Staging Table with Row Numbers */
INSERT INTO layoffs_staging2
SELECT *, 
       ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, 
                                        percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;

/* 7. View Data in Second Staging Table */
SELECT * FROM layoffs_staging2;

/* 8. Identify Duplicates (row_num > 1) */
SELECT * 
FROM layoffs_staging2 
WHERE row_num > 1;

/* 9. Delete Duplicates (row_num > 1) */
DELETE FROM layoffs_staging2
WHERE row_num > 1;

/* 10. View Final Cleaned Data */
SELECT * 
FROM layoffs_staging2;
