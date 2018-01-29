SELECT
  patientState.patient_id,
  patientState.name,
  patientState.startDate,
  patientState.endDate,
  surgeonFollowup.surgeonFollowUPPlanObsDateTime
FROM
  (SELECT
     p.patient_id,
     cn.name,
     CAST(ps.start_date AS DATE)                       AS `startDate`,
     CAST(COALESCE(ps.end_date, CURRENT_DATE) AS DATE) AS `endDate`
   FROM patient p
     INNER JOIN patient_program pp ON p.patient_id = pp.patient_id AND p.voided IS FALSE AND pp.voided IS FALSE
     INNER JOIN patient_state ps ON pp.patient_program_id = ps.patient_program_id AND ps.voided IS FALSE
     INNER JOIN program_workflow_state pws
       ON ps.state = pws.program_workflow_state_id AND ps.voided IS FALSE AND pws.retired IS FALSE
     INNER JOIN concept_name cn
       ON pws.concept_id = cn.concept_id AND cn.voided IS FALSE AND cn.concept_name_type = 'FULLY_SPECIFIED' AND
          cn.name = 'Network Follow-up'
   ORDER BY patient_id, start_date) patientState
LEFT JOIN (
    SELECT
      o.person_id,
      GROUP_CONCAT( IF (qcvn.concept_full_name = 'SFP, Follow-up plan' AND acvn.concept_full_name = 'Death',
      CAST(o.obs_datetime AS DATE ), NULL )) AS `surgeonFollowUPPlanObsDateTime`
      FROM obs o
      INNER JOIN concept_view qcvn ON qcvn.concept_id = o.concept_id AND
      qcvn.concept_full_name IN (
      'SFP, Follow-up plan') AND qcvn.retired IS FALSE AND o.voided IS FALSE
      LEFT JOIN concept_view acvn ON o.value_coded  = acvn.concept_id AND acvn.retired IS FALSE
      GROUP BY o.encounter_id) surgeonFollowup ON patientState.patient_id = surgeonFollowup.person_id
