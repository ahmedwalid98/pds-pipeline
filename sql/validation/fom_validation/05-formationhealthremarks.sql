DELETE FROM FormationHealthRemarks
WHERE
    NOT EXISTS (
        SELECT 1
        FROM WPMemberExport M
        WHERE
            M.PDSMemberID = FormationHealthRemarks.MemRecNum
    );

-- Auto-fix: orphaned families
DELETE FROM FormationHealthRemarks
WHERE
    NOT EXISTS (
        SELECT 1
        FROM WPFamilyExport F
        WHERE
            F.PDSParishID = FormationHealthRemarks.FamRecNum
    );

-- Auto-fix: all remark fields blank
DELETE FROM FormationHealthRemarks
WHERE (Health_Remarks IS NULL)
    AND (REGenRemarks1 IS NULL)
    AND (REConfRemarks1 IS NULL);