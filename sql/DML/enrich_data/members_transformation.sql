CREATE TABLE "Cell#" AS
SELECT DISTINCT
    MemPhone.Rec,
    MemPhone.Number,
    PHONETYP.Description,
    MemPhone.Unlisted
FROM MemPhone
    LEFT JOIN PHONETYP ON MemPhone.PhoneTypeRec = PHONETYP.PhoneTypeRec
WHERE
    MemPhone.Rec IS NOT NULL
    AND MemPhone.Number IS NOT NULL
    AND PHONETYP.Description LIKE '%Cell%';

INSERT INTO
    "Cell#" (
        Rec,
        Number,
        Description,
        Unlisted
    )
SELECT DISTINCT
    TRIM(MemPhone.Rec),
    TRIM(MemPhone.Number),
    TRIM(MemPhone.PhoneTypeRec),
    TRIM(MemPhone.Unlisted)
FROM MemPhone
WHERE (
        MemPhone.Rec IS NOT NULL
        AND MemPhone.Number IS NOT NULL
        AND MemPhone.PhoneTypeRec = 0
    )
    OR MemPhone.PhoneTypeRec IS NULL;

-- Work#
CREATE TABLE "Work#" AS
SELECT DISTINCT
    MemPhone.Rec,
    MemPhone.Number,
    PHONETYP.Description,
    MemPhone.Unlisted
FROM MemPhone
    LEFT JOIN PHONETYP ON MemPhone.PhoneTypeRec = PHONETYP.PhoneTypeRec
WHERE
    MemPhone.Rec IS NOT NULL
    AND MemPhone.Number IS NOT NULL
    AND PHONETYP.Description LIKE '%Work%';