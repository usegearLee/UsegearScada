-- Candidate only. Do not apply to DB/usegear.db until its encrypted SQLite
-- connection, migration mechanism, and the Node-RED/FUXA mapping contracts
-- have been checked. Enable PRAGMA foreign_keys=ON on every application
-- connection before using these tables.

CREATE TABLE ScadaProject (
    project_id   TEXT PRIMARY KEY NOT NULL CHECK (length(project_id) > 0),
    project_code TEXT NOT NULL UNIQUE CHECK (length(project_code) > 0),
    project_name TEXT NOT NULL CHECK (length(project_name) > 0)
);

CREATE TABLE ScadaNode (
    project_id     TEXT NOT NULL,
    node_id        TEXT NOT NULL CHECK (length(node_id) > 0),
    parent_node_id TEXT,
    node_kind      TEXT NOT NULL CHECK (length(node_kind) > 0),
    node_code      TEXT NOT NULL CHECK (length(node_code) > 0),
    node_name      TEXT NOT NULL CHECK (length(node_name) > 0),
    sort_order     INTEGER NOT NULL DEFAULT 0,
    PRIMARY KEY (project_id, node_id),
    UNIQUE (project_id, node_code),
    CHECK (parent_node_id IS NULL OR parent_node_id <> node_id),
    FOREIGN KEY (project_id) REFERENCES ScadaProject(project_id) ON DELETE RESTRICT,
    FOREIGN KEY (project_id, parent_node_id)
        REFERENCES ScadaNode(project_id, node_id) ON DELETE RESTRICT
);

CREATE INDEX IX_ScadaNode_Parent
    ON ScadaNode(project_id, parent_node_id, sort_order);

CREATE TABLE ScadaTag (
    project_id    TEXT NOT NULL,
    tag_id        TEXT NOT NULL CHECK (length(tag_id) > 0),
    owner_node_id TEXT NOT NULL,
    tag_code      TEXT NOT NULL CHECK (length(tag_code) > 0),
    display_name  TEXT NOT NULL CHECK (length(display_name) > 0),
    tag_kind      TEXT NOT NULL CHECK (length(tag_kind) > 0),
    value_type    TEXT NOT NULL CHECK (length(value_type) > 0),
    unit          TEXT,
    is_writable   INTEGER NOT NULL DEFAULT 0 CHECK (is_writable IN (0, 1)),
    is_enabled    INTEGER NOT NULL DEFAULT 1 CHECK (is_enabled IN (0, 1)),
    PRIMARY KEY (project_id, tag_id),
    UNIQUE (project_id, tag_code),
    FOREIGN KEY (project_id, owner_node_id)
        REFERENCES ScadaNode(project_id, node_id) ON DELETE RESTRICT
);

CREATE INDEX IX_ScadaTag_Owner
    ON ScadaTag(project_id, owner_node_id);

CREATE TABLE ScadaProcessTag (
    project_id      TEXT NOT NULL,
    process_node_id TEXT NOT NULL,
    tag_id          TEXT NOT NULL,
    role_code       TEXT NOT NULL DEFAULT '',
    sort_order      INTEGER NOT NULL DEFAULT 0,
    PRIMARY KEY (project_id, process_node_id, tag_id),
    FOREIGN KEY (project_id, process_node_id)
        REFERENCES ScadaNode(project_id, node_id) ON DELETE RESTRICT,
    FOREIGN KEY (project_id, tag_id)
        REFERENCES ScadaTag(project_id, tag_id) ON DELETE RESTRICT
);

CREATE INDEX IX_ScadaProcessTag_Tag
    ON ScadaProcessTag(project_id, tag_id);
