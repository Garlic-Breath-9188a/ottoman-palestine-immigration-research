-- Example queries

-- All settlement claims
SELECT settlement_name, immigrant_group, origin_region, initial_population_low, initial_population_high, confidence_level, notes
FROM settlements
ORDER BY settlement_name;

-- All findings needing verification
SELECT finding_id, claim_summary, page_or_ref, confidence_level
FROM source_findings
WHERE needs_verification = 1;

-- Search findings using FTS
SELECT sf.finding_id, sf.claim_summary
FROM findings_fts f
JOIN source_findings sf ON sf.rowid = f.rowid
WHERE findings_fts MATCH 'Circassian Akka';
