/*
Answer: What are the most optimal skills to learn (aka it’s in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles with atleast 1000 job posting count
- Focuses on roles with specified salaries, for Asia and Oceania
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries), 
    offering strategic insights for career development in data analysis
*/

-- Identifies skills in high demand for Data Analyst roles
-- Query #3 for number of demand per skills

WITH skill_demand as (
	SELECT
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
),

-- Skills with high average salaries for Data Analyst roles
-- Use Query #4 for list of skills per avg_salary
skill_salary as
(
	SELECT 
		sd.skills,
		CAST(ROUND(AVG(jpf.salary_year_avg), 0) AS DECIMAL (18,2)) AS avg_salary
	FROM job_postings_fact jpf
	INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
	INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
	WHERE
		jpf.job_title_short in ('Data Analyst',  'Senior Data Analyst',  'Business Analyst')
		AND jpf.salary_year_avg IS NOT NULL
		AND jpf.job_country in ('Singapore', 'Philippines', 'Australia', 'China', 'Japan', 'Malaysia', 'New Zealand', 'Taiwan', 'Vietnam', 'Brunei', 'Hong Kong','Indonesia','South Korea','Thailand')
	GROUP BY
		sd.skills
)
SELECT sd.Skill_Name, sd.job_count, ss.avg_salary
FROM skill_demand sd
LEFT JOIN skill_salary ss ON sd.Skill_Name = ss.skills
WHERE ss.avg_salary IS NOT NULL
AND sd.job_count > 1000 -- more desirable results 
ORDER BY ss.avg_salary DESC
