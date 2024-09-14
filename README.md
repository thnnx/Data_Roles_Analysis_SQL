# Job Posting Analysis on Data Analyst Roles (2023)
Analysis of job posting all over the world specifically related on data analyst roles (Data Analyst, Data Scientist, Data Engineer, etc..)

## Introduction
Diving into the data job market, focusing on data analyst roles demand in year 2023, this project explores top-paying jobs, in-demand skills, and where high demand meets high salary in data analytics.

## Background
Fueled by the ambition to excel in the competitive data analyst job market, this project was created to identify the most in demand and sought-after data analyst skills, simplifying the job search process for others to find their ideal roles.

By scraping data from various job posting websites, the project offers valuable insights into job titles, salaries, locations, and key skills that are in high demand.


### Questions to answer using SQL queries:
1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

## Tools I Used
For my deep dive into the data analyst job market, I harnessed the power of several key tools:

- **SQL:** The backbone of my analysis, allowing me to query the database and find valuable insights.
- **MS SQL Server:** The chosen database management system.
- **MS SQL Server Management Studio:** For database management and executing SQL queries.

## Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market.

### 1. Top Paying Data Analyst Jobs
To identify the top 10 highest-paying roles (Data Analyst, Senior Data Analyst, Business Analyst, Data Engineer, Data Scientist, Senior Data Scientist), I filtered data analyst positions by average yearly salary and location, focusing on Asian and Oceania countries. This query highlights the high paying opportunities in the field.

```sql
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
```
![Query1_ss](images/Query1_ss.PNG)

Breakdown analysis of the top data-related jobs in 2023 for Asia and Oceania
- **Salary:** The salaries range from 177,000 to 249,000 per year. The highest salary is offered for a "Data Engineer" role, while the lowest salary is for a "Data Analyst" position.
- **Companies:** The companies listed in the data include well-known names such as Visa, Amazon.com, Airwallex, and Agoda, as well as others like Trusting Social, EVYD Technology, and Anaxyn Project. These organizations operate across different countries, reflecting the global demand for data-related roles.
- **Job titles (Roles):** There's a high diversity in job titles for the top 10 in demand roles, from Data Analyst to Senior Data Scientist, reflecting varied roles and specializations within data analytics.

**Note:** For reference of the SQL file used, click this link - [Top_Paying_Role](sql_files/Query1_Top_Paying_Role.sql)

**[Visualization Insert here if available]**

### 2. Skills for Top Paying Jobs
To identify what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.
```sql

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

```
![Query2_ss](images/Query2_ss.PNG)

Here's the breakdown of the most demanded skills for the top 10 highest paying data analyst jobs in 2023:
- **SQL** is leading at top 1 with 200k.
- **Python** follows closely at second with 170k.
- **GCP/AWS/AZUE/PYTORCH** are also highly sought after.

**Note:** For reference of the SQL file used, click this link - [Top_Paying_Role_Skill](sql_files/Query2_Top_Paying_Role_Skill.sql)

**[Visualization Insert here if available]**

### 3. In-Demand Skills for Data Analysts

This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.

```sql
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
    job_count DESC;
```
![Query3_ss](images/Query3_ss.PNG)

Here's the breakdown of the most demanded skills for data analysts in 2023
- **SQL** and **Excel** remain fundamental, emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation.
- **Programming** and **Visualization Tools** like **Python**, **Tableau**, and **Power BI** are essential, pointing towards the increasing importance of technical skills in data storytelling and decision support.

**Note:** For reference of the SQL file used, click this link - [In_Demand_Skill](sql_files/Query3_In_Demand_skills.sql)

**[Visualization Insert here if available]**


### 4. Skills Based on Salary
Exploring the average salaries associated with different skills revealed which skills are the highest paying.
```sql
SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True 
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;
```
Here's a breakdown of the results for top paying skills for Data Analysts:
- **High Demand for Big Data & ML Skills:** Top salaries are commanded by analysts skilled in big data technologies (PySpark, Couchbase), machine learning tools (DataRobot, Jupyter), and Python libraries (Pandas, NumPy), reflecting the industry's high valuation of data processing and predictive modeling capabilities.
- **Software Development & Deployment Proficiency:** Knowledge in development and deployment tools (GitLab, Kubernetes, Airflow) indicates a lucrative crossover between data analysis and engineering, with a premium on skills that facilitate automation and efficient data pipeline management.
- **Cloud Computing Expertise:** Familiarity with cloud and data engineering tools (Elasticsearch, Databricks, GCP) underscores the growing importance of cloud-based analytics environments, suggesting that cloud proficiency significantly boosts earning potential in data analytics.

