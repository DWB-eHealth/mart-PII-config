SELECT
  pd.person_id AS patient_id,
  ppd.program_id,
  md.patient_program_name AS program_name,
  ppd.date_enrolled,
  ppd.date_completed,
  ppd.program_outcome,
  pd.gender,
  pd.birthyear            AS birth_year,
  EXTRACT(YEAR FROM (SELECT age( md.start_date, TO_DATE(CONCAT('01-01-', pd.birthyear), 'dd-MM-yyyy')))) AS age_at_medication,
  age_group(md.start_date, TO_DATE(CONCAT('01-01-', pd.birthyear), 'dd-MM-yyyy')) AS age_group_at_medication,
  pd.dead,
  pa.*,
  md.patient_program_id,
  md.encounter_id,
  md.encounter_type_name,
  md.order_id,
  md.coded_drug_name,
  md.non_coded_drug_name,
  md.dose,
  md.dose_units,
  md.frequency,
  md.route,
  md.start_date           AS medication_start_date,
  md.calculated_end_date  AS medication_calculated_end_date,
  md.date_stopped         AS medication_stopped_date,
  md.duration,
  md.duration_units,
  md.quantity,
  md.quantity_units,
  md.dispense             AS is_dispensed,
  md.visit_id,
  md.visit_type

 FROM person_details_default pd
  LEFT JOIN person_attributes pa ON pa.person_id = pd.person_id
  LEFT JOIN medication_data_default md ON md.patient_id = pd.person_id
  LEFT OUTER JOIN patient_program_data_default ppd ON ppd.patient_id = md.patient_id and ppd.patient_program_id = md.patient_program_id