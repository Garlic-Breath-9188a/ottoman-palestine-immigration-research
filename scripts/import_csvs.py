#!/usr/bin/env python3
"""
Import CSV files from data/extracted into database/immigration.sqlite.

Usage:
    python scripts/import_csvs.py
"""
from pathlib import Path
import sqlite3, csv

ROOT = Path(__file__).resolve().parents[1]
DB = ROOT / "database" / "immigration.sqlite"
DATA = ROOT / "data" / "extracted"

TABLES = [
    "sources",
    "locations",
    "settlements",
    "immigration_events",
    "population_series",
    "residual_estimates",
    "search_terms",
    "source_findings",
]

conn = sqlite3.connect(DB)
conn.execute("PRAGMA foreign_keys = ON")

for table in TABLES:
    path = DATA / f"{table}.csv"
    if not path.exists():
        print(f"Skipping missing {path}")
        continue
    with path.open(newline="", encoding="utf-8") as f:
        reader = csv.DictReader(f)
        rows = list(reader)
        if not rows:
            continue
        cols = reader.fieldnames
        placeholders = ",".join(["?"] * len(cols))
        sql = f"INSERT OR REPLACE INTO {table} ({','.join(cols)}) VALUES ({placeholders})"
        for row in rows:
            conn.execute(sql, [row.get(c) or None for c in cols])
    print(f"Imported {len(rows)} rows into {table}")

conn.execute("INSERT INTO findings_fts(findings_fts) VALUES('rebuild')")
conn.commit()
conn.close()
print("Done.")
