DELETE FROM ContributionsExport WHERE Amount IS NULL;
-- Flag: orphaned families
INSERT INTO
    ValidationResults (
        CheckName,
        FailedRows,
        RunTime
    )
SELECT 'Contributions_OrphanedFamilies', COUNT(*), datetime('now')
FROM ContributionsExport C
WHERE
    NOT EXISTS (
        SELECT 1
        FROM WPFamilyExport F
        WHERE
            F.PDSParishID = C.PDSFamilyID
    );

-- Flag: null FundNumber
INSERT INTO
    ValidationResults (
        CheckName,
        FailedRows,
        RunTime
    )
SELECT 'Contributions_NullFundNumber', COUNT(*), datetime('now')
FROM ContributionsExport
WHERE
    FundNumber IS NULL;

-- Flag: orphaned fund
INSERT INTO
    ValidationResults (
        CheckName,
        FailedRows,
        RunTime
    )
SELECT 'Contributions_OrphanedFund', COUNT(*), datetime('now')
FROM ContributionsExport C
WHERE
    NOT EXISTS (
        SELECT 1
        FROM Funds F
        WHERE
            C.FundNumber = F.FundNumber
    );

-- Flag: orphaned activity
INSERT INTO
    ValidationResults (
        CheckName,
        FailedRows,
        RunTime
    )
SELECT 'Contributions_OrphanedActivity', COUNT(*), datetime('now')
FROM ContributionsExport C
WHERE
    NOT EXISTS (
        SELECT 1
        FROM FundActivities F
        WHERE
            C.Activity = F.Activity
    );

DELETE FROM ContributionsExport
WHERE
    NOT EXISTS (
        SELECT 1
        FROM FundActivities F
        WHERE
            ContributionsExport.Activity = F.Activity
    );
-- Flag: null activity
INSERT INTO
    ValidationResults (
        CheckName,
        FailedRows,
        RunTime
    )
SELECT 'Contributions_NullActivity', COUNT(*), datetime('now')
FROM ContributionsExport
WHERE
    Activity IS NULL;

-- Flag: null contribution date
INSERT INTO
    ValidationResults (
        CheckName,
        FailedRows,
        RunTime
    )
SELECT 'Contributions_NullDate', COUNT(*), datetime('now')
FROM ContributionsExport
WHERE
    ContributionDate IS NULL;