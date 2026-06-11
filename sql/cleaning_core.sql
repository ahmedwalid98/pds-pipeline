CREATE TABLE IF NOT EXISTS [ttblMissingLinks] (
    [MissingRecId] TEXT
);

DELETE FROM fam
where
    fam.CensusFamily1 = 'FALSE'
    and fam.REFamily1 = 'FALSE';

DELETE FROM Mem
where
    Mem.CensusMember1 = 'FALSE'
    and Mem.REMember1 = 'FALSE';

with
    CTE AS (
        SELECT *
        FROM fam
        WHERE
            NOT EXISTS (
                SELECT 1
                from mem
                where
                    fam.FamRecNum = mem.FamRecNum
            )
    ),
    ids as (
        SELECT FamRecNum
        from CTE
        WHERE
            NOT EXISTS (
                SELECT 1
                from FamFundHist
                where
                    FamFundHist.fefamrec = Cte.FamRecNum
            )
    )
delete from fam
where
    famrecnum in (
        SELECT famrecnum
        from ids
    );

-- Fix names
update Mem set name =

-- prefix (before first brace)
substr(
    name,
    1,
    CASE
        WHEN instr(name, '{') > 0 THEN instr(name, '{') -1
        WHEN instr(name, '(') > 0 THEN instr(name, '(') -1
        WHEN instr(name, '[') > 0 THEN instr(name, '[') -1
        ELSE length(name)
    END
)

-- {} block
|| CASE
    WHEN instr(name, '{') > 0 THEN '{' || substr(
        name,
        instr(name, '{') + 1,
        CASE
            WHEN instr(
                substr(name, instr(name, '{') + 1),
                '('
            ) > 0 THEN instr(
                substr(name, instr(name, '{') + 1),
                '('
            ) -1
            WHEN instr(
                substr(name, instr(name, '{') + 1),
                '['
            ) > 0 THEN instr(
                substr(name, instr(name, '{') + 1),
                '['
            ) -1
            ELSE length(name)
        END
    ) || '}'
    ELSE ''
END

-- () block
|| CASE
    WHEN instr(name, '(') > 0 THEN '(' || substr(
        name,
        instr(name, '(') + 1,
        CASE
            WHEN instr(
                substr(name, instr(name, '(') + 1),
                '['
            ) > 0 THEN instr(
                substr(name, instr(name, '(') + 1),
                '['
            ) -1
            ELSE length(name)
        END
    ) || ')'
    ELSE ''
END

-- [] block
|| CASE
    WHEN instr(name, '[') > 0 THEN '[' || substr(name, instr(name, '[') + 1) || ']'
    ELSE ''
END
WHERE (
        name LIKE '%{%'
        AND name NOT LIKE '%}%'
    )
    OR (
        name LIKE '%(%'
        AND name NOT LIKE '%)%'
    )
    OR (
        name LIKE '%[%'
        AND name NOT LIKE '%]%'
    );

-- Deleting ministreis with missing members
DELETE FROM ttblMissingLinks;

INSERT INTO
    ttblMissingLinks (MissingRecId)
SELECT MemMin.MemRecNum
FROM MemMin
    LEFT JOIN mem on MemMin.MemRecNum = Mem.MemRecNum
WHERE
    Mem.MemRecNum IS NULL;

DELETE FROM MemMin
WHERE
    MemRecNum in (
        SELECT MissingRecId
        FROM ttblMissingLinks
    );

-- Deleting talents with missing members
DELETE FROM ttblMissingLinks;

INSERT INTO
    ttblMissingLinks (MissingRecId)
SELECT MemTal.MemRecNum
FROM MemTal
    LEFT JOIN Mem ON MemTal.MemRecNum = Mem.MemRecNum
WHERE
    Mem.MemRecNum IS NULL;

DELETE FROM MemTal
WHERE
    MemRecNum in (
        SELECT MissingRecId
        FROM ttblMissingLinks
    );
-- Getting messing links in ask table
DELETE FROM ttblMissingLinks;

INSERT INTO
    ttblMissingLinks (MissingRecId)
SELECT Ask.AskRecNum
FROM Ask
    LEFT JOIN Mem on Ask.AskMemNum = Mem.MemRecNum
WHERE
    Mem.MemRecNum Is NULL;

DELETE FROM Ask
WHERE
    Ask.AskRecNum in (
        SELECT MissingRecId
        FROM ttblMissingLinks
    );

-- Get missing members in MemDates table
DELETE FROM ttblMissingLinks;

INSERT INTO
    ttblMissingLinks (MissingRecId)
SELECT MemDates.MemDateRecNum
FROM MemDates
    LEFT JOIN Mem ON MemDates.MemRecNum = Mem.MemRecNum
WHERE
    Mem.MemRecNum IS NULL;

DELETE FROM MemDates
WHERE
    MemDates.MemRecNum IN (
        SELECT MissingRecId
        FROM ttblMissingLinks
    );

-- Update mem sac 0 entries to null
UPDATE MemSac SET Vol = NUlL WHERE MemSac.Vol <= 0;

UPDATE MemSac SET Page = NULL WHERE MemSac.Page <= 0;

