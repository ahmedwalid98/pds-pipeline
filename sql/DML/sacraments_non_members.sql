-- Baptism info
INSERT
    OR IGNORE INTO SacramentExport_NonMem (
        LastName,
        FirstName,
        MiddleName,
        Suffix,
        DOB,
        Gender,
        Father,
        Mother,
        BirthPlace,
        Description,
        Volume,
        Page,
        Entry,
        SacDate,
        Status,
        BaptismName,
        PerformedBy,
        GenNotes,
        Sponsor1,
        Sponsor2,
        Proxy1,
        Proxy2,
        PlaceID,
        Place,
        Address1,
        City,
        State,
        Zip,
        Country,
        ProfOfFaith
    )
SELECT DISTINCT
    LastName,
    FirstName,
    MiddleName,
    Suffix,
    IFNULL(BirthDate, '2050-01-01') AS DOB,
    Gender,
    Father,
    Mother,
    BirthPlace,
    'Baptism' AS Description,
    Volume,
    Page,
    Entry,
    BapDate AS SacDate,
    CASE
        WHEN BapDate IS NOT NULL
        AND IFNULL(BapApprox, 'F') <> 'Y' THEN 'Y'
        WHEN IFNULL(BapApprox, 'F') = 'Y' THEN 'A'
        ELSE 'Y'
    END AS Status,
    BaptismalName AS BaptismName,
    PerformedBy,
    GenRem AS GenNotes,
    Sponsor1,
    Sponsor2,
    Proxy1,
    Proxy2,
    RegChurch AS PlaceID,
    Place,
    Address1,
    SUBSTR(
        CityState,
        1,
        INSTR(CityState, ',') - 1
    ) AS City,
    TRIM(
        SUBSTR(
            CityState,
            INSTR(CityState, ',') + 1,
            LENGTH(CityState) - INSTR(CityState, ',')
        )
    ) AS State,
    Zip,
    Country,
    IsProfofFaith AS ProfOfFaith
FROM BapReg
    LEFT JOIN DatePlace ON BapReg.RegChurch = DatePlace.DatePlaceRecNum
WHERE
    MemRecNum IS NULL
    AND LastName IS NOT NULL;

-- FirstComm Info

INSERT
    OR IGNORE INTO SacramentExport_NonMem (
        LastName,
        FirstName,
        MiddleName,
        Suffix,
        Gender,
        Father,
        Mother,
        Description,
        Volume,
        Page,
        Entry,
        SacDate,
        Status,
        PerformedBy,
        PlaceID,
        Place,
        Address1,
        City,
        State,
        Zip,
        Country,
        ProfOfFaith,
        DOB
    )
SELECT DISTINCT
    LastName,
    FirstName,
    Middle AS MiddleName,
    Suffix,
    Gender,
    Father,
    Mother,
    'FirstCommunion' AS Description,
    Volume,
    Page,
    Entry,
    FirstCommDate AS SacDate,
    CASE
        WHEN FirstCommDate IS NOT NULL
        AND IFNULL(FirstCommApprox, 'F') <> 'Y' THEN 'Y'
        WHEN IFNULL(FirstCommApprox, 'F') = 'Y' THEN 'A'
        ELSE NULL
    END AS Status,
    PerformedBy,
    RegChurch AS PlaceID,
    Place,
    Address1,
    SUBSTR(
        CityState,
        1,
        INSTR(CityState, ',') - 1
    ) AS City,
    TRIM(
        SUBSTR(
            CityState,
            INSTR(CityState, ',') + 1,
            LENGTH(CityState) - INSTR(CityState, ',')
        )
    ) AS State,
    Zip,
    Country,
    IsProfofFaith AS ProfOfFaith,
    IFNULL(BirthDate, '2050-01-01') AS DOB
FROM FirstCommReg
    LEFT JOIN DatePlace ON FirstCommReg.RegChurch = DatePlace.DatePlaceRecNum
WHERE
    MemRecNum IS NULL
    AND LastName IS NOT NULL;

