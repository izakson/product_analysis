select mtc.unique_case_id,
    mtc.doctor_specialty_offline,
	mtc.start_case,
	mtc.region ,
	mtc."Профиль" as profile,
	mtc.during_case as duration,
	mtc.sum_case_without_fot as loss
from etl_analytics.medical_telemed_case mtc 
where case_category != 'Телемед кейс' 
and doctor_specialty_offline = 'Терапевт'
or doctor_specialty_offline = 'Врач общей практики'