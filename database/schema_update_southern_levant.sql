-- Migration Research Database Update: Southern Levant Geographic Scope
-- Apply manually or incorporate into database/schema.sql.

CREATE TABLE IF NOT EXISTS geographic_scopes (
    scope_id TEXT PRIMARY KEY,
    scope_name TEXT NOT NULL,
    definition TEXT NOT NULL,
    included_regions TEXT,
    excluded_regions TEXT,
    rationale TEXT,
    notes TEXT
);

CREATE TABLE IF NOT EXISTS location_scope_membership (
    location_id TEXT NOT NULL,
    scope_id TEXT NOT NULL,
    membership_confidence TEXT,
    rationale TEXT,
    notes TEXT,
    PRIMARY KEY (location_id, scope_id),
    FOREIGN KEY (location_id) REFERENCES locations(location_id),
    FOREIGN KEY (scope_id) REFERENCES geographic_scopes(scope_id)
);

ALTER TABLE immigration_events ADD COLUMN geographic_scope TEXT;
ALTER TABLE settlements ADD COLUMN geographic_scope TEXT;
ALTER TABLE population_series ADD COLUMN geographic_scope TEXT;
ALTER TABLE residual_estimates ADD COLUMN geographic_scope TEXT;