-- Confirmation INfo
INSERT
    OR IGNORE INTO SacramentExport_NonMem (
        LastName,
        FirstName,
        MiddleName,
        Suffix,
        Gender,
        Father,
        Mother,
        Description,
        Volume,
        Page,
        Entry,
        SacDate,
        Status,
        PerformedBy,
        PlaceID,
        Place,
        Address1,
        City,
        State,
        Zip,
        Country,
        Sponsor1,
        ProfOfFaith,
        ConfirmationName,
        GenNotes,
        DOB
    )
SELECT
    LastName,
    FirstName,
    Middle AS MiddleName,
    Suffix,
    Gender,
    Father,
    Mother,
    'Confirmation' AS Description,
    Volume,
    Page,
    Entry,
    ConfDate AS SacDate,
    CASE
        WHEN ConfDate IS NOT NULL
        AND IFNULL(ConfApprox, 'F') <> 'Y' THEN 'Y'
        WHEN IFNULL(ConfApprox, 'F') = 'Y' THEN 'A'
        ELSE NULL
    END AS Status,
    PerformedBy,
    RegChurch AS PlaceID,
    Place,
    Address1,
    SUBSTR(
        CityState,
        1,
        INSTR(CityState, ',') - 1
    ) AS City,
    TRIM(
        SUBSTR(
            CityState,
            INSTR(CityState, ',') + 1,
            LENGTH(CityState) - INSTR(CityState, ',')
        )
    ) AS State,
    Zip,
    Country,
    Sponsor AS Sponsor1,
    IsProfofFaith AS ProfOfFaith,
    ConfName AS ConfirmationName,
    Notes AS GenNotes,
    IFNULL(BirthDate, '2050-01-01') AS DOB
FROM ConfReg
    LEFT JOIN DatePlace ON ConfReg.RegChurch = DatePlace.DatePlaceRecNum
WHERE
    MemRecNum IS NULL
    AND LastName IS NOT NULL;

-- Marriage Info
INSERT
    OR IGNORE INTO SacramentExport_NonMem (
        LastName,
        FirstName,
        MiddleName,
        Suffix,
        Gender,
        Father,
        Mother,
        Description,
        Volume,
        Page,
        Entry,
        SacDate,
        Status,
        PlaceID,
        Place,
        Address1,
        City,
        State,
        Zip,
        Country,
        Sponsor1,
        Sponsor2,
        Proxy1,
        Proxy2,
        MarriageSpouseName,
        GenNotes,
        DOB
    )
SELECT DISTINCT
    LastName,
    FirstName,
    Middle AS MiddleName,
    Suffix,
    Gender,
    Father,
    Mother,
    'Marriage' AS Description,
    Volume,
    Page,
    Entry,
    MarDate AS SacDate,
    CASE
        WHEN MarDate IS NOT NULL
        AND IFNULL(MarApprox, 'F') <> 'Y' THEN 'Y'
        WHEN IFNULL(MarApprox, 'F') = 'Y' THEN 'A'
        ELSE NULL
    END AS Status,
    RegChurch AS PlaceID,
    Place,
    Address1,
    SUBSTR(
        CityState,
        1,
        INSTR(CityState, ',') - 1
    ) AS City,
    TRIM(
        SUBSTR(
            CityState,
            INSTR(CityState, ',') + 1,
            LENGTH(CityState) - INSTR(CityState, ',')
        )
    ) AS State,
    Zip,
    Country,
    Witness1 AS Sponsor1,
    Witness2 AS Sponsor2,
    Proxy1,
    Proxy2,
    SpouseName AS MarriageSpouseName,
    GenRemarks AS GenNotes,
    IFNULL(BirthDate, '2050-01-01') AS DOB
FROM MarReg
    LEFT JOIN DatePlace ON MarReg.RegChurch = DatePlace.DatePlaceRecNum
WHERE
    MemRecNum IS NULL
    AND LastName IS NOT NULL
order by LastName;

