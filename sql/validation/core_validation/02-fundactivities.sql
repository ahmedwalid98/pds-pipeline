DELETE FROM FundActivities
WHERE
    NOT EXISTS (
        SELECT 1
        FROM Funds F
        WHERE
            F.FundNumber = FundActivities.FundNumber
    );

-- Auto-fix: orphaned contributions
DELETE FROM FundActivities
WHERE
    NOT EXISTS (
        SELECT 1
        FROM ContributionsExport C
        WHERE
            C.Activity = FundActivities.Activity
    );

-- Flag: null activity
INSERT INTO
    ValidationResults (
        CheckName,
        FailedRows,
        RunTime
    )
SELECT 'FundActivities_NullActivity', COUNT(*), datetime('now')
FROM FundActivities
WHERE
    Activity IS NULL;