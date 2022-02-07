SELECT 
	pd.person_id AS patient_id,
	pd.gender,
	pd.birthyear,
	pd.birthtime,
	pd.birthdate_estimated,
	pd.death_date,
	pd.deathdate_estimated,
	pd.cause_of_death,
	pad.city_village,
	pad.state_province,
	pad.country,
	pad.county_district,
	pad.start_date,
	pad.end_date,
	pa.*
FROM person_details_default pd
LEFT JOIN person_attributes pa ON pa.person_id = pd.person_id
LEFT JOIN person_address_default pad ON pad.person_id = pd.person_id
	AND pad.preferred = 'true'
