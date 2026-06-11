INSERT INTO
    FormationFamilies (
        FamRecNum,
        Last_Name,
        REGenRemarks1,
        REConfRemarks1,
        REInactive1,
        REFamily1,
        CensusFamily1
    )
SELECT
    TRIM(fam.FamRecNum),
    TRIM(fam.Name),
    TRIM(fam.REGenRemarks1),
    TRIM(fam.REConfRemarks1),
    CASE
        WHEN fam.REInactive1 = 'TRUE' THEN 'YES'
        ELSE 'NO'
    END,
    CASE
        WHEN fam.REFamily1 = 'TRUE' THEN 'YES'
        ELSE 'NO'
    END,
    CASE
        WHEN fam.CensusFamily1 = 'TRUE' THEN 'YES'
        ELSE 'NO'
    END
FROM fam
WHERE
    fam.REFamily1 = 'TRUE';