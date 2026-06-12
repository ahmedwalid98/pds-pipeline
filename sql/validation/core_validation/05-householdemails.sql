DELETE FROM HouseholdEmails
WHERE
    NOT EXISTS (
        SELECT 1
        FROM WPMemberExport M
        WHERE
            M.PDSMemberID = HouseholdEmails.PDSMemberID
    );

-- Auto-fix: orphaned families
DELETE FROM HouseholdEmails
WHERE
    NOT EXISTS (
        SELECT 1
        FROM WPFamilyExport F
        WHERE
            F.PDSParishID = HouseholdEmails.PDSFamilyID
    );

-- Flag: null required fields
INSERT INTO
    ValidationResults (
        CheckName,
        FailedRows,
        RunTime
    )
SELECT 'HouseholdEmails_NullRequiredFields', COUNT(*), datetime('now')
FROM HouseholdEmails
WHERE
    FamilyEmail1 IS NULL
    OR FirstName IS NULL
    OR LastName IS NULL;