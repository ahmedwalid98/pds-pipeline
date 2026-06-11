INSERT INTO
    WPMemberExport (
        MemberType,
        Relation,
        LastName,
        FirstName,
        MiddleName,
        Title,
        Gender,
        DOB,
        DateDeceased,
        DateDeceasedUnknown,
        MaritalStatus,
        Religion,
        Grade,
        PreferredLanguage,
        CellPhoneNumber,
        CellPhoneNumberUnlisted,
        WorkPhoneNumber,
        EMailAddress,
        Notes,
        PDSFamilyID,
        PDSMemberID,
        Inactive,
        DateInactive,
        ConfidentialNotes,
        Location,
        MaidenName,
        PreferredName,
        School,
        Occupation
    )
SELECT DISTINCT
    MemTypeDescription,
    RelType.Description,
    CASE
        WHEN INSTR(Mem.NAme, ',') > 0 THEN TRIM(
            SUBSTR(
                Mem.Name,
                1,
                INSTR(Mem.Name, ',') - 1
            )
        )
        ELSE Mem.NAme
    END AS LastName,
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
    ) AS FirstName,
    CASE
        WHEN INSTR(Mem.Name, '{') > 0 THEN TRIM(
            SUBSTR(
                Mem.Name,
                INSTR(Mem.Name, '{') + 1,
                INSTR(Mem.Name, '}') - INSTR(Mem.Name, '{') - 1
            )
        )
        ELSE NULL
    END AS MiddleName,
    TRIM(
        CASE
            WHEN INSTR(
                SUBSTR(
                    Mem.Name,
                    INSTR(Mem.Name, ',') + 1
                ),
                ','
            ) > 0 THEN SUBSTR(
                Mem.Name,
                instr(Mem.Name, ',') + instr(
                    substr(
                        Mem.Name,
                        instr(Mem.Name, ',') + 1
                    ),
                    ','
                ) + 1
            )
            ELSE NULL
        END
    ) AS Prefix,
    Mem.Gender,
    Mem.DateOfBirth,
    Mem.DeceasedDate,
    CASE
        WHEN Mem.Deceased = 'TRUE'
        AND Mem.DeceasedDate IS NULL THEN 1
        ELSE 0
    END,
    MemStatType.Description,
    User1KW.Description,
    GradeType.Description,
    LangType.Description,
    "Cell#".Number,
    CASE
        WHEN "Cell#".Unlisted = 'TRUE' THEN 'YES'
        ELSE 'NO'
    END AS Unlisted,
    "Work#".Number,
    memEMail.EMailAddress,
    Mem.GenRemarks1,
    Mem.FamRecNum,
    Mem.MemRecNum,
    CASE
        WHEN Mem.PDSInactive1 = 'TRUE' THEN 'YES'
        ELSE 'NO'
    END AS PDSInactive,
    Mem.PDSInactDate1,
    Mem.ConfRemarks1,
    Mem.Location,
    CASE
        WHEN INSTR(Mem.Name, '[') > 0 THEN TRIM(
            SUBSTR(
                Mem.Name,
                INSTR(Mem.Name, '[') + 1,
                INSTR(Mem.Name, ']') - INSTR(Mem.Name, '[') - 1
            )
        )
        ELSE NULL
    END AS MaidenName,
    CASE
        WHEN INSTR(Mem.Name, '(') > 0 THEN TRIM(
            SUBSTR(
                Mem.Name,
                INSTR(Mem.Name, '(') + 1,
                INSTR(Mem.Name, ')') - INSTR(Mem.Name, '(') - 1
            )
        )
        ELSE NULL
    END AS PreferredName,
    User5KW.Description,
    User3KW.Description
FROM
    Mem
    LEFT JOIN RelType ON Mem.RelDescRec = RelType.RelDescRec
    LEFT JOIN MemStatType ON Mem.MaritalStatusRec = MemStatType.MaritalStatusRec
    LEFT JOIN User1KW ON Mem.User1DescRec = User1KW.User1DescRec
    LEFT JOIN GradeType ON Mem.GradeDescRec = GradeType.GradeDescRec
    LEFT JOIN LangType ON Mem.LanguageRec = LangType.LanguageRec
    LEFT JOIN "Work#" ON "Work#".Rec = Mem.MemRecNum
    LEFT JOIN "Cell#" ON "Cell#".Rec = Mem.MemRecNum
    LEFT JOIN memEMail ON Mem.MemRecNum = memEMail.MemRecNum
    LEFT JOIN User3KW ON Mem.User3DescRec = User3KW.User3DescRec
    LEFT JOIN User5KW ON Mem.User5DescRec = User5KW.User5DescRec
