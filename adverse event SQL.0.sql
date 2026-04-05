Use fda_project;

create TABLE fda_data (
    report_date INT,
    serious INT,
    sex INT,
    age INT,
    drugs TEXT,
    reactions TEXT,
    report_date_clean DATE,
    serious_label VARCHAR(20),
    gender VARCHAR(10),
    age_group VARCHAR(20),
    death_flag VARCHAR(10)
);

-- 1. convert serious number into text
select	serious,
case when serious=1 then 'serious'
else 'Non-serious' 
end as serious_label
from fda_project.fda_data;

-- 2. convert sex
select sex,
case when sex=1 then 'Male'
when sex=2 then 'female'
else 'unknown'
end as gender
from fda_project.fda_data;

-- 3. create age group
select	age,
case when age <20 then '0-20'
when age <=40 then '20-40'
when age <=60 then '40-60'
else '60+'
end as age_group
from fda_project.fda_data;

-- 4. count serious and non serious
SELECT CASE
WHEN serious = 1 THEN 'Serious'
WHEN serious = 2 THEN 'Non-Serious'
ELSE 'Unknown'
END AS serious_label,
COUNT(*) AS total_cases
FROM fda_project.fda_data
GROUP BY CASE
WHEN serious = 1 THEN 'Serious'
WHEN serious = 2 THEN 'Non-Serious'
ELSE 'Unknown'
    END;

-- 5. age group analysis
select  
case when age <20 then '0-20'
when age <=40 then '20-40'
when age <=60 then '40-60'
else '60+'
end as age_group,
count(*) as total_cases
from fda_project.fda_data
group by 
case when age <20 then '0-20'
when age <=40 then '20-40'
when age <=60 then '40-60'
else '60+'
end
order by total_cases desc;

-- 6. gender vs serious
SELECT CASE
WHEN sex = 1 THEN 'Male'
WHEN sex = 2 THEN 'Female'
ELSE 'Unknown'
END AS gender,
CASE
WHEN serious = 1 THEN 'Serious'
WHEN serious = 2 THEN 'Non-Serious'
ELSE 'Unknown'
END AS serious_label,
COUNT(*) AS total
FROM fda_project.fda_data  
GROUP BY 
CASE
WHEN sex = 1 THEN 'Male'
WHEN sex = 2 THEN 'Female'
ELSE 'Unknown'
END,
CASE
WHEN serious = 1 THEN 'Serious'
WHEN serious = 2 THEN 'Non-Serious'
ELSE 'Unknown'
END
ORDER BY gender;

ALTER TABLE fda_project.fda_data
DROP COLUMN report_date_clean,
DROP COLUMN serious_label,
DROP COLUMN gender,
DROP COLUMN age_group,
DROP COLUMN death_flag;