UPDATE MemSac SET Entry = Null WHERE MemSac.Entry <= 0;

-- Update reg tables to remove members number is 0
UPDATE BapReg SET MemRecNum = NULL WHERE BapReg.MemRecNum = 0;

UPDATE FirstCommReg
SET
    MemRecNum = NULL
WHERE
    FirstCommReg.MemRecNum = 0;

UPDATE ConfReg SET MemRecNum = NULL WHERE ConfReg.MemRecNum = 0;

UPDATE MarReg SET MemRecNum = NULL WHERE MarReg.MemRecNum = 0;

UPDATE DeathReg SET MemRecNum = NULL WHERE DeathReg.MemRecNum = 0;

-- Get missing links BabReg to mem
DELETE FROM ttblMissingLinks;

INSERT INTO
    ttblMissingLinks (MissingRecId)
SELECT BapReg.MemRecNum
FROM BapReg
    LEFT JOIN Mem on BapReg.MemRecNum = Mem.MemRecNum
WHERE (BapReg.MemRecNum IS NOT NULL)
    AND (Mem.MemRecNum IS NULL);

UPDATE BapReg
SET
    MemRecNum = NULL
WHERE
    MemRecNum IN (
        SELECT MissingRecId
        FROM ttblMissingLinks
    );

-- Getting Broken links from FirstCommReg
DELETE FROM ttblMissingLinks;

INSERT INTO
    ttblMissingLinks (MissingRecId)
SELECT FirstCommReg.MemRecNum
FROM FirstCommReg
    LEFT JOIN Mem ON FirstCommReg.MemRecNum = Mem.MemRecNum
WHERE (
        FirstCommReg.MemRecNum IS NOT NULL
    )
    AND (Mem.MemRecNum IS NULL);

UPDATE FirstCommReg
SET
    MemRecNum = NULL
WHERE
    MemRecNum in (
        SELECT MissingRecId
        FROM ttblMissingLinks
    );

-- Getting broken links from ConfReg
DELETE FROM ttblMissingLinks;

INSERT INTO
    ttblMissingLinks (MissingRecId)
SELECT ConfReg.MemRecNum
FROM ConfReg
    LEFT JOIN Mem on ConfReg.MemRecNum = Mem.MemRecNum
WHERE (ConfReg.MemRecNum IS NOT NULL)
    AND (Mem.MemRecNum IS NULL);

UPDATE ConfReg
SET
    MemRecNum = NULL
WHERE
    MemRecNum in (
        SELECT MissingRecId
        FROM ttblMissingLinks
    );

-- Getting broken links from MarReg
DELETE FROM ttblMissingLinks;

INSERT INTO
    ttblMissingLinks (MissingRecId)
SELECT MarReg.MemRecNum
FROM MarReg
    LEFT JOIN Mem on MarReg.MemRecNum = Mem.MemRecNum
WHERE (MarReg.MemRecNum IS NOT NULL)
    AND (Mem.MemRecNum IS NULL);

UPDATE MarReg
SET
    MemRecNum = NULL
WHERE
    MemRecNum in (
        SELECT MissingRecId
        from ttblMissingLinks
    );

-- Getting broken links from DeathReg
DELETE FROM ttblMissingLinks;

INSERT INTO
    ttblMissingLinks (MissingRecId)
SELECT DeathReg.MemRecNum
FROM DeathReg
    LEFT JOIN Mem ON DeathReg.MemRecNum = Mem.MemRecNum
WHERE (
        DeathReg.MemRecNum IS NOT NULL
    )
    AND (Mem.MemRecNum IS NULL);

UPDATE DeathReg
SET
    MemRecNum = NULL
WHERE
    MemRecNum in (
        SELECT MissingRecId
        FROM ttblMissingLinks
    );

-- Update registries with RegChurch
UPDATE BapReg set RegChurch = 0;

UPDATE FirstCommReg set RegChurch = 0;

UPDATE ConfReg set RegChurch = 0;

UPDATE MarReg set RegChurch = 0;

UPDATE DeathReg set RegChurch = 0;

-- Udate date types to meet the Camino format
UPDATE DateType
SET
    description = (
        CASE
            WHEN lower(description) LIKE 'bapt%' THEN 'Baptism'
            WHEN lower(description) LIKE '%comm%' THEN 'FirstCommunion'
            WHEN lower(description) LIKE '%mar%' THEN 'Marriage'
            WHEN lower(description) LIKE 'dec%' THEN 'Deceased'
            WHEN lower(description) LIKE 'conf%' THEN 'Confirmation'
            WHEN lower(description) LIKE 'pen%' THEN 'Reconcil'
            WHEN lower(description) LIKE 'rec%' THEN 'Reconcil'
            WHEN lower(description) LIKE 'rci%' THEN 'RCIA'
            ELSE NULL -- Keeps original if no match
        END
    );

DELETE FROM MemDates
WHERE
    DescRec in (
        SELECT DescRec
        FROM DateType
        WHERE
            description is NULL
    );

-- Get missing members in MemSpons table
DELETE FROM ttblMissingLinks;

