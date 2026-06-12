UPDATE WPMemberExport
SET
    CellPhoneNumberUnlisted = 'NO'
WHERE
    CellPhoneNumberUnlisted IS NULL;

-- Flag: null PDSMemberID
INSERT INTO
    ValidationResults (
        CheckName,
        FailedRows,
        RunTime
    )
SELECT 'WPMemberExport_NullPDSMemberID', COUNT(*), datetime('now')
FROM WPMemberExport
WHERE
    PDSMemberID IS NULL;

-- Flag: null FirstName
INSERT INTO
    ValidationResults (
        CheckName,
        FailedRows,
        RunTime
    )
SELECT 'WPMemberExport_NullFirstName', COUNT(*), datetime('now')
FROM WPMemberExport
WHERE
    FirstName IS NULL
    OR TRIM(FirstName) = '';

-- Flag: null LastName
INSERT INTO
    ValidationResults (
        CheckName,
        FailedRows,
        RunTime
    )
SELECT 'WPMemberExport_NullLastName', COUNT(*), datetime('now')
FROM WPMemberExport
WHERE
    LastName IS NULL
    OR TRIM(LastName) = '';

DELETE FROM WPMemberExportFamPhone WHERE Gender IS NULL;