WHERE
    Mem.MemRecNum IS NOT NULL
    AND (
        Mem.CensusMember1 = 'TRUE'
        OR Mem.REMember1 = 'TRUE'
    )
GROUP BY
    Mem.MemRecNum;

UPDATE WPMemberExport
SET
    Suffix = CASE
        WHEN INSTR(Title, ',') > 0 THEN TRIM(
            SUBSTR(Title, INSTR(Title, ',') + 1)
        )
        ELSE ''
    END,
    Title = CASE
        WHEN INSTR(Title, ',') > 0 THEN TRIM(
            SUBSTR(
                Title,
                1,
                INSTR(Title, ',') - 1
            )
        )
        ELSE title
    end;

with
    split_names as (
        SELECT DISTINCT
            fam.Name,
            TRIM(
                SUBSTR(
                    fam.Name,
                    1,
                    INSTR(fam.Name, ',') - 1
                )
            ) AS LastName,
            TRIM(
                SUBSTR(
                    fam.Name,
                    INSTR(fam.Name, ',') + 1,
                    CASE
                        WHEN INSTR(
                            SUBSTR(
                                fam.Name,
                                INSTR(fam.Name, ',') + 1
                            ),
                            '{'
                        ) > 0 THEN INSTR(
                            SUBSTR(
                                fam.Name,
                                INSTR(fam.Name, ',') + 1
                            ),
                            '{'
                        ) - 1
                        WHEN INSTR(
                            SUBSTR(
                                fam.Name,
                                INSTR(fam.Name, ',') + 1
                            ),
                            '['
                        ) > 0 THEN INSTR(
                            SUBSTR(
                                fam.Name,
                                INSTR(fam.Name, ',') + 1
                            ),
                            '['
                        ) - 1
                        WHEN INSTR(
                            SUBSTR(
                                fam.Name,
                                INSTR(fam.Name, ',') + 1
                            ),
                            '('
                        ) > 0 THEN INSTR(
                            SUBSTR(
                                fam.Name,
                                INSTR(fam.Name, ',') + 1
                            ),
                            '('
                        ) - 1
                        WHEN INSTR(
                            SUBSTR(
                                fam.Name,
                                INSTR(fam.Name, ',') + 1
                            ),
                            ','
                        ) > 0 THEN INSTR(
                            SUBSTR(
                                fam.Name,
                                INSTR(fam.Name, ',') + 1
                            ),
                            ','
                        ) - 1
                        ELSE LENGTH(fam.Name)
                    END
                )
            ) AS FirstName,
            CASE
                WHEN INSTR(fam.Name, '{') > 0 THEN TRIM(
                    SUBSTR(
                        fam.Name,
                        INSTR(fam.Name, '{') + 1,
                        INSTR(fam.Name, '}') - INSTR(fam.Name, '{') - 1
                    )
                )
                WHEN INSTR(fam.Name, '(') > 0 THEN TRIM(
                    SUBSTR(
                        fam.Name,
                        INSTR(fam.Name, '(') + 1,
                        INSTR(fam.Name, ')') - INSTR(fam.Name, '(') - 1
                    )
                )
                ELSE NULL
            END AS MiddleName,
            TRIM(
                CASE
                    WHEN INSTR(
                        SUBSTR(
                            fam.Name,
                            INSTR(fam.Name, ',') + 1
                        ),
                        ','
                    ) > 0 THEN SUBSTR(
                        fam.Name,
                        instr(fam.Name, ',') + instr(
                            substr(
                                fam.Name,
                                instr(fam.Name, ',') + 1
                            ),
                            ','
                        ) + 1
                    )
                    ELSE NULL
                END
            ) AS Prefix,
            fam.FamRecNum
        FROM fam
        WHERE
            fam.FamRecNum NOT IN(
                Select PDSFamilyID
                from WPMemberExport
            )
    ),
    change_titles as (
        SELECT
            name,
            LastName,
            FirstName,
            MiddleName,
            CASE
                WHEN Prefix = 'M/M' THEN 'Mr&Mrs'
                ELSE Prefix
            END AS Prefix,
            FamRecNum
        FROM split_names
    ),
    split_records AS (
        SELECT
            -- Crop LastName if it has ( ... )
            TRIM(
                CASE
                    WHEN INSTR(LastName, '(') > 0 THEN SUBSTR(
                        LastName,
                        1,
                        INSTR(LastName, '(') -1
                    )
                    ELSE LastName
                END
            ) AS LastName,
            FirstName AS First1,
            FirstName AS FirstFamilyName,
            FamRecNum,
            CASE
                WHEN Prefix LIKE '%&%' THEN TRIM(
                    SUBSTR(
                        Prefix,
                        1,
                        INSTR(Prefix, '&') -1
                    )
                )
                WHEN Prefix LIKE '%/%' THEN TRIM(
                    SUBSTR(
                        Prefix,
                        1,
                        INSTR(Prefix, '/') -1
                    )
                )
                ELSE Prefix
            END AS Title
        FROM change_titles
        UNION
        SELECT
            TRIM(
                CASE
                    WHEN INSTR(LastName, '(') > 0 THEN SUBSTR(
                        LastName,
                        1,
                        INSTR(LastName, '(') -1
                    )
                    ELSE LastName
                END
            ) AS LastName,
            CASE
                WHEN length(MiddleName) > 0 THEN MiddleName
                ELSE NULL
            END AS First2,
            FirstName AS FirstFamilyName,
            FamRecNum,
            CASE
                WHEN Prefix LIKE '%&%' THEN TRIM(
                    SUBSTR(
                        Prefix,
                        INSTR(Prefix, '&') + 1
                    )
                )
                WHEN Prefix LIKE '%/%' THEN TRIM(
                    SUBSTR(
                        Prefix,
                        INSTR(Prefix, '/') + 1
                    )
                )
                ELSE Prefix
            END AS Title
        FROM change_titles
    ),
    ranking_records as (
        select *, ROW_NUMBER() OVER (
                ORDER BY CAST(FamRecNum AS INTEGER)
            ) as rn
        from split_records
    ),
    members_with_id as (
        select *, (
                (
                    SELECT MAX(CAST(MemRecNum AS INTEGER))
                    FROM Mem
                ) + rn
            ) as MemRecNum
        from ranking_records
    ),
    member_type as (
        SELECT
            LastName,
            First1 as FirstName,
            FamRecNum,
            MemRecNum,
            title,
            CASE
                when first1 = firstfamilyName THEN 'Head of Household'
                ELSE 'Spouse'
            END as MemberType,
            'Head of Household' as relation,
            'NO' AS Inactive,
            'NO' AS CellPhoneNumberUnlisted
        FROM members_with_id
    )
