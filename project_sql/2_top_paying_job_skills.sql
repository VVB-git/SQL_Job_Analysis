/* Какие навыки требуются для самых высокооплачиваемых
вакансий Data Analyst? */

select * FROM job_postings_fact limit 5;
select * FROM company_dim limit 5;

with top_5_hpaying_da_jobs as (
    select 
        job_id,
        job_title,
        salary_year_avg,
        company_dim.name
    from job_postings_fact
    left join company_dim on job_postings_fact.company_id = company_dim.company_id
    where 
        job_location = 'Anywhere'
        AND
        salary_year_avg is not null
        AND
        job_title_short = 'Data Analyst'
    order by salary_year_avg desc
    limit 10
)
select
    top_5_hpaying_da_jobs.*,
    skills_dim.skills
from
    top_5_hpaying_da_jobs
inner join skills_job_dim on 
    top_5_hpaying_da_jobs.job_id = skills_job_dim.job_id
inner join skills_dim ON
    skills_job_dim.skill_id = skills_dim.skill_id