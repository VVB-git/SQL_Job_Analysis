/*
Вопрос: Какие самые высокооплачиваемые вакансии Data Analyst на 
удаленке и в каких они компаниях?
*/

select * FROM job_postings_fact limit 5;
select * FROM company_dim limit 5;

select 
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
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
limit 10;