-- Death info
INSERT
    OR IGNORE INTO SacramentExport_NonMem (
        LastName,
        FirstName,
        MiddleName,
        Gender,
        DOB,
        Father,
        Mother,
        Description,
        Volume,
        Page,
        Entry,
        SacDate,
        Status,
        PlaceID,
        Place,
        Address1,
        City,
        State,
        Zip,
        Country,
        DeceasedPlaceofBurial,
        PerformedBy,
        GenNotes,
        MaidenName
    )
SELECT DISTINCT
    LastName,
    FirstName,
    MiddleName,
    Gender,
    IFNULL(BirthDate, '2050-01-01') AS DOB,
    Father,
    Mother,
    'Deceased' AS Description,
    Volume,
    Page,
    Entry,
    DateOfDeath AS SacDate,
    CASE
        WHEN DateOfDeath IS NOT NULL
        AND IFNULL(DeathApprox, 'F') <> 'Y' THEN 'Y'
        WHEN IFNULL(DeathApprox, 'F') = 'Y' THEN 'A'
        ELSE NULL
    END AS Status,
    RegChurch AS PlaceID,
    Place,
    Address1,
    SUBSTR(
        CityState,
        1,
        INSTR(CityState, ',') - 1
    ) AS City,
    TRIM(
        SUBSTR(
            CityState,
            INSTR(CityState, ',') + 1,
            LENGTH(CityState) - INSTR(CityState, ',')
        )
    ) AS State,
    Zip,
    Country,
    PlaceOfBurial AS DeceasedPlaceofBurial,
    PerformedBy,
    GenRemarks AS GenNotes,
    Maiden AS MaidenName
FROM DeathReg
    LEFT JOIN DatePlace ON DeathReg.RegChurch = DatePlace.DatePlaceRecNum
WHERE
    MemRecNum IS NULL
    AND LastName IS NOT NULL;

INSERT
    OR IGNORE INTO SacramentExport_NonMem (
        LastName,
        FirstName,
        MiddleName,
        Suffix,
        DOB,
        Gender,
        Father,
        Mother,
        BirthPlace,
        Description,
        SacDate,
        Status,
        PerformedBy,
        PlaceID,
        Place,
        Address1,
        City,
        State,
        Zip,
        Country,
        MaidenName,
        ProfOfFaith
    )
SELECT DISTINCT
    LastName,
    FirstName,
    MiddleName,
    Suffix,
    COALESCE(BirthDate, '2050-01-01') AS DOB,
    Gender,
    Father,
    Mother,
    BirthPlace,
    'FirstCommunion' AS Description,
    FirstCommDate AS SacDate,
    CASE
        WHEN FirstCommDate IS NOT NULL
        AND (
            FirstCommApprox IS NULL
            OR FirstCommApprox <> 'Y'
        ) THEN 'Y'
        WHEN FirstCommApprox = 'Y' THEN 'A'
        ELSE NULL
    END AS Status,
    FirstCommPerfBy AS PerformedBy,
    DatePlace.DatePlaceRecNum AS PlaceID,
    DatePlace.Place,
    DatePlace.Address1,
    SUBSTR(
        DatePlace.CityState,
        1,
        INSTR(DatePlace.CityState, ',') - 1
    ) AS City,
    TRIM(
        SUBSTR(
            DatePlace.CityState,
            INSTR(DatePlace.CityState, ',') + 1,
            LENGTH(DatePlace.CityState) - INSTR(DatePlace.CityState, ',')
        )
    ) AS State,
    DatePlace.Zip,
    DatePlace.Country,
    Maiden AS MaidenName,
    IsProfofFaith AS ProfOfFaith
FROM BapReg
    LEFT JOIN (
        SELECT
            RegRecNum, RegName, SacramentName, PlaceID
        FROM ttblDatePlaces_Reg
        WHERE
            RegName = 'BapReg'
            and SacramentName = 'FirstCommunion'
    ) s ON BapReg.RegRecNum = s.RegRecNum
    LEFT JOIN DatePlace ON s.PlaceID = DatePlace.DatePlaceRecNum
WHERE
    LastName IS NOT NULL
    AND MemRecNum IS NULL
    AND FirstCommDate IS NOT NULL;

