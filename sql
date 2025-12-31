/*-----------------Load unstructured JDs into BigQuery safely and repeatedly.----------------*/

SELECT doc_title, ingested_at
FROM `<dataset_name.table_name>`
ORDER BY ingested_at DESC;

/*-------------Convert raw JD text into structured AI PM insights-----------------*/
SELECT doc_id, role_title, extracted_at
FROM `jd_insights.extractions`
ORDER BY extracted_at DESC;

/*-------------Insight Analysis (SQL)---------------------------------*/
//Common AI Responsibilities
SELECT responsibility, COUNT(DISTINCT doc_id)
FROM `jd_insights.extractions`, UNNEST(ai_responsibilities) responsibility
GROUP BY responsibility
ORDER BY COUNT(DISTINCT doc_id) DESC;

//Unique Responsibilities
SELECT responsibility
FROM (
  SELECT responsibility, COUNT(DISTINCT doc_id) cnt
  FROM `jd_insights.extractions`, UNNEST(ai_responsibilities) responsibility
  GROUP BY responsibility
)
WHERE cnt <= 2;

//Governance & HITL
SELECT hitl_flag, COUNT(*) 
FROM `jd_insights.extractions`
GROUP BY hitl_flag;