INSERT INTO
    ttblMissingLinks (MissingRecId)
SELECT MemSpons.SponsorRecNum
FROM MemSpons
    LEFT JOIN MemSac ON MemSpons.SacRecNum = MemSac.SacRecNum
WHERE
    MemSac.SacRecNum IS NULL;

DELETE FROM MemSpons
WHERE
    MemSpons.SponsorRecNum in (
        SELECT MissingRecId
        FROM ttblMissingLinks
    );

-- Delete any sacraments that will not be converted
DELETE FROM ttblMissingLinks;

INSERT INTO
    ttblMissingLinks (MissingRecId)
SELECT MemSac.SacRecNum
FROM MemSac
    LEFT JOIN MemDates on MemSac.SacMemDateRec = MemDates.MemDateRecNum
WHERE
    MemDates.MemDateRecNum is NULL;

DELETE FROM MemSac
WHERE
    SacRecNum in (
        SELECT MissingRecId
        FROM ttblMissingLinks
    );

-- Get missing members in MemSac Table
DELETE FROM ttblMissingLinks;

INSERT INTO
    ttblMissingLinks (MissingRecId)
SELECT MemSac.SacRecNum
FROM MemSac
    LEFT JOIN Mem on MemSac.SacMemRec = Mem.MemRecNum
WHERE
    Mem.MemRecNum IS NULL;

DELETE FROM MemSac
WHERE
    MemSac.SacRecNum in (
        SELECT MissingRecId
        FROM ttblMissingLinks
    );

-- Deleteing missing links from families keywords
DELETE FROM ttblMissingLinks;

INSERT INTO
    ttblMissingLinks (MissingRecId)
SELECT FamKW.FamRecNum
FROM FamKW
    LEFT JOIN fam on FamKW.FamRecNum = fam.FamRecNum
WHERE
    fam.FamRecNum IS NULL;

DELETE FROM FamKW
WHERE
    FamRecNum in (
        SELECT MissingRecId
        FROM ttblMissingLinks
    );

-- Delete Missing Links for the contribtuions
DELETE FROM ttblMissingLinks;

INSERT INTO
    ttblMissingLinks (MissingRecId)
SELECT DISTINCT
    FamFundHist.FEFamRec
FROM FamFundHisT
    LEFT JOIN fam on FamFundHist.FEFamRec = fam.FamRecNum
WHERE
    fam.FamRecNum IS NULL;

DELETE FROM FamFundHist
WHERE
    FEFamRec in (
        SELECT MissingRecId
        FROM ttblMissingLinks
    );

-- Delete missing links in fam fund table
DELETE FROM ttblMissingLinks;

INSERT INTO
    ttblMissingLinks (MissingRecId)
SELECT DISTINCT
    FamFund.FDFamRec
FROM FamFund
    LEFT JOIN fam on FamFund.FDFamRec = fam.FamRecNum
WHERE
    fam.FamRecNum IS NULL;

DELETE FROM FamFund
WHERE
    FDFamRec in (
        SELECT MissingRecId
        FROM ttblMissingLinks
    );

WITH
    wrong_ids AS (
        SELECT ChurchContact.Name, Mem.MemRecNum
        FROM ChurchContact
            JOIN Mem on ChurchContact.Name = Mem.Name
            AND ChurchContact.MemRecNum <> Mem.MemRecNum
    )
UPDATE ChurchContact
SET
    MemRecNum = (
        SELECT MemRecNum
        FROm wrong_ids
        WHERE
            Name = ChurchContact.Name
    )
WHERE
    Name in (
        SELECT Name
        FROM wrong_ids
    );

ALTER TABLE Mem ADD COLUMN MemTypeDescription TEXT;

UPDATE Mem
SET
    MemTypeDescription = CASE
        WHEN MemberType = '0' THEN 'Head of Household'
        WHEN MemberType = '1' THEN 'Spouse'
        WHEN MemberType = '2' THEN 'Adult'
        WHEN MemberType = '3' THEN 'Young Adult'
        WHEN MemberType = '4' THEN 'Child'
        WHEN MemberType = '5' THEN 'Other'
        WHEN MemberType = '6' THEN 'Deceased'
        ELSE NULL
    END;

ALTER TABLE FamFundRate ADD COLUMN PeriodDescription TEXT;

UPDATE FamFundRate
SET
    PeriodDescription = CASE
        WHEN CAST(FDPeriod AS INTEGER) < 8 THEN 'Weekly'
        WHEN CAST(FDPeriod AS INTEGER) = 8 THEN 'Monthly'
        WHEN CAST(FDPeriod AS INTEGER) = 11 THEN 'Quarterly'
        WHEN CAST(FDPeriod AS INTEGER) = 12 THEN 'SemiAnnual'
        WHEN CAST(FDPeriod AS INTEGER) = 13 THEN 'Annual'
        WHEN CAST(FDPeriod AS INTEGER) = 14 THEN 'OneTime'
        WHEN CAST(FDPeriod AS INTEGER) = 15 THEN 'Biweekly'
        WHEN CAST(FDPeriod AS INTEGER) = 16 THEN 'OneTime'
        ELSE NULL
    END;