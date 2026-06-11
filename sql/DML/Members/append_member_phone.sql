with
    cte as (
        SELECT
            Mem.MemRecNum AS PDSMemberID,
            Fam.FamRecNum AS PDSFamilyID,
            Mem.PDSInactive1,
            MemTypeDescription,
            Mem.Gender,
            SUBSTR(
                Mem.Name,
                1,
                INSTR(Mem.Name, ',') - 1
            ) AS LastName,
            TRIM(
                CASE
                    WHEN INSTR(Mem.Name, ',') > 0 THEN SUBSTR(
                        Mem.Name,
                        INSTR(Mem.Name, ',') + 1,
                        CASE
                            WHEN INSTR(
                                SUBSTR(
                                    Mem.Name,
                                    INSTR(Mem.Name, ',') + 1
                                ),
                                '{'
                            ) > 0 THEN INSTR(
                                SUBSTR(
                                    Mem.Name,
                                    INSTR(Mem.Name, ',') + 1
                                ),
                                '{'
                            ) - 1
                            WHEN INSTR(
                                SUBSTR(
                                    Mem.Name,
                                    INSTR(Mem.Name, ',') + 1
                                ),
                                '('
                            ) > 0 THEN INSTR(
                                SUBSTR(
                                    Mem.Name,
                                    INSTR(Mem.Name, ',') + 1
                                ),
                                '('
                            ) - 1
                            WHEN INSTR(
                                SUBSTR(
                                    Mem.Name,
                                    INSTR(Mem.Name, ',') + 1
                                ),
                                '['
                            ) > 0 THEN INSTR(
                                SUBSTR(
                                    Mem.Name,
                                    INSTR(Mem.Name, ',') + 1
                                ),
                                '['
                            ) - 1
                            WHEN INSTR(
                                SUBSTR(
                                    Mem.Name,
                                    INSTR(Mem.Name, ',') + 1
                                ),
                                ','
                            ) > 0 THEN INSTR(
                                SUBSTR(
                                    Mem.Name,
                                    INSTR(Mem.Name, ',') + 1
                                ),
                                ','
                            ) - 1
                            ELSE LENGTH(Mem.Name)
                        END
                    )
                END
            ) AS FirstName,
            CASE
                WHEN TRIM(
                    PHONETYP.Description,
                    '!@#$%^&*()[]'
                ) LIKE '%cell%' THEN FamPhone.Number
                ELSE NULL
            END AS CellPhoneNumber,
            FamPhone.Number,
            TRIM(
                PHONETYP.Description,
                '!@#$%^&*()[]'
            ) AS phone_type,
            FamPhone.Unlisted
        FROM
            Fam
            INNER JOIN FamPhone ON Fam.FamRecNum = FamPhone.rec
            INNER JOIN PHONETYP ON FamPhone.PhoneTypeRec = PHONETYP.PhoneTypeRec
            INNER JOIN Mem ON Mem.FamRecNum = Fam.FamRecNum
        WHERE (
                MemTypeDescription = 'Head of Household'
                or MemTypeDescription = 'Spouse'
            )
            AND (
                (phone_type LIKE '%cel%')
                or (phone_type LIKE '%work%')
            )
    ),
    ranked_phones as (
        SELECT *, row_number() OVER (
                PARTITION BY
                    PDSFamilyID
            ) AS rn
        FROM cte
    ),
    min_max_rn as (
        select PDSFamilyID, Min(rn) as rn
        from ranked_phones
        group by
            PDSFamilyID
        union
        select PDSFamilyID, MAX(rn) as rn
        from ranked_phones
        group by
            PDSFamilyID
    ),
    final_fam_phones as (
        SELECT rp.*
        FROM
            ranked_phones rp
            JOIN min_max_rn mmr ON rp.PDSFamilyID = mmr.PDSFamilyID
            AND rp.rn = mmr.rn
    )
INSERT INTO
    WPMemberExportFamPhone (
        PDSFamilyID,
        PDSMemberID,
        Inactive,
        MemberType,
        Gender,
        LastName,
        FirstName,
        CellPhoneNumber,
        FamPhoneNumber,
        FamPhoneType,
        FamPhoneUnlisted
    )
SELECT
    PDSFamilyID,
    PDSMemberID,
    CASE
        WHEN PDSInactive1 = 'TRUE' THEN 'YES'
        ELSE 'NO'
    ENd AS Inactive,
    MemTypeDescription,
    Gender,
    LastName,
    FirstName,
    '' CellPhoneNumber,
    Number AS FamPhoneNumber,
    phone_type AS FamPhoneType,
    CASE
        WHEN Unlisted = 'TRUE' THEN 'YES'
        ELSE 'NO'
    END AS FamPhoneUnlisted
FROM final_fam_phones;

UPDATE WPMemberExportFamPhone
SET
    FamPhoneType = (
        CASE
            WHEN lower(FamPhoneType) LIKE '%cel%'
            and lower(Gender) = 'male' THEN 'Cell - His'
            WHEN lower(FamPhoneType) LIKE '%cel%'
            and lower(Gender) = 'female' THEN 'Cell - Hers'
            WHEN lower(FamPhoneType) LIKE '%work%'
            and lower(Gender) = 'male' THEN 'Work - His'
            WHEN lower(FamPhoneType) LIKE '%Work%'
            and lower(Gender) = 'female' THEN 'Work - Hers'
        END
    );