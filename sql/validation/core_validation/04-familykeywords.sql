DELETE FROM FamilyKeywords
WHERE
    NOT EXISTS (
        SELECT 1
        FROM WPFamilyExport F
        WHERE
            F.PDSParishID = FamilyKeywords.PDSParishID
    );

-- Auto-fix: null keyword
DELETE FROM FamilyKeywords WHERE Keyword IS NULL;