| Skills        | Average Salary ($) |
|---------------|-------------------:|
| pyspark       |            208,172 |
| bitbucket     |            189,155 |
| couchbase     |            160,515 |
| watson        |            160,515 |
| datarobot     |            155,486 |
| gitlab        |            154,500 |
| swift         |            153,750 |
| jupyter       |            152,777 |
| pandas        |            151,821 |
| elasticsearch |            145,000 |

*Table of the average salary for the top 10 paying skills for data analysts*

### 5. Most Optimal Skills to Learn

Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.

```sql
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True 
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```

| Skill ID | Skills     | Demand Count | Average Salary ($) |
|----------|------------|--------------|-------------------:|
| 8        | go         | 27           |            115,320 |
| 234      | confluence | 11           |            114,210 |
| 97       | hadoop     | 22           |            113,193 |
| 80       | snowflake  | 37           |            112,948 |
| 74       | azure      | 34           |            111,225 |
| 77       | bigquery   | 13           |            109,654 |
| 76       | aws        | 32           |            108,317 |
| 4        | java       | 17           |            106,906 |
| 194      | ssis       | 12           |            106,683 |
| 233      | jira       | 20           |            104,918 |

*Table of the most optimal skills for data analyst sorted by salary*

Here's a breakdown of the most optimal skills for Data Analysts in 2023: 
- **High-Demand Programming Languages:** Python and R stand out for their high demand, with demand counts of 236 and 148 respectively. Despite their high demand, their average salaries are around $101,397 for Python and $100,499 for R, indicating that proficiency in these languages is highly valued but also widely available.
- **Cloud Tools and Technologies:** Skills in specialized technologies such as Snowflake, Azure, AWS, and BigQuery show significant demand with relatively high average salaries, pointing towards the growing importance of cloud platforms and big data technologies in data analysis.
- **Business Intelligence and Visualization Tools:** Tableau and Looker, with demand counts of 230 and 49 respectively, and average salaries around $99,288 and $103,795, highlight the critical role of data visualization and business intelligence in deriving actionable insights from data.
- **Database Technologies:** The demand for skills in traditional and NoSQL databases (Oracle, SQL Server, NoSQL) with average salaries ranging from $97,786 to $104,534, reflects the enduring need for data storage, retrieval, and management expertise.

# What I Learned

Throughout this adventure, I've turbocharged my SQL toolkit with some serious firepower:

- **🧩 Complex Query Crafting:** Mastered the art of advanced SQL, merging tables like a pro and wielding WITH clauses for ninja-level temp table maneuvers.
- **📊 Data Aggregation:** Got cozy with GROUP BY and turned aggregate functions like COUNT() and AVG() into my data-summarizing sidekicks.
- **💡 Analytical Wizardry:** Leveled up my real-world puzzle-solving skills, turning questions into actionable, insightful SQL queries.

# Conclusions

### Insights
From the analysis, several general insights emerged:

1. **Top-Paying Data Analyst Jobs**: The highest-paying jobs for data analysts that allow remote work offer a wide range of salaries, the highest at $650,000!
2. **Skills for Top-Paying Jobs**: High-paying data analyst jobs require advanced proficiency in SQL, suggesting it’s a critical skill for earning a top salary.
3. **Most In-Demand Skills**: SQL is also the most demanded skill in the data analyst job market, thus making it essential for job seekers.
4. **Skills with Higher Salaries**: Specialized skills, such as SVN and Solidity, are associated with the highest average salaries, indicating a premium on niche expertise.
5. **Optimal Skills for Job Market Value**: SQL leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for data analysts to learn to maximize their market value.

### Closing Thoughts

This project enhanced my SQL skills and provided valuable insights into the data analyst job market. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data analytics.
