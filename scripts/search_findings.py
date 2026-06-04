#!/usr/bin/env python3
"""
Simple search over source_findings full-text index.

Usage:
    python scripts/search_findings.py "Circassian Akka"
"""
import sys, sqlite3
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DB = ROOT / "database" / "immigration.sqlite"
query = " ".join(sys.argv[1:]) if len(sys.argv) > 1 else "Circassian"

conn = sqlite3.connect(DB)
rows = conn.execute("""
SELECT sf.finding_id, sf.claim_summary, sf.page_or_ref, sf.confidence_level
FROM findings_fts f
JOIN source_findings sf ON sf.rowid = f.rowid
WHERE findings_fts MATCH ?
LIMIT 25
""", (query,)).fetchall()

for r in rows:
    print("\nID:", r[0])
    print("Claim:", r[1])
    print("Ref:", r[2])
    print("Confidence:", r[3])