INSERT
    OR IGNORE INTO SacramentExport_NonMem (
        LastName,
        FirstName,
        MiddleName,
        Suffix,
        DOB,
        Gender,
        Father,
        Mother,
        BirthPlace,
        Description,
        SacDate,
        Status,
        PerformedBy,
        PlaceID,
        Place,
        Address1,
        City,
        State,
        Zip,
        Country,
        MaidenName,
        ProfOfFaith
    )
SELECT DISTINCT
    b.LastName,
    b.FirstName,
    b.MiddleName,
    b.Suffix,
    COALESCE(b.BirthDate, '2050-01-01') AS DOB,
    b.Gender,
    b.Father,
    b.Mother,
    b.BirthPlace,
    'Confirmation' AS Description,
    b.ConfDate AS SacDate,
    CASE
        WHEN b.ConfDate IS NOT NULL
        AND IFNULL(b.ConfApprox, 'F') <> 'Y' THEN 'Y'
        WHEN IFNULL(b.ConfApprox, 'F') = 'Y' THEN 'A'
        ELSE NULL
    END AS Status,
    b.ConfPerfBy AS PerformedBy,
    p.DatePlaceRecNum AS PlaceID,
    p.Place,
    p.Address1,
    SUBSTR(
        p.CityState,
        1,
        INSTR(p.CityState, ',') - 1
    ) AS City,
    TRIM(
        SUBSTR(
            p.CityState,
            INSTR(p.CityState, ',') + 1,
            LENGTH(p.CityState) - INSTR(p.CityState, ',')
        )
    ) AS State,
    p.Zip,
    p.Country,
    b.Maiden AS MaidenName,
    b.IsProfofFaith AS ProfOfFaith
FROM BapReg b
    LEFT JOIN (
        SELECT
            RegRecNum, RegName, SacramentName, PlaceID
        FROM ttblDatePlaces_Reg
        WHERE
            RegName = 'BapReg'
            and SacramentName = 'Confirmation'
    ) s ON b.RegRecNum = s.RegRecNum
    LEFT JOIN DatePlace p ON s.PlaceID = p.DatePlaceRecNum
WHERE
    b.LastName IS NOT NULL
    AND b.MemRecNum IS NULL
    AND b.ConfDate IS NOT NULL;

INSERT
    OR IGNORE INTO SacramentExport_NonMem (
        LastName,
        FirstName,
        MiddleName,
        Suffix,
        DOB,
        Gender,
        Father,
        Mother,
        BirthPlace,
        Description,
        SacDate,
        Status,
        PerformedBy,
        PlaceID,
        Place,
        Address1,
        City,
        State,
        Zip,
        Country,
        MaidenName,
        ProfOfFaith
    )
SELECT DISTINCT
    LastName,
    FirstName,
    MiddleName,
    Suffix,
    COALESCE(BirthDate, '2050-01-01') AS DOB,
    Gender,
    Father,
    Mother,
    BirthPlace,
    'Marriage' AS Description,
    MarDate AS SacDate,
    CASE
        WHEN MarDate IS NOT NULL
        AND COALESCE(MarApprox, 'F') <> 'Y' THEN 'Y'
        WHEN COALESCE(MarApprox, 'F') = 'Y' THEN 'A'
        ELSE NULL
    END AS Status,
    MarPerfBy AS PerformedBy,
    DatePlace.DatePlaceRecNum AS PlaceID,
    DatePlace.Place,
    DatePlace.Address1,
    SUBSTR(
        DatePlace.CityState,
        1,
        INSTR(DatePlace.CityState, ',') - 1
    ) AS City,
    TRIM(
        SUBSTR(
            DatePlace.CityState,
            INSTR(DatePlace.CityState, ',') + 1,
            LENGTH(DatePlace.CityState) - INSTR(DatePlace.CityState, ',')
        )
    ) AS State,
    DatePlace.Zip,
    DatePlace.Country,
    Maiden AS MaidenName,
    IsProfofFaith AS ProfOfFaith
