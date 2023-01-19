select mtc.unique_case_id,
    mtc.patient_id,
	mtc.doctor_specialty_online,
	mtc.start_case,
	mtc.region ,
	mtc."Профиль" as profile,
	mtc.telemed_case_category as category,
	mtc.during_case as duration,
	mtc.sum_case_without_fot as loss,
	count(case when mtcr.category_title='Телемед консультация' then 1 end) as telemed_cnt,
	count(case when mtcr.category_title in ('Лабораторные исследования',
										'Инструментальные исследования',
										'Лечебные процедуры и манипуляции',
										'Восстановительная медицина') then 1 end) as analysis_cnt,
	count(case when mtcr.category_title='Приемы врачей' then 1 end) as offline_cnt,
	count(case when mtcr.category_title='Вызов врача на дом' then 1 end) as vnd_cnt,
	count(case when mtcr.category_title in ('Госпитализация','Дневной стационар') then 1 end) as hospital_cnt,
	count(case when mtcr.category_title is null then 1 end) as unknown_cnt
from etl_analytics.medical_telemed_case mtc 
	left join etl_analytics.medical_telemed_case_records mtcr 
		on mtc.unique_case_id = mtcr.unique_case_id 
where mtc.case_category = 'Телемед кейс' 
	and mtc.doctor_specialty_online in ('Врач общей практики','Терапевт')
	and mtc.is_just_ask_telemed = 0 and mtc.only_telemed_program = 0
group by 1,2,3,4,5,6,7,8,9