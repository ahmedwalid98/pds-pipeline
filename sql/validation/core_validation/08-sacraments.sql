DELETE FROM SacramentBooks
WHERE
    NOT EXISTS (
        SELECT 1
        FROM WPMemberExport M
        WHERE
            M.PDSMemberID = SacramentBooks.PDSMemberID
    );

-- Auto-fix: null date
DELETE FROM SacramentBooks WHERE Date IS NULL;

-- Auto-fix: all volume/page/entry blank
DELETE FROM SacramentBooks
WHERE
    Volume IS NULL
    AND Page IS NULL
    AND Entry IS NULL;

-- Flag: invalid sacrament type
INSERT INTO
    ValidationResults (
        CheckName,
        FailedRows,
        RunTime
    )
SELECT 'SacramentBooks_InvalidSacramentType', COUNT(*), datetime('now')
FROM SacramentBooks
WHERE
    TRIM(Sacrament) NOT IN(
        'Baptism',
        'FirstCommunion',
        'Confirmation',
        'Marriage'
    );

DELETE FROM SacramentBooks
WHERE
    TRIM(Sacrament) NOT IN(
        'Baptism',
        'FirstCommunion',
        'Confirmation',
        'Marriage'
    );
-- Flag: null sacrament
INSERT INTO
    ValidationResults (
        CheckName,
        FailedRows,
        RunTime
    )
SELECT 'SacramentBooks_NullSacrament', COUNT(*), datetime('now')
FROM SacramentBooks
WHERE
    Sacrament IS NULL;

-- ============================================================
-- SACRAMENTSPONSORS
-- ============================================================

-- Auto-fix: orphaned members
DELETE FROM SacramentSponsors
WHERE
    NOT EXISTS (
        SELECT 1
        FROM WPMemberExport M
        WHERE
            M.PDSMemberID = SacramentSponsors.PDSMemberID
    );

-- Auto-fix: 'Godparent' → blank per reference spec
UPDATE SacramentSponsors
SET
    SponsorType = ''
WHERE
    SponsorType = 'Godparent';

-- Flag: invalid sacrament type
INSERT INTO
    ValidationResults (
        CheckName,
        FailedRows,
        RunTime
    )
SELECT 'SacramentSponsors_InvalidSacrament', COUNT(*), datetime('now')
FROM SacramentSponsors
WHERE
    Sacrament NOT IN(
        'Baptism',
        'Confirmation',
        'RCIA',
        'OCIA',
        'Marriage'
    );

-- Flag: null sponsor name
INSERT INTO
    ValidationResults (
        CheckName,
        FailedRows,
        RunTime
    )
SELECT 'SacramentSponsors_NullSponsorName', COUNT(*), datetime('now')
FROM SacramentSponsors
WHERE
    SponsorName IS NULL
    OR TRIM(SponsorName) = '';

-- Flag: invalid sponsor type
INSERT INTO
    ValidationResults (
        CheckName,
        FailedRows,
        RunTime
    )
SELECT 'SacramentSponsors_InvalidSponsorType', COUNT(*), datetime('now')
FROM SacramentSponsors
WHERE
    SponsorType NOT IN(
        '',
        'Godmother',
        'Godfather',
        'Christian Witness',
        'Witness',
        'Sponsor'
    );

-- ============================================================
-- SACRAMENTS
-- ============================================================

-- Auto-fix: orphaned members
DELETE FROM Sacraments
WHERE
    NOT EXISTS (
        SELECT 1
        FROM WPMemberExport M
        WHERE
            M.PDSMemberID = Sacraments.PDSMemberID
    );