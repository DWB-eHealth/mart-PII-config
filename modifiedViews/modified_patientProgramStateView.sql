SELECT
  pd.person_id AS patient_id,
  EXTRACT(YEAR FROM (SELECT age( ppd.date_enrolled, TO_DATE(CONCAT('01-01-', pd.birthyear), 'dd-MM-yyyy')))) AS age_at_program,
  age_group(ppd.date_enrolled, TO_DATE(CONCAT('01-01-', pd.birthyear), 'dd-MM-yyyy')) AS age_group_at_program,
  pa.state_province,
  pd.gender,
  pd.birthyear,
  pd.birthtime,
  pd.birthdate_estimated,
  pat.*,
  ppd.program_id,
  pg.program_name,
  ppd.patient_program_id,
  ppd.program_outcome,
  ps.state      AS patient_program_state,
  ps.state_name AS patient_program_state_name,
  ps.start_date AS patient_program_state_start_date,
  ps.end_date AS patient_program_state_end_date,
  ps.creator_id AS patient_state_creator_id,
  ps.date_created  AS patient_state_date_created,
  ps.date_changed  AS patient_state_date_changed,
  ps.changed_by_id AS patient_state_changed_by_id,
  ppd.date_enrolled  AS program_date_enrolled,
  ppd.date_completed AS program_date_completed,
  ppd.location_id,
  ppd.location_name,
  ppd.creator_id AS patient_program_creator_id,
  ppd.date_created AS patient_program_date_created,
  ppd.date_changed AS patient_program_date_changed,
  ppd.changed_by_id AS patient_program_changed_by_id,
  ppd.voided AS patient_program_voided

FROM person_details_default pd LEFT OUTER JOIN person_address_default pa ON pa.person_id = pd.person_id
  LEFT OUTER JOIN person_attributes pat ON pat.person_id = pd.person_id
  LEFT OUTER JOIN patient_program_data_default ppd ON ppd.patient_id = pd.person_id
  LEFT OUTER JOIN programs_default pg ON pg.program_id = ppd.program_id
  LEFT OUTER JOIN patient_state_default ps ON ps.patient_program_id = ppd.patient_program_id