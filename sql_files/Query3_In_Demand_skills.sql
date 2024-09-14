
/*
Question: What are the most in-demand skills for data roles ('Data Analyst',  'Senior Data Analyst',  'Business Analyst')?
- Join job postings to inner join table similar to previous query 2
- Identify the top 10 in-demand skills for a data roles ('Data Analyst',  'Senior Data Analyst',  'Business Analyst').
- Focus on all job postings.
- Why? Retrieves the top 10 skills with the highest demand in the job market, 
    providing insights into the most valuable skills for job seekers.
*/

SELECT TOP 10
    sd.skills as Skill_Name,
    count(jpf.job_id) AS job_count 
FROM
    job_postings_fact jpf
INNER JOIN skills_job_dim sjd 
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim sd
    ON sjd.skill_id = sd.skill_id
WHERE 
    jpf.job_title_short in ('Data Analyst',  'Senior Data Analyst',  'Business Analyst')
	AND
	jpf.job_country in ('Singapore', 'Philippines', 'Australia', 'China', 'Japan', 'Malaysia', 'New Zealand', 'Taiwan', 'Vietnam', 'Brunei', 'Hong Kong','Indonesia','South Korea','Thailand')
GROUP BY 
    sjd.skill_id, sd.skills
ORDER BY 
    job_count DESC
;
