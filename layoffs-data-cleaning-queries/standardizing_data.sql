/* 1. Standardizing Company Names - View companies with extra spaces */
SELECT company, TRIM(company) AS trimmed_company
FROM layoffs_staging2;

/* 2. Removing Unnecessary White Spaces from Company Names */
UPDATE layoffs_staging2
SET company = TRIM(company);

/* 3. Checking Unique Values in the Industry Column */
SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY 1;

/* 4. Finding Industry Name Variations Related to Crypto */
SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';

/* 5. Standardizing Industry Names - Updating all variations to 'Crypto' */
UPDATE layoffs_staging2 
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

/* 6. Rechecking Unique Values in the Industry Column after Update */
SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY 1;

/* 7. Checking Unique Values in the Country Column */
SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1;

/* 8. Finding Incorrect Country Names Starting with 'United State' */
SELECT *
FROM layoffs_staging2
WHERE country LIKE 'United State%'
ORDER BY 1;

/* 9. Standardizing Country Names - Correcting to 'United States' */
UPDATE layoffs_staging2
SET country = 'United States'
WHERE country LIKE 'United States%';

/* 10. Checking Current Format of the Date Column */
SELECT `date`
FROM layoffs_staging2;

/* 11. Preview - Converting String Dates into SQL Date Format */
SELECT `date`, 
       STR_TO_DATE(`date`, '%m/%d/%Y') AS formatted_date
FROM layoffs_staging2;

/* 12. Updating Dates to Proper SQL Date Format */
UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

/* 13. Changing the Data Type of the Date Column to DATE */
ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;
