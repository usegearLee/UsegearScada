-- PostgreSQL user001.Dict_MenuTree -> encrypted SQLite main.Dict_MenuTree.
-- PostgreSQL schema, owner and COLLATE clauses do not apply to SQLite.
-- Keep legacy column names for future data import; FModuleInFace refers to
-- a VCL form class and is not a uniGUI navigation target by itself.
CREATE TABLE IF NOT EXISTS "Dict_MenuTree" (
  "FMenuTreeID" TEXT PRIMARY KEY NOT NULL,
  "FPMenuTreeID" TEXT,
  "FMenuTreeCode" TEXT,
  "FMenuTreeName" TEXT,
  "FRemark" TEXT,
  "FModuleInFace" TEXT,
  "FMenuTyp" TEXT,
  "FImgIndex" INTEGER,
  "FOpenType" TEXT,
  "FOpenModule" TEXT,
  "FWorkFlow" TEXT,
  "FModuleSass" TEXT,
  "FUrl" TEXT,
  "FPROCID" TEXT,
  "FModuleCaption" TEXT,
  "FModuleMemo" TEXT,
  "FConfig" TEXT
);

CREATE INDEX IF NOT EXISTS "IX_Dict_MenuTree_Parent"
  ON "Dict_MenuTree" ("FPMenuTreeID");

CREATE INDEX IF NOT EXISTS "IX_Dict_MenuTree_Code"
  ON "Dict_MenuTree" ("FMenuTreeCode");
