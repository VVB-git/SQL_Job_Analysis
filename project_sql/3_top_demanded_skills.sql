/* Какие навыки наиболее востребованы для Data Analyst? */

select * from skills_dim limit 5;
select * from job_postings_fact limit 5; 

select 
    skills,
    count(*) as skill_popularity
from
    job_postings_fact
inner join skills_job_dim on 
    job_postings_fact.job_id = skills_job_dim.job_id
inner join skills_dim ON
    skills_job_dim.skill_id = skills_dim.skill_id
where job_title_short = 'Data Analyst'
group by skills_dim.skills
order by skill_popularity desc
limit 5;