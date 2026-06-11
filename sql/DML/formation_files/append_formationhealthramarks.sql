INSERT INTO
    FormationHealthRemarks
SELECT
    Mem.MemRecNum,
    Mem.FamRecNum,
    COALESCE(MemRE.UserMemo1, '') AS Health_Remarks,
    CAST(
        TRIM(
            COALESCE(MemRE.UserMemo2, '') || ' ' || COALESCE(MemRE.UserMemo3, '') || ' ' || COALESCE(MemRE.UserMemo4, '')
        ) AS TEXT
    ) AS REGenRemarks1,
    CAST(
        TRIM(Mem.REConfRemarks1) AS TEXT
    ) AS REConfRemarks1
FROM MemRE
    LEFT JOIN Mem ON MemRE.MemRec = Mem.MemRecNum;