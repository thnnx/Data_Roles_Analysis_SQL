SELECT COUNT([salary_year_avg])
  FROM [sql_course].[dbo].[job_postings_fact]
  WHERE [job_country] in ('Singapore', 'Philippines', 'Australia', 'China', 'Japan', 'Malaysia', 'New Zealand', 'Taiwan', 'Vietnam', 'Brunei', 'Hong Kong','Indonesia','South Korea','Thailand')


SELECT DISTINCT [job_country]
  FROM [sql_course].[dbo].[job_postings_fact]
  ORDER BY [job_country]


  -- Check for duplicate values
SELECT skill_id, COUNT(*)
FROM [dbo].[skills_job_dim]
GROUP BY skill_id
HAVING COUNT(*) > 1;

-- Check for null values
SELECT *
FROM [skills_job_dim]
WHERE employee_id IS NULL;

------------

SELECT TOP 10
    sjd.skill_id,
    sd.skills as Skill_Name,
    count(jpf.job_id) AS job_count 
FROM
    job_postings_fact jpf
INNER JOIN skills_job_dim sjd 
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim sd
    ON sjd.skill_id = sd.skill_id
WHERE 
    jpf.job_work_from_home = 1 AND
    jpf.job_title_short = 'Data Analyst'
GROUP BY 
    sjd.skill_id, sd.skills
ORDER BY 
    job_count DESC
;
