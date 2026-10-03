"""Create a new, unencrypted development database from reviewed SQL files.

This script refuses to replace an existing file. It never reads or modifies
DB/usegear.db, which is the existing encrypted application database.
"""

from pathlib import Path
import sqlite3


ROOT = Path(__file__).resolve().parents[2]
TARGET = ROOT / "DB" / "dev" / "usegear_dev.db"
SQL_FILES = (
    ROOT / "DB" / "migrations" / "001_dict_menutree.sql",
    ROOT / "DB" / "design" / "core_model_v0_1.sql",
)

TARGET.parent.mkdir(parents=True, exist_ok=True)
if TARGET.exists():
    raise SystemExit(f"Development database already exists: {TARGET}")

connection = sqlite3.connect(TARGET)
try:
    connection.execute("PRAGMA foreign_keys=ON")
    for sql_file in SQL_FILES:
        connection.executescript(sql_file.read_text(encoding="utf-8"))
    result = connection.execute("PRAGMA integrity_check").fetchone()[0]
    if result != "ok":
        raise RuntimeError(f"SQLite integrity_check failed: {result}")
    connection.commit()
finally:
    connection.close()

print(f"Created unencrypted development database: {TARGET}")
