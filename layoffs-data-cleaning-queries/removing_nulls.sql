/*null values*/

-- First, check Airbnb records
SELECT * FROM layoffs_staging2 WHERE company = 'AirBnb';

-- Check for records where we can fill in missing industry data
SELECT t1.company, t1.industry, t2.industry as industry_to_copy
FROM layoffs_staging2 as t1
JOIN layoffs_staging2 as t2
    ON t1.company = t2.company
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

-- First set empty strings to NULL for consistency
UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';

-- Now update NULL industries with values from the same company
UPDATE layoffs_staging2 as t1
JOIN (
    SELECT company, industry 
    FROM layoffs_staging2 
    WHERE industry IS NOT NULL
    GROUP BY company, ilayoffs_staginglayoffs_staginglayoffs_stagingndustry
) as t2
ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL;


select * from layoffs_staging2 where total_laid_off is null and percentage_laid_off is null;

delete from layoffs_staging2 where total_laid_off is null and percentage_laid_off is null;

alter table layoffs_staging2
drop column row_num;