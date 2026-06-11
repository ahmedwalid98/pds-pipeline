INSERT INTO
    HouseholdEmails (
        FamilyEmail1,
        FirstName,
        LastName,
        FamilyEmail2,
        Email1,
        Email2,
        Email3,
        Email4,
        Email5,
        PDSMemberID,
        PDSFamilyID
    )
SELECT
    MAX(
        CASE
            WHEN rn = 1 THEN memEmail.EmailAddress
        END
    ) AS FamilyEmail1,
    TRIM(
        SUBSTR(
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
    ) AS FirstName,
    TRIM(
        SUBSTR(
            mem.Name,
            1,
            INSTR(mem.Name, ',') - 1
        )
    ) AS LastName,
    NULL AS FamilyEmail2,
    MAX(
        CASE
            WHEN rn = 1 THEN memEmail.EmailAddress
        END
    ) AS Email1,
    MAX(
        CASE
            WHEN rn = 2 THEN memEmail.EmailAddress
        END
    ) AS Email2,
    MAX(
        CASE
            WHEN rn = 3 THEN memEmail.EmailAddress
        END
    ) AS Email3,
    MAX(
        CASE
            WHEN rn = 4 THEN memEmail.EmailAddress
        END
    ) AS Email4,
    MAX(
        CASE
            WHEN rn = 5 THEN memEmail.EmailAddress
        END
    ) AS Email5,
    mem.MemRecNum,
    fam.FamRecNum AS PDSFamilyID
FROM (
        SELECT memEmail.*, ROW_NUMBER() OVER (
                PARTITION BY
                    memEmail.MemRecNum
                ORDER BY memEmail.EmailAddress
            ) AS rn
        FROM memEmail
        WHERE
            memEmail.FamEmail = 'TRUE'
    ) memEmail
    INNER JOIN mem ON memEmail.MemRecNum = mem.FamRecNum
    INNER JOIN fam ON mem.FamRecNum = fam.FamRecNum
GROUP BY
    mem.MemRecNum,
    fam.FamRecNum,
    fam.Name;