INSERT INTO
    WPMemberExport (
        MemberType,
        Relation,
        LastName,
        FirstName,
        title,
        CellPhoneNumberUnlisted,
        PDSFamilyID,
        PDSMemberID,
        Inactive
    )
SELECT
    MemberType,
    Relation,
    LastName,
    FirstName,
    Title,
    CellPhoneNumberUnlisted,
    FamRecNum,
    MemRecNum,
    Inactive
FROM member_type;

WITH
    CTE AS (
        SELECT *
        FROM WPMemberExport
        WHERE
            PDSFamilyID in (
                SELECT PDSParishID
                FROM WPFamilyExport F
                WHERE
                    NOT EXISTS (
                        SELECT 1
                        FROM WPMemberExport M
                        WHERE
                            m.PDSFamilyID = F.PDSParishID
                            AND MemberType in ('Head of Household', 'Spouse')
                    )
            )
            AND DateDeceased IS NULL
    ),
    family_names as (
        SELECT CTE.PDSMemberID, CTE.PDSFamilyID, CTE.DOB, CTE.FirstName, CTE.LastName, TRIM(
                SUBSTR(
                    fam.Name, INSTR(fam.Name, ',') + 1, CASE
                        WHEN INSTR(
                            SUBSTR(
                                fam.Name, INSTR(fam.Name, ',') + 1
                            ), '{'
                        ) > 0 THEN INSTR(
                            SUBSTR(
                                fam.Name, INSTR(fam.Name, ',') + 1
                            ), '{'
                        ) - 1
                        WHEN INSTR(
                            SUBSTR(
                                fam.Name, INSTR(fam.Name, ',') + 1
                            ), '['
                        ) > 0 THEN INSTR(
                            SUBSTR(
                                fam.Name, INSTR(fam.Name, ',') + 1
                            ), '['
                        ) - 1
                        WHEN INSTR(
                            SUBSTR(
                                fam.Name, INSTR(fam.Name, ',') + 1
                            ), '('
                        ) > 0 THEN INSTR(
                            SUBSTR(
                                fam.Name, INSTR(fam.Name, ',') + 1
                            ), '('
                        ) - 1
                        WHEN INSTR(
                            SUBSTR(
                                fam.Name, INSTR(fam.Name, ',') + 1
                            ), ','
                        ) > 0 THEN INSTR(
                            SUBSTR(
                                fam.Name, INSTR(fam.Name, ',') + 1
                            ), ','
                        ) - 1
                        ELSE LENGTH(fam.Name)
                    END
                )
            ) AS FamilyName
        from CTE
            JOIN Fam ON CTE.PDSFamilyID = fam.FamRecNum
    ),
    matches_names as (
        SELECT *
        FROM Family_names
        WHERE
            FirstName = FamilyName
    )
