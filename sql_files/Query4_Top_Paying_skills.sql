/*
Answer: What are the top skills based on salary?
- Look at the average salary associated with each skill for positions ('Data Analyst',  'Senior Data Analyst',  'Business Analyst')
- Focuses on roles with specified salaries, for Asia and Oceania
- Why? It reveals how different skills impact salary levels for Data Analysts and 
    helps identify the most financially rewarding skills to acquire or improve
*/

SELECT TOP 20
    sd.skills,
    CAST(ROUND(AVG(jpf.salary_year_avg), 0) AS DECIMAL (18,2)) AS avg_salary
	--ROUND(AVG(jpf.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact jpf
INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short in ('Data Analyst',  'Senior Data Analyst',  'Business Analyst')
    AND jpf.salary_year_avg IS NOT NULL
	AND jpf.job_country in ('Singapore', 'Philippines', 'Australia', 'China', 'Japan', 'Malaysia', 'New Zealand', 'Taiwan', 'Vietnam', 'Brunei', 'Hong Kong','Indonesia','South Korea','Thailand')
GROUP BY
    sd.skills
ORDER BY
    avg_salary DESC