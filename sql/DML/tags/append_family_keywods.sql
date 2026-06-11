INSERT INTO
    FamilyKeywords (PDSParishID, Keyword)
SELECT DISTINCT
    TRIM(FamKW.FamRecNum),
    TRIM(FamKWType.Description)
FROM FamKW
    INNER JOIN FamKWType ON FamKWType.DescRec = FamKW.DescRec;