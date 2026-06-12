DELETE FROM ClassDates
WHERE
    NOT EXISTS (
        SELECT 1
        FROM Sessions S
        WHERE
            CAST(S.REClassRecNum AS INTEGER) = CAST(
                ClassDates.ClassRecNum AS INTEGER
            )
    );

-- Auto-fix: null date
DELETE FROM ClassDates
WHERE
    ClassDate IS NULL
    OR TRIM(ClassDate) = '';

-- ============================================================
-- SESSIONS
-- ============================================================

-- Flag: null required fields
INSERT INTO
    ValidationResults (
        CheckName,
        FailedRows,
        RunTime
    )
SELECT 'Sessions_NullRequiredFields', COUNT(*), datetime('now')
FROM Sessions
WHERE
    Name IS NULL
    OR REClassRecNum IS NULL;

DELETE FROM Sessions
WHERE
    Name IS NULL
    OR REClassRecNum IS NULL