FROM BapReg
    LEFT JOIN (
        SELECT
            RegRecNum, RegName, SacramentName, PlaceID
        FROM ttblDatePlaces_Reg
        WHERE
            RegName = 'BapReg'
            and SacramentName = 'Marriage'
    ) s ON BapReg.RegRecNum = s.RegRecNum
    LEFT JOIN DatePlace ON s.PlaceID = DatePlace.DatePlaceRecNum
WHERE
    LastName IS NOT NULL
    AND MemRecNum IS NULL
    AND MarDate IS NOT NULL;

INSERT
    OR IGNORE INTO SacramentExport_NonMem (
        LastName,
        FirstName,
        MiddleName,
        Suffix,
        DOB,
        Gender,
        Father,
        Mother,
        Description,
        SacDate,
        Status,
        PlaceID,
        Place,
        Address1,
        City,
        State,
        Zip,
        Country,
        MaidenName,
        ProfOfFaith
    )
SELECT DISTINCT
    LastName,
    FirstName,
    Middle AS MiddleName,
    Suffix,
    COALESCE(BirthDate, '2050-01-01') AS DOB,
    Gender,
    Father,
    Mother,
    'Baptism' AS Description,
    BapDate AS SacDate,
    CASE
        WHEN BapDate IS NOT NULL
        AND COALESCE(BapApprox, 'F') <> 'Y' THEN 'Y'
        WHEN COALESCE(BapApprox, 'F') = 'Y' THEN 'A'
        ELSE NULL
    END AS Status,
    DatePlace.DatePlaceRecNum AS PlaceID,
    DatePlace.Place,
    DatePlace.Address1,
    SUBSTR(
        DatePlace.CityState,
        1,
        INSTR(DatePlace.CityState, ',') - 1
    ) AS City,
    TRIM(
        SUBSTR(
            DatePlace.CityState,
            INSTR(DatePlace.CityState, ',') + 1,
            LENGTH(DatePlace.CityState) - INSTR(DatePlace.CityState, ',')
        )
    ) AS State,
    DatePlace.Zip,
    DatePlace.Country,
    Maiden AS MaidenName,
    IsProfofFaith AS ProfOfFaith
FROM
    FirstCommReg
    LEFT JOIN (
        SELECT
            RegRecNum,
            RegName,
            SacramentName,
            PlaceID
        FROM ttblDatePlaces_Reg
        WHERE
            RegName = 'FirstCommReg'
            and SacramentName = 'Baptism'
    ) s ON FirstCommReg.RegRecNum = s.RegRecNum
    LEFT JOIN DatePlace ON s.PlaceID = DatePlace.DatePlaceRecNum
WHERE
    LastName IS NOT NULL
    AND MemRecNum IS NULL
    AND BapDate IS NOT NULL;

INSERT
    OR IGNORE INTO SacramentExport_NonMem (
        LastName,
        FirstName,
        MiddleName,
        Suffix,
        DOB,
        Gender,
        Father,
        Mother,
        Description,
        SacDate,
        Status,
        PlaceID,
        Place,
        Address1,
        City,
        State,
        Zip,
        Country,
        MaidenName,
        ProfOfFaith
    )
SELECT DISTINCT
    LastName,
    FirstName,
    Middle AS MiddleName,
    Suffix,
    COALESCE(BirthDate, '2050-01-01') AS DOB,
    Gender,
    Father,
    Mother,
    'Baptism' AS Description,
    BapDate AS SacDate,
    CASE
        WHEN BapDate IS NOT NULL
        AND COALESCE(BapApprox, 'F') <> 'Y' THEN 'Y'
        WHEN COALESCE(BapApprox, 'F') = 'Y' THEN 'A'
        ELSE NULL
    END AS Status,
    DatePlace.DatePlaceRecNum AS PlaceID,
    DatePlace.Place,
    DatePlace.Address1,
    SUBSTR(
        DatePlace.CityState,
        1,
        INSTR(DatePlace.CityState, ',') - 1
    ) AS City,
    TRIM(
        SUBSTR(
            DatePlace.CityState,
            INSTR(DatePlace.CityState, ',') + 1,
            LENGTH(DatePlace.CityState) - INSTR(DatePlace.CityState, ',')
        )
    ) AS State,
    DatePlace.Zip,
    DatePlace.Country,
    Maiden AS MaidenName,
    IsProfofFaith AS ProfOfFaith
