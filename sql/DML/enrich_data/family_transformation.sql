CREATE TABLE "Home#" AS
SELECT DISTINCT
    Mem.FamRecNum,
    MemPhone.Number,
    PHONETYP.Description,
    MemPhone.Unlisted
FROM MemPhone
    LEFT JOIN PHONETYP ON MemPhone.PhoneTypeRec = PHONETYP.PhoneTypeRec
    LEFT JOIN Mem ON MemPhone.Rec = Mem.MemRecNum
WHERE
    Mem.FamRecNum IS NOT NULL
    AND MemPhone.Number IS NOT NULL
    AND PHONETYP.Description LIKE '%Home%';

INSERT INTO
    "Home#" (FamRecNum, Number, Unlisted)
SELECT FamPhone.Rec, FamPhone.Number, FamPhone.Unlisted
FROM FamPhone
WHERE
    FamPhone.Rec IS NOT NULL
    AND FamPhone.Number IS NOT NULL;

DELETE FROM "Home#"
WHERE
    ROWID NOT IN(
        SELECT MIN(ROWID)
        FROM "Home#"
        GROUP BY
            FamRecNum
    );