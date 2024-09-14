/*
Question: What are the top-paying data jobs?
- Identify the top 10 highest-paying Data roles that are available in Asian and Oceania countries. Data roles = ('Data Analyst',  'Senior Data Analyst',  'Business Analyst', 'Data Engineer', 'Data Scientist', 'Senior Data Scientist')
- Focuses on job postings with specified salaries (not nulls)
- BONUS: Include company names of top 10 roles
- Why? Highlight the top-paying opportunities for Data Analysts, offering insights into employment options and location flexibility.
*/

  SELECT TOP 10	
	jpf.job_title_short, jpf.salary_year_avg, cd.name, jpf.job_country, jpf.job_posted_date
  FROM 
	job_postings_fact AS jpf
  LEFT JOIN company_dim AS cd
	ON jpf.company_id = cd.company_id
  WHERE 
	  jpf.salary_year_avg IS NOT NULL 
	  AND
	  jpf.job_title_short in ('Data Analyst',  'Senior Data Analyst',  'Business Analyst', 'Data Engineer', 'Data Scientist', 'Senior Data Scientist')
	  AND
	  jpf.job_country in ('Singapore', 'Philippines', 'Australia', 'China', 'Japan', 'Malaysia', 'New Zealand', 'Taiwan', 'Vietnam', 'Brunei', 'Hong Kong','Indonesia','South Korea','Thailand')
  ORDER BY salary_year_avg DESC

