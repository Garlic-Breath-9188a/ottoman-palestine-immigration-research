PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS sources (
    source_id TEXT PRIMARY KEY,
    author TEXT,
    title TEXT NOT NULL,
    publication_year INTEGER,
    source_type TEXT,
    evidence_class TEXT,
    archive_reference TEXT,
    url TEXT,
    reliability_score TEXT,
    notes TEXT
);

CREATE TABLE IF NOT EXISTS locations (
    location_id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    alternative_names TEXT,
    district TEXT,
    sanjak TEXT,
    vilayet TEXT,
    modern_country TEXT,
    latitude REAL,
    longitude REAL,
    notes TEXT
);

CREATE TABLE IF NOT EXISTS settlements (
    settlement_id TEXT PRIMARY KEY,
    settlement_name TEXT NOT NULL,
    location_id TEXT,
    immigrant_group TEXT,
    origin_region TEXT,
    founded_year INTEGER,
    initial_population_low INTEGER,
    initial_population_high INTEGER,
    estimate_type TEXT,
    confidence_level TEXT,
    source_id TEXT,
    notes TEXT,
    FOREIGN KEY(location_id) REFERENCES locations(location_id),
    FOREIGN KEY(source_id) REFERENCES sources(source_id)
);

CREATE TABLE IF NOT EXISTS immigration_events (
    event_id TEXT PRIMARY KEY,
    date_start TEXT,
    date_end TEXT,
    origin TEXT,
    destination_location_id TEXT,
    immigrant_group TEXT,
    population_low INTEGER,
    population_high INTEGER,
    estimate_type TEXT,
    evidence_class TEXT,
    confidence_level TEXT,
    source_id TEXT,
    citation_detail TEXT,
    notes TEXT,
    FOREIGN KEY(destination_location_id) REFERENCES locations(location_id),
    FOREIGN KEY(source_id) REFERENCES sources(source_id)
);

CREATE TABLE IF NOT EXISTS population_series (
    population_id TEXT PRIMARY KEY,
    location_id TEXT,
    year INTEGER,
    population_total INTEGER,
    muslim INTEGER,
    christian INTEGER,
    jewish INTEGER,
    other INTEGER,
    source_id TEXT,
    estimate_type TEXT,
    confidence_level TEXT,
    notes TEXT,
    FOREIGN KEY(location_id) REFERENCES locations(location_id),
    FOREIGN KEY(source_id) REFERENCES sources(source_id)
);

CREATE TABLE IF NOT EXISTS residual_estimates (
    residual_id TEXT PRIMARY KEY,
    location_id TEXT,
    period_start INTEGER,
    period_end INTEGER,
    population_start INTEGER,
    population_end INTEGER,
    expected_natural_increase_low INTEGER,
    expected_natural_increase_high INTEGER,
    residual_migration_low INTEGER,
    residual_migration_high INTEGER,
    external_migration_low INTEGER,
    external_migration_high INTEGER,
    methodology TEXT,
    confidence_level TEXT,
    notes TEXT,
    FOREIGN KEY(location_id) REFERENCES locations(location_id)
);

CREATE TABLE IF NOT EXISTS search_terms (
    term_id TEXT PRIMARY KEY,
    term TEXT NOT NULL,
    language TEXT,
    script TEXT,
    category TEXT,
    notes TEXT
);

CREATE TABLE IF NOT EXISTS source_findings (
    finding_id TEXT PRIMARY KEY,
    source_id TEXT,
    location_id TEXT,
    finding_date TEXT,
    claim_summary TEXT,
    quoted_text TEXT,
    page_or_ref TEXT,
    evidence_class TEXT,
    confidence_level TEXT,
    needs_verification INTEGER DEFAULT 1,
    notes TEXT,
    FOREIGN KEY(source_id) REFERENCES sources(source_id),
    FOREIGN KEY(location_id) REFERENCES locations(location_id)
);

CREATE VIRTUAL TABLE IF NOT EXISTS findings_fts USING fts5(
    finding_id,
    claim_summary,
    quoted_text,
    notes,
    content='source_findings',
    content_rowid='rowid'
);
