INSERT INTO
    ValidationResults (
        CheckName,
        FailedRows,
        RunTime
    )
SELECT 'Funds_NullRequiredFields', COUNT(*), datetime('now')
FROM Funds
WHERE
    FundNumber IS NULL
    OR FundDescription IS NULL;

-- Auto-fix: funds with no contributions AND no pledges
DELETE FROM Funds
WHERE
    FundNumber IN (
        SELECT FundNumber
        FROM Funds
        WHERE
            NOT EXISTS (
                SELECT 1
                FROM ContributionsExport
                WHERE
                    ContributionsExport.FundNumber = Funds.FundNumber
            ) INTERSECT
        SELECT FundNumber
        FROM Funds
        WHERE
            NOT EXISTS (
                SELECT 1
                FROM Pledge
                WHERE
                    Pledge.FundNumber = Funds.FundNumber
            )
    );