FROM ConfReg
    LEFT JOIN (
        SELECT
            RegRecNum, RegName, SacramentName, PlaceID
        FROM ttblDatePlaces_Reg
        WHERE
            RegName = 'ConfReg'
            and SacramentName = 'Baptism'
    ) s ON ConfReg.RegRecNum = s.RegRecNum
    LEFT JOIN DatePlace ON s.PlaceID = DatePlace.DatePlaceRecNum
WHERE
    LastName IS NOT NULL
    AND MemRecNum IS NULL
    AND BapDate IS NOT NULL;

INSERT
    OR IGNORE INTO SacramentExport_NonMem (
        LastName,
        FirstName,
        MiddleName,
        Suffix,
        DOB,
        Gender,
        Father,
        Mother,
        Description,
        SacDate,
        Status,
        PlaceID,
        Place,
        Address1,
        City,
        State,
        Zip,
        Country,
        ProfOfFaith
    )
SELECT DISTINCT
    LastName,
    FirstName,
    Middle AS MiddleName,
    Suffix,
    COALESCE(BirthDate, '2050-01-01') AS DOB,
    Gender,
    Father,
    Mother,
    'Baptism' AS Description,
    BapDate AS SacDate,
    CASE
        WHEN BapDate IS NOT NULL THEN 'Y'
        ELSE 'A'
    END AS Status,
    DatePlace.DatePlaceRecNum AS PlaceID,
    DatePlace.Place,
    DatePlace.Address1,
    SUBSTR(
        DatePlace.CityState,
        1,
        INSTR(DatePlace.CityState, ',') - 1
    ) AS City,
    TRIM(
        SUBSTR(
            DatePlace.CityState,
            INSTR(DatePlace.CityState, ',') + 1,
            LENGTH(DatePlace.CityState) - INSTR(DatePlace.CityState, ',')
        )
    ) AS State,
    DatePlace.Zip,
    DatePlace.Country,
    IsProfofFaith AS ProfOfFaith
FROM MarReg
    LEFT JOIN (
        SELECT
            RegRecNum, RegName, SacramentName, PlaceID
        FROM ttblDatePlaces_Reg
        WHERE
            RegName = 'MarReg'
            and SacramentName = 'Baptism'
    ) s ON MarReg.RegRecNum = s.RegRecNum
    LEFT JOIN DatePlace ON s.PlaceID = DatePlace.DatePlaceRecNum
WHERE
    LastName IS NOT NULL
    AND MemRecNum IS NULL
    AND BapDate IS NOT NULL;

with
    rank_id as (
        SELECT *, dense_rank() over (
                ORDER BY FirstName asc, LastName, DOB
            ) as dr, (
                SELECT MAX(CAST(MemRecNum AS INTEGER))
                from mem
            ) as maxid
        FROM SacramentExport_NonMem
    )
update SacramentExport_NonMem
set
    NonMemberID = (
        SELECT dr + maxid
        FROM rank_id
        WHERE
            COALESCE(
                SacramentExport_NonMem.FirstName,
                ''
            ) = COALESCE(rank_id.FirstName, '')
            AND COALESCE(
                SacramentExport_NonMem.LastName,
                ''
            ) = COALESCE(rank_id.LastName, '')
            AND COALESCE(
                SacramentExport_NonMem.DOB,
                ''
            ) = COALESCE(rank_id.DOB, '')
    );

