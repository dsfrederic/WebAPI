SELECT
  c1.concept_id                                                AS concept_id,
  c1.concept_name                                              AS concept_name,
  num.stratum_2                                                AS x_calendar_month,
  -- calendar year, note, there could be blanks
  round(1000 * (1.0 * num.count_value / denom.count_value), 5) AS y_prevalence_1000_pp --prevalence, per 1000 persons
FROM (
	SELECT analysis_id, stratum_1, stratum_2, count_value
	FROM @results_database_schema.achilles_results
	WHERE analysis_id = 602
	GROUP BY stratum_1, stratum_2, count_value
) num
INNER JOIN (
	SELECT stratum_1, count_value
	FROM @results_database_schema.achilles_results
	WHERE analysis_id = 117
	GROUP BY stratum_1, count_value
) denom ON num.stratum_2 = denom.stratum_1 --calendar year
INNER JOIN @vocab_database_schema.concept c1 ON CAST(CASE WHEN num.analysis_id = 602 THEN num.stratum_1 ELSE null END AS BIGINT) = c1.concept_id
WHERE c1.concept_id = @conceptId
ORDER BY CAST(CASE WHEN num.analysis_id = 602 THEN num.stratum_2 ELSE null END AS INT )
