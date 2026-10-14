/*
Задание: Какие навыки оптимальнее всего изучать
(то есть навыки с высоким спросом и высокой оплатой)?

- Определи навыки, которые пользуются высоким спросом
и связаны с высокой средней зарплатой для позиций Data Analyst.
- Сосредоточься на удалённых позициях с указанной
зарплатой.

- Зачем: это помогает выбрать навыки, которые обеспечивают
как востребованность на рынке (высокий спрос), так и
финансовую выгоду (высокие зарплаты), давая стратегические
ориентиры для карьерного роста в аналитике данных.
*/


with skills_demand as (
    select
        skills_dim.skill_id,
        skills,
        count(*) as skill_popularity
    from
        job_postings_fact
    inner join skills_job_dim on 
        job_postings_fact.job_id = skills_job_dim.job_id
    inner join skills_dim ON
        skills_job_dim.skill_id = skills_dim.skill_id
    where 
        job_title_short = 'Data Analyst'
        AND
        salary_year_avg is not null
        AND
        job_work_from_home = TRUE
    group by skills_dim.skill_id
),
average_salary as (
    select 
        skills_dim.skill_id,
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
        AND
        job_work_from_home = TRUE
    group by skills_dim.skill_id
)
select 
    skills_demand.skill_id,
    skills_demand.skills,
    skills_demand.skill_popularity,
    average_salary.avg_salary_per_skill
from average_salary
join skills_demand on average_salary.skill_id = skills_demand.skill_id
order by skill_popularity DESC, avg_salary_per_skill