-- Sacraments_NonMem
WITH
    baptism AS (
        SELECT
            NonMemberID,
            BirthPlace,
            Father,
            case
                when INSTR(Mother, '(') > 0 then TRIM(
                    SUBSTR(
                        Mother,
                        1,
                        INSTR(Mother, '(') - 1
                    )
                )
                else Mother
            end as Mother,
            case
                when INSTR(Mother, '(') > 0 THEN TRIM(
                    SUBSTR(
                        Mother,
                        INSTR(Mother, '(') + 1,
                        LENGTH(Mother) - INSTR(Mother, '(') - 1
                    )
                )
                else null
            end AS MothersMaidenName,
            Status,
            BaptismName,
            SacDate,
            Address1,
            Place,
            City,
            State,
            Zip,
            Country,
            PerformedBy,
            GenNotes
        FROM SacramentExport_NonMem
        WHERE
            Description = 'Baptism'
    ),
    FirstComm AS (
        SELECT
            NonMemberID,
            Description,
            SacDate,
            Place,
            Status,
            Address1,
            City,
            State,
            Zip,
            Country,
            PerformedBy,
            GenNotes
        FROM SacramentExport_NonMem
        WHERE
            Description = 'FirstCommunion'
    ),
    Conf AS (
        SELECT
            NonMemberID,
            Description,
            SacDate,
            Status,
            Place,
            ConfirmationName,
            Address1,
            City,
            State,
            Zip,
            Country,
            PerformedBy,
            GenNotes
        FROM SacramentExport_NonMem
        WHERE
            Description = 'Confirmation'
    ),
    Mar as (
        SELECT
            NonMemberID,
            Description,
            SacDate,
            Status,
            Place,
            MarriageSpouseName,
            Address1,
            City,
            State,
            Zip,
            Country,
            PerformedBy,
            GenNotes
        FROM SacramentExport_NonMem
        WHERE
            Description = 'Marriage'
    ),
    Death as (
        SELECT
            NonMemberID,
            Description,
            SacDate,
            Status,
            Place,
            Address1,
            City,
            State,
            Zip,
            Country,
            PerformedBy,
            GenNotes,
            DeceasedPlaceofBurial,
            DeathCityState
        FROM SacramentExport_NonMem
        WHERE
            Description = 'Deceased'
    )
INSERT INTO
    Sacraments_NonMem (
        NonMemberID,
        BirthPlace,
        FathersName,
        MothersName,
        MothersMaidenName,
        BaptismName,
        BaptismDate,
        BaptismStatus,
        BaptismPlace,
        BaptismStreetAddress,
        BaptismCity,
        BaptismState,
        BaptismZip,
        BaptismCountry,
        BaptismCelebrant,
        BaptismNotes,
        FirstCommunionDate,
        FirstCommunionStatus,
        FirstCommunionPlace,
        FirstCommunionStreetAddress,
        FirstCommunionCity,
        FirstCommunionState,
        FirstCommunionZip,
        FirstCommunionCountry,
        FirstCommunionCelebrant,
        FirstCommunionNotes,
        ConfirmationDate,
        ConfirmationName,
        ConfirmationStatus,
        ConfirmationPlace,
        ConfirmationStreetAddress,
        ConfirmationCity,
        ConfirmationState,
        ConfirmationZip,
        ConfirmationCountry,
        ConfirmationCelebrant,
        ConfirmationNotes,
        MarriageDate,
        MarriageSpouseName,
        MarriageStatus,
        MarriagePlace,
        MarriageStreetAddress,
        MarriageCity,
        MarriageState,
        MarriageZip,
        MarriageCountry,
        MarriageCelebrant,
        MarriageNotes,
        DeceasedDate,
        DeceasedStatus,
        DeceasedPlace,
        DeceasedStreetAddress,
        DeceasedCity,
        DeceasedState,
        DeceasedZip,
        DeceasedCountry,
        DeceasedCelebrant,
        DeceasedNotes,
        DeceasedPlaceofBurial,
        DeathCityState
    )
