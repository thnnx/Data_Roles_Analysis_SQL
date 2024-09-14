/*
Question: What skills are required for the top-paying data jobs ('Data Analyst',  'Senior Data Analyst',  'Business Analyst')?
- Use the top 10 highest-paying Data Analyst jobs query 
- Add the specific skills required for these roles
- Why? It provides a detailed look at which high-paying jobs demand certain skills, 
    helping job seekers understand which skills to develop that align with top salaries
*/

WITH tbl1 AS (
  SELECT 	
	jpf.job_id, jpf.job_title_short, jpf.salary_year_avg, cd.name, jpf.job_country, jpf.job_posted_date
  FROM 
	job_postings_fact AS jpf
  LEFT JOIN company_dim AS cd
	ON jpf.company_id = cd.company_id
  WHERE 
	  salary_year_avg IS NOT NULL 
	  AND
	  job_title_short in ('Data Analyst',  'Senior Data Analyst',  'Business Analyst')
	  AND
	  job_country in ('Singapore', 'Philippines', 'Australia', 'China', 'Japan', 'Malaysia', 'New Zealand', 'Taiwan', 'Vietnam', 'Brunei', 'Hong Kong','Indonesia','South Korea','Thailand')
  )

  SELECT TOP 10 t1.job_id, t1.job_title_short, t1.salary_year_avg, t1.name, t1.job_country, sjd.skill_id, sd.skills
  FROM tbl1 t1
  LEFT JOIN skills_job_dim as sjd
    ON t1.job_id = sjd.job_id
  LEFT JOIN skills_dim as sd
	ON sjd.skill_id = sd.skill_id
  WHERE sd.skill_id IS NOT NULL
  ORDER BY t1.salary_year_avg DESC