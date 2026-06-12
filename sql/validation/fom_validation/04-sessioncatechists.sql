DELETE FROM SessionCatechists WHERE ClassRecNum IS NULL;

-- Auto-fix: orphaned sessions
DELETE FROM SessionCatechists
WHERE
    NOT EXISTS (
        SELECT 1
        FROM Sessions
        WHERE
            Sessions.REClassRecNum = SessionCatechists.ClassRecNum
    );

-- Flag: null MemRecNum
INSERT INTO
    ValidationResults (
        CheckName,
        FailedRows,
        RunTime
    )
SELECT 'SessionCatechists_NullMemRecNum', COUNT(*), datetime('now')
FROM SessionCatechists
WHERE
    MemRecNum IS NULL
    OR TRIM(MemRecNum) = '';

DELETE FROM SessionCatechists WHERE MemRecNum IS NULL;