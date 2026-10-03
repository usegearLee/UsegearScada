"""Verify the candidate schema in memory without opening the project DB."""

from pathlib import Path
import sqlite3


def must_reject(connection: sqlite3.Connection, statement: str, values: tuple) -> None:
    try:
        connection.execute(statement, values)
    except sqlite3.IntegrityError:
        return
    raise AssertionError(f"Expected constraint failure: {statement}")


schema = Path(__file__).with_name("core_model_v0_1.sql").read_text(encoding="utf-8")
db = sqlite3.connect(":memory:")
db.execute("PRAGMA foreign_keys=ON")
db.executescript(schema)

db.executemany(
    "INSERT INTO ScadaProject VALUES (?, ?, ?)",
    [("P1", "WATER_A", "Project A"), ("P2", "WATER_B", "Project B")],
)
db.executemany(
    "INSERT INTO ScadaNode(project_id,node_id,parent_node_id,node_kind,node_code,node_name) VALUES (?,?,?,?,?,?)",
    [
        ("P1", "AREA", None, "AREA", "A", "Area"),
        ("P1", "PROC1", "AREA", "PROCESS", "PROC1", "Process 1"),
        ("P1", "PROC2", "AREA", "PROCESS", "PROC2", "Process 2"),
        ("P1", "PUMP1", "PROC1", "DEVICE", "PUMP1", "Pump 1"),
        ("P2", "OTHER", None, "DEVICE", "OTHER", "Other device"),
    ],
)
db.execute(
    "INSERT INTO ScadaTag(project_id,tag_id,owner_node_id,tag_code,display_name,tag_kind,value_type) "
    "VALUES (?,?,?,?,?,?,?)",
    ("P1", "RUN", "PUMP1", "PUMP1_RUN", "Running", "PHYSICAL", "BOOLEAN"),
)
db.executemany(
    "INSERT INTO ScadaProcessTag(project_id,process_node_id,tag_id) VALUES (?,?,?)",
    [("P1", "PROC1", "RUN"), ("P1", "PROC2", "RUN")],
)
assert db.execute("SELECT count(*) FROM ScadaProcessTag WHERE tag_id='RUN'").fetchone()[0] == 2

must_reject(
    db,
    "INSERT INTO ScadaTag(project_id,tag_id,owner_node_id,tag_code,display_name,tag_kind,value_type) "
    "VALUES (?,?,?,?,?,?,?)",
    ("P1", "BAD", "OTHER", "BAD", "Bad", "PHYSICAL", "BOOLEAN"),
)
must_reject(
    db,
    "INSERT INTO ScadaTag(project_id,tag_id,owner_node_id,tag_code,display_name,tag_kind,value_type) "
    "VALUES (?,?,?,?,?,?,?)",
    ("P1", "RUN2", "PUMP1", "PUMP1_RUN", "Duplicate", "PHYSICAL", "BOOLEAN"),
)
must_reject(
    db,
    "DELETE FROM ScadaTag WHERE project_id=? AND tag_id=?",
    ("P1", "RUN"),
)
print("core model candidate: 4 checks passed")
