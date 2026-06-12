UPDATE WPFamilyExport
SET
    ParishHousehold = 'NO'
WHERE
    ParishHousehold IS NULL;

-- Flag: null PDSParishID
INSERT INTO
    ValidationResults (
        CheckName,
        FailedRows,
        RunTime
    )
SELECT 'WPFamilyExport_NullPDSParishID', COUNT(*), datetime('now')
FROM WPFamilyExport
WHERE
    PDSParishID IS NULL;

-- Flag: row count vs source
INSERT INTO
    ValidationResults (
        CheckName,
        FailedRows,
        RunTime
    )
SELECT 'RowCount_Families_Mismatch', ABS(
        (
            SELECT COUNT(*)
            FROM fam
        ) - (
            SELECT COUNT(*)
            FROM WPFamilyExport
        )
    ), datetime('now')
WHERE
    ABS(
        (
            SELECT COUNT(*)
            FROM fam
        ) - (
            SELECT COUNT(*)
            FROM WPFamilyExport
        )
    ) > 0;