SELECT DISTINCT
    s.NonMemberID,
    b.BirthPlace,
    b.Father,
    b.Mother,
    b.MothersMaidenName,
    b.BaptismName,
    b.SacDate,
    case
        when trim(b.status) = 'Y' THen 'YES'
        ELSE NULL
    END AS status,
    b.Place,
    b.Address1,
    b.City,
    b.State,
    b.Zip,
    b.Country,
    b.PerformedBy,
    b.GenNotes,
    f.SacDate,
    case
        when trim(f.status) = 'Y' THen 'YES'
        ELSE NULL
    END AS status,
    f.Place,
    f.Address1,
    f.City,
    f.State,
    f.Zip,
    f.Country,
    f.PerformedBy,
    f.GenNotes,
    c.SacDate,
    c.ConfirmationName,
    case
        when trim(c.status) = 'Y' THen 'YES'
        ELSE NULL
    END AS status,
    c.Place,
    c.Address1,
    c.City,
    c.State,
    c.Zip,
    c.Country,
    c.PerformedBy,
    c.GenNotes,
    m.SacDate,
    m.MarriageSpouseName,
    case
        when trim(m.status) = 'Y' THen 'YES'
        ELSE NULL
    END AS status,
    m.Place,
    m.Address1,
    m.City,
    m.State,
    m.Zip,
    m.Country,
    m.PerformedBy,
    m.GenNotes,
    d.SacDate,
    case
        when trim(d.status) = 'Y' THen 'YES'
        ELSE NULL
    END AS status,
    d.Place,
    d.Address1,
    d.City,
    d.State,
    d.Zip,
    d.Country,
    d.PerformedBy,
    d.GenNotes,
    d.DeceasedPlaceofBurial,
    d.DeathCityState
FROM
    SacramentExport_NonMem AS s
    left JOIN baptism AS b ON s.NonMemberID = b.NonMemberID
    left JOIN FirstComm AS f ON s.NonMemberID = f.NonMemberID
    left JOIN Conf AS c ON s.NonMemberID = c.NonMemberID
    left JOIN Mar AS m ON s.NonMemberID = m.NonMemberID
    LEFT JOIN Death as d on s.NonMemberID = d.NonMemberID
ORDER BY s.NonMemberID;

-- SacramentSponsor_NonMem
INSERT
    OR IGNORE INTO SacramentSponsors_NonMem (
        NonMemberID,
        Sacrament,
        SponsorName,
        SponsorType,
        Proxy
    )
SELECT
    NonMemberID,
    Description,
    Sponsor1,
    CASE
        WHEN ChristianWitness = 'TRUE' THEN 'Christian Witness'
        ELSE ''
    END AS SponsorType,
    Proxy1
FROM SacramentExport_NonMem
WHERE (
        Sponsor1 IS NOT NULL
        OR Proxy1 IS NOT NULL
    )
    AND NonMemberID is not null;

INSERT
    OR IGNORE INTO SacramentSponsors_NonMem (
        NonMemberID,
        Sacrament,
        SponsorName,
        SponsorType,
        Proxy
    )
SELECT
    NonMemberID,
    Description,
    Sponsor2,
    CASE
        WHEN ChristianWitness = 'TRUE' THEN 'Christian Witness'
        ELSE ''
    END AS SponsorType,
    Proxy2
FROM SacramentExport_NonMem
WHERE (
        Sponsor2 IS NOT NULL
        OR Proxy2 IS NOT NULL
    )
    AND NonMemberID is not null;

-- SacramentBooks_NonMem
INSERT INTO
    SacramentBooks_NonMem (
        NonMemberID,
        Sacrament,
        Date,
        Volume,
        Page,
        Entry
    )
SELECT
    NonMemberID,
    Description AS Sacrament,
    SacDate AS Date,
    Volume,
    Page,
    Entry
FROM SacramentExport_NonMem
WHERE
    SacDate IS NOT NULL
    AND (
        Volume IS NOT NULL
        AND Volume <> '0'
    )
    AND (
        Page IS NOT NULL
        AND Page <> '0'
    )
    AND (
        Entry IS NOT NULL
        AND Entry <> '0'
    )
GROUP by
    NonMemberID,
    Sacrament,
    Date;

INSERT INTO
    NonMembers (
        NonMemberID,
        FirstName,
        LastName,
        MiddleName,
        Suffix,
        MaidenName,
        Gender,
        DOB,
        DateDeceased,
        Deceased
    )
SELECT DISTINCT
    NonMemberID,
    FirstName,
    LastName,
    MiddleName,
    Suffix,
    MaidenName,
    Gender,
    DOB,
    DeceasedDate,
    0 as Deceased
FROM SacramentExport_NonMem
GROUP BY
    NonMemberID;