UPDATE WPMemberExport
SET
    MemberType = 'Head of Household',
    Relation = 'HEAD'
WHERE
    PDSMemberID IN (
        SELECT PDSMemberID
        FROM matches_names
    );

WITH
    CTE AS (
        SELECT *, row_number() OVER (
                PARTITION BY
                    PDSFamilyID
                ORDER BY PDSMemberID
            ) as rn
        FROM WPMemberExport
        WHERE
            PDSFamilyID in (
                SELECT PDSParishID
                FROM WPFamilyExport F
                WHERE
                    NOT EXISTS (
                        SELECT 1
                        FROM WPMemberExport M
                        WHERE
                            m.PDSFamilyID = F.PDSParishID
                            AND MemberType in ('Head of Household', 'Spouse')
                    )
            )
            AND DateDeceased IS NULL
    ),
    family_names as (
        SELECT CTE.PDSMemberID, CTE.PDSFamilyID, CTE.DOB, CTE.FirstName, CTE.LastName, CTE.rn, TRIM(
                SUBSTR(
                    fam.Name, INSTR(fam.Name, ',') + 1, CASE
                        WHEN INSTR(
                            SUBSTR(
                                fam.Name, INSTR(fam.Name, ',') + 1
                            ), '{'
                        ) > 0 THEN INSTR(
                            SUBSTR(
                                fam.Name, INSTR(fam.Name, ',') + 1
                            ), '{'
                        ) - 1
                        WHEN INSTR(
                            SUBSTR(
                                fam.Name, INSTR(fam.Name, ',') + 1
                            ), '['
                        ) > 0 THEN INSTR(
                            SUBSTR(
                                fam.Name, INSTR(fam.Name, ',') + 1
                            ), '['
                        ) - 1
                        WHEN INSTR(
                            SUBSTR(
                                fam.Name, INSTR(fam.Name, ',') + 1
                            ), '('
                        ) > 0 THEN INSTR(
                            SUBSTR(
                                fam.Name, INSTR(fam.Name, ',') + 1
                            ), '('
                        ) - 1
                        WHEN INSTR(
                            SUBSTR(
                                fam.Name, INSTR(fam.Name, ',') + 1
                            ), ','
                        ) > 0 THEN INSTR(
                            SUBSTR(
                                fam.Name, INSTR(fam.Name, ',') + 1
                            ), ','
                        ) - 1
                        ELSE LENGTH(fam.Name)
                    END
                )
            ) AS FamilyName
        from CTE
            JOIN Fam ON CTE.PDSFamilyID = fam.FamRecNum
    ),
    matches_names as (
        SELECT *
        FROM Family_names
    )
UPDATE WPMemberExport
SET
    MemberType = (
        SELECT
            CASE
                WHEN rn = 1 THEN 'Head of Household'
                ELSE 'Spouse'
            END
        FROM matches_names
        WHERE
            matches_names.PDSMemberID = WPMemberExport.PDSMemberID
    ),
    Relation = (
        SELECT
            CASE
                WHEN rn = 1 THEN 'HEAD'
                ELSE 'SPOUSE'
            END
        FROM matches_names
        WHERE
            matches_names.PDSMemberID = WPMemberExport.PDSMemberID
    )
WHERE
    PDSMemberID IN (
        SELECT PDSMemberID
        FROM matches_names
        where
            rn <= 2
    );

UPDATE WPMemberExport
set
    Title = substr(
        Title,
        1,
        INstr(Title, '(') - 1
    )
WHERE
    Title like '%(%';

UPDATE WPMemberExport
set
    Title = substr(
        Title,
        1,
        INstr(Title, '[') - 1
    )
WHERE
    Title like '%[%'

UPDATE WPMemberExport
set
    Title = substr(
        Title,
        1,
        INstr(Title, '{') - 1
    )
WHERE
    Title like '%{%';

UPDATE WPMemberExport
set
    FirstName = substr(
        FirstName,
        1,
        INstr(FirstName, ',') - 1
    )
WHERE
    FirstName like '%,%';