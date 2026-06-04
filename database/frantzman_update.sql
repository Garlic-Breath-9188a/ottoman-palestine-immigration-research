-- Frantzman dissertation processing update
-- Review and adapt before applying.

INSERT OR REPLACE INTO sources
(source_id, author, title, publication_year, source_type, evidence_class, archive_reference, url, reliability_score, notes)
VALUES
('SRC_FRANTZMAN_2010', 'Seth J. Frantzman', 'The Arab Settlement of Late Ottoman and Mandatory Palestine: New Village Formation and Settlement Fixation, 1871-1948', 2010, 'PhD dissertation', 'C', 'Hebrew University of Jerusalem dissertation', '', 'High as settlement inventory; medium for migration inference', 'Systematic historical-geographic study using maps, censuses, aerial photos, archival sources, and fieldwork.');

-- Findings should be imported from data/extracted/frantzman_source_findings.csv.
-- Settlement summary rows should be imported from data/extracted/frantzman_settlement_summary.csv or manually mapped into immigration_events / residual_estimates as appropriate.
