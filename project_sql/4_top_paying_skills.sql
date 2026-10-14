/* Задание: Какие навыки самые высокооплачиваемые? */

select 
    skills,
    count(*) as skill_popularity,
    Round(avg(salary_year_avg),1) as avg_salary_per_skill
from job_postings_fact
join skills_job_dim ON
    job_postings_fact.job_id = skills_job_dim.job_id
join skills_dim ON
    skills_job_dim.skill_id = skills_dim.skill_id
where 
    job_title_short = 'Data Analyst'
    AND
    salary_year_avg is not null
group by skills
-- having count(*) > 30
order by avg_salary_per_skill desc
limit 25;