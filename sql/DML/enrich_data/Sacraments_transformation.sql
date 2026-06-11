-- Insert Missing places
INSERT INTO
    ttblDatePlaces_Reg (
        RegRecNum,
        RegName,
        SacramentName,
        Place,
        Address1,
        CityState,
        City,
        State,
        Zip,
        Country,
        MatchKey
    )
SELECT
    RegRecNum,
    'BapReg' AS RegName,
    'FirstCommunion' AS SacramentName,
    FirstCommPlace AS Place,
    FirstCommPlaceAddress AS Address1,
    FirstCommPlaceCityState AS CityState,
    SUBSTR(
        FirstCommPlaceCityState,
        1,
        INSTR(FirstCommPlaceCityState, ',') - 1
    ) AS City,
    TRIM(
        SUBSTR(
            FirstCommPlaceCityState,
            INSTR(FirstCommPlaceCityState, ',') + 1,
            LENGTH(FirstCommPlaceCityState) - INSTR(FirstCommPlaceCityState, ',')
        )
    ) AS State,
    FirstCommPlaceZip AS Zip,
    FirstCommPlaceCountry AS Country,
    (
        FirstCommPlace || FirstCommPlaceAddress || FirstCommPlaceCityState || FirstCommPlaceZip || FirstCommPlaceCountry
    ) AS MatchKey
FROM BapReg
WHERE
    FirstCommPlace IS NOT NULL;

INSERT INTO
    ttblDatePlaces_Reg (
        RegRecNum,
        RegName,
        SacramentName,
        Place,
        Address1,
        CityState,
        City,
        State,
        Zip,
        Country,
        MatchKey
    )
SELECT
    RegRecNum,
    'BapReg' AS RegName,
    'Confirmation' AS SacramentName,
    ConfPlace AS Place,
    ConfPlaceAddress AS Address1,
    ConfPlaceCityState AS CityState,
    SUBSTR(
        ConfPlaceCityState,
        1,
        INSTR(ConfPlaceCityState, ',') - 1
    ) AS City,
    TRIM(
        SUBSTR(
            ConfPlaceCityState,
            INSTR(ConfPlaceCityState, ',') + 1,
            LENGTH(ConfPlaceCityState) - INSTR(ConfPlaceCityState, ',')
        )
    ) AS State,
    ConfPlaceZip AS Zip,
    ConfPlaceCountry AS Country,
    (
        ConfPlace || ConfPlaceAddress || ConfPlaceCityState || ConfPlaceZip || ConfPlaceCountry
    ) AS MatchKey
FROM BapReg
WHERE
    ConfPlace IS NOT NULL;

-- Get BapReg Marriage Places
INSERT INTO
    ttblDatePlaces_Reg (
        RegRecNum,
        RegName,
        SacramentName,
        Place,
        Address1,
        CityState,
        City,
        State,
        Zip,
        Country,
        MatchKey
    )
SELECT
    RegRecNum,
    'BapReg' AS RegName,
    'Marriage' AS SacramentName,
    MarPlace AS Place,
    MarPlaceAddress AS Address1,
    MarPlaceCityState AS CityState,
    SUBSTR(
        MarPlaceCityState,
        1,
        INSTR(MarPlaceCityState, ',') - 1
    ) AS City,
    TRIM(
        SUBSTR(
            MarPlaceCityState,
            INSTR(MarPlaceCityState, ',') + 1,
            LENGTH(MarPlaceCityState) - INSTR(MarPlaceCityState, ',')
        )
    ) AS State,
    MarPlaceZip AS Zip,
    MarPlaceCountry AS Country,
    (
        MarPlace || MarPlaceAddress || MarPlaceCityState || MarPlaceZip || MarPlaceCountry
    ) AS MatchKey
FROM BapReg
WHERE
    MarPlace IS NOT NULL;

-- Get FirstCommReg Baptism Places
INSERT INTO
    ttblDatePlaces_Reg (
        RegRecNum,
        RegName,
        SacramentName,
        Place,
        Address1,
        CityState,
        City,
        State,
        Zip,
        Country,
        MatchKey
    )
SELECT
    RegRecNum,
    'FirstCommReg' AS RegName,
    'Baptism' AS SacramentName,
    BapPlace AS Place,
    BapPlaceAddress AS Address1,
    BapPlaceCityState AS CityState,
    SUBSTR(
        BapPlaceCityState,
        1,
        INSTR(BapPlaceCityState, ',') - 1
    ) AS City,
    TRIM(
        SUBSTR(
            BapPlaceCityState,
            INSTR(BapPlaceCityState, ',') + 1,
            LENGTH(BapPlaceCityState) - INSTR(BapPlaceCityState, ',')
        )
    ) AS State,
    BapPlaceZip AS Zip,
    BapPlaceCountry AS Country,
    (
        BapPlace || BapPlaceAddress || BapPlaceCityState || BapPlaceZip || BapPlaceCountry
    ) AS MatchKey
FROM FirstCommReg
WHERE
    BapPlace IS NOT NULL;

-- Get ConfReg Baptism Places
INSERT INTO
    ttblDatePlaces_Reg (
        RegRecNum,
        RegName,
        SacramentName,
        Place,
        Address1,
        CityState,
        City,
        State,
        Zip,
        Country,
        MatchKey
    )
SELECT
    RegRecNum,
    'ConfReg' AS RegName,
    'Baptism' AS SacramentName,
    BapPlace AS Place,
    BapPlaceAddress AS Address1,
    BapPlaceCityState AS CityState,
    SUBSTR(
        BapPlaceCityState,
        1,
        INSTR(BapPlaceCityState, ',') - 1
    ) AS City,
    TRIM(
        SUBSTR(
            BapPlaceCityState,
            INSTR(BapPlaceCityState, ',') + 1,
            LENGTH(BapPlaceCityState) - INSTR(BapPlaceCityState, ',')
        )
    ) AS State,
    BapPlaceZip AS Zip,
    BapPlaceCountry AS Country,
    (
        BapPlace || BapPlaceAddress || BapPlaceCityState || BapPlaceZip || BapPlaceCountry
    ) AS MatchKey
FROM ConfReg
WHERE
    BapPlace IS NOT NULL;

-- Get MarReg Baptism Places
INSERT INTO
    ttblDatePlaces_Reg (
        RegRecNum,
        RegName,
        SacramentName,
        Place,
        Address1,
        CityState,
        City,
        State,
        Zip,
        Country,
        MatchKey
    )
SELECT
    RegRecNum,
    'MarReg' AS RegName,
    'Baptism' AS SacramentName,
    BapPlace AS Place,
    BapPlaceAddress AS Address1,
    BapPlaceCityState AS CityState,
    SUBSTR(
        BapPlaceCityState,
        1,
        INSTR(BapPlaceCityState, ',') - 1
    ) AS City,
    TRIM(
        SUBSTR(
            BapPlaceCityState,
            INSTR(BapPlaceCityState, ',') + 1,
            LENGTH(BapPlaceCityState) - INSTR(BapPlaceCityState, ',')
        )
    ) AS State,
    BapPlaceZip AS Zip,
    BapPlaceCountry AS Country,
    (
        BapPlace || BapPlaceAddress || BapPlaceCityState || BapPlaceZip || BapPlaceCountry
    ) AS MatchKey
FROM MarReg
WHERE
    BapPlace IS NOT NULL;

-- Get DeathReg Burial Places
INSERT INTO
    ttblDatePlaces_Reg (
        RegRecNum,
        RegName,
        SacramentName,
        Place,
        Address1,
        CityState,
        City,
        State,
        Zip,
        Country,
        MatchKey,
        BurialPlace
    )
SELECT
    RegRecNum,
    'DeathReg' AS RegName,
    'Deceased' AS SacramentName,
    PlaceOfBurial AS Place,
    BurialPlaceAddress AS Address1,
    BurialPlaceCityState AS CityState,
    SUBSTR(
        BurialPlaceCityState,
        1,
        INSTR(BurialPlaceCityState, ',') - 1
    ) AS City,
    TRIM(
        SUBSTR(
            BurialPlaceCityState,
            INSTR(BurialPlaceCityState, ',') + 1,
            LENGTH(BurialPlaceCityState) - INSTR(BurialPlaceCityState, ',')
        )
    ) AS State,
    BurialPlaceZip AS Zip,
    BurialPlaceCountry AS Country,
    (
        PlaceOfBurial || BurialPlaceAddress || BurialPlaceCityState || BurialPlaceZip || BurialPlaceCountry
    ) AS MatchKey,
    1 AS BurialPlace
FROM DeathReg
WHERE
    PlaceOfBurial IS NOT NULL;

UPDATE ttblDatePlaces_Reg
SET
    PlaceID = (
        SELECT DatePlaceRecNum
        from DatePlace
        where
            DatePlace.Place = ttblDatePlaces_Reg.Place
    );

WITH
    null_placeID as (
        SELECT *, (
                SELECT MAX(
                        CAST(DatePlaceRecNum AS INTEGER)
                    )
                FROM DatePlace
            ) as maxID, row_number() OVER () as rn
        FROM ttblDatePlaces_Reg
        WHERE
            PlaceID IS NULL
    )
UPDATE ttblDatePlaces_Reg
SET
    PlaceID = (
        SELECT (maxID + rn) as PlaceID
        from null_placeID
        where
            null_placeID.Place = ttblDatePlaces_Reg.Place
    )
WHERE
    PlaceID IS NULL;

INSERT INTO
    DatePlace (DatePlaceRecNum, Place)
SELECT PlaceID, Place
from ttblDatePlaces_Reg
WHERE
    NOT EXISTS (
        SELECT 1
        From DatePlace
        WHERE
            DatePlace.DatePlaceRecNum = ttblDatePlaces_Reg.PlaceID
    );

CREATE TABLE MakeOCIABap AS
SELECT DISTINCT
    MemDates.Date,
    MemDates.Status,
    DatePlace.Place,
    DatePlace.Address1,
    DatePlace.CityState,
    DatePlace.Zip,
    DatePlace.Country,
    MemDates.MemRecNum,
    DateType.Description,
    BapReg.IsProfofFaith
FROM
    MemDates
    LEFT JOIN DatePlace ON MemDates.DatePlaceRecNum = DatePlace.DatePlaceRecNum
    LEFT JOIN DateType ON MemDates.DescRec = DateType.DescRec
    LEFT JOIN BapReg ON MemDates.MemDateRecNum = BapReg.MemDateRecNum
WHERE
    MemDates.Date IS NOT NULL
    AND BapReg.IsProfofFaith = -1;

-- MakeOCIABap

-- MakeOCIAConf
CREATE TABLE MakeOCIAConf AS
SELECT DISTINCT
    MemDates.Date,
    MemDates.Status,
    DatePlace.Place,
    DatePlace.Address1,
    DatePlace.CityState,
    DatePlace.Zip,
    DatePlace.Country,
    MemDates.MemRecNum,
    DateType.Description,
    ConfReg.IsProfofFaith
FROM
    MemDates
    LEFT JOIN DatePlace ON MemDates.DatePlaceRecNum = DatePlace.DatePlaceRecNum
    LEFT JOIN DateType ON MemDates.DescRec = DateType.DescRec
    LEFT JOIN ConfReg ON MemDates.MemDateRecNum = ConfReg.MemDateRecNum
WHERE
    MemDates.Date IS NOT NULL
    AND ConfReg.IsProfofFaith = -1;

-- MakeOCIAFirstComm
CREATE TABLE MakeOCIAFirstComm AS
SELECT DISTINCT
    MemDates.Date,
    MemDates.Status,
    DatePlace.Place,
    DatePlace.Address1,
    DatePlace.CityState,
    DatePlace.Zip,
    DatePlace.Country,
    MemDates.MemRecNum,
    DateType.Description,
    FirstCommReg.IsProfofFaith
FROM
    MemDates
    LEFT JOIN DatePlace ON MemDates.DatePlaceRecNum = DatePlace.DatePlaceRecNum
    LEFT JOIN DateType ON MemDates.DescRec = DateType.DescRec
    LEFT JOIN FirstCommReg ON MemDates.MemDateRecNum = FirstCommReg.MemDateRecNum
WHERE
    MemDates.Date IS NOT NULL
    AND FirstCommReg.IsProfofFaith = -1;

-- MakeOCIAMar
CREATE TABLE MakeOCIAMar AS
SELECT DISTINCT
    MemDates.Date,
    MemDates.Status,
    DatePlace.Place,
    DatePlace.Address1,
    DatePlace.CityState,
    DatePlace.Zip,
    DatePlace.Country,
    MemDates.MemRecNum,
    DateType.Description,
    MarReg.IsProfofFaith
FROM
    MemDates
    LEFT JOIN DatePlace ON MemDates.DatePlaceRecNum = DatePlace.DatePlaceRecNum
    LEFT JOIN DateType ON MemDates.DescRec = DateType.DescRec
    LEFT JOIN MarReg ON MemDates.MemDateRecNum = MarReg.MemDateRecNum
WHERE
    MemDates.Date IS NOT NULL
    AND MarReg.IsProfofFaith = -1;

CREATE TABLE MakeReconcilDates AS
SELECT DISTINCT
    DateType.Description,
    MemDates.MemRecNum,
    MemDates.Date
FROM MemDates
    LEFT JOIN DateType ON MemDates.DescRec = DateType.DescRec
WHERE
    DateType.Description = 'Reconcil'
    AND MemDates.Date IS NOT NULL;

-- MakeBaptisms/Rconcil
CREATE TABLE "MakeBaptisms/Rconcil" AS
SELECT DISTINCT
    MemDates.MemRecNum,
    Ask.BirthPlace,
    Ask.FatherName,
    Ask.MotherName,
    Ask.MothersMaiden,
    MemSac.ExtraInfo as BaptismalName,
    MemDates.Date,
    MemDates.Status,
    DatePlace.Place,
    DatePlace.Address1,
    DatePlace.CityState,
    DatePlace.Zip,
    DatePlace.Country,
    MemSac.PerformedBy,
    MemSac.GenNotes,
    MakeReconcilDates.Date AS ReconcilDate,
    DateType.Description
FROM
    MemDates
    LEFT JOIN MemSac ON MemSac.SacMemDateRec = MemDates.MemDateRecNum
    LEFT JOIN Ask ON Ask.AskMemNum = MemDates.MemRecNum
    LEFT JOIN DatePlace ON MemDates.DatePlaceRecNum = DatePlace.DatePlaceRecNum
    INNER JOIN DateType ON MemDates.DescRec = DateType.DescRec
    LEFT JOIN MakeReconcilDates ON MakeReconcilDates.MemRecNum = MemDates.MemRecNum
WHERE
    DateType.Description = 'Baptism';
-- Baptism data from FirstCommunion
INSERT INTO
    "MakeBaptisms/Rconcil" (
        MemRecNum,
        BirthPlace,
        FatherName,
        MotherName,
        MothersMaiden,
        Date,
        Status,
        Place,
        Address1,
        CityState,
        Zip,
        Country,
        PerformedBy
    )
SELECT DISTINCT
    MemRecNum,
    BapPLace,
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
    BapDate AS SacDate,
    CASE
        WHEN BapDate IS NOT NULL
        AND COALESCE(BapApprox, 'F') <> 'Y' THEN 'Y'
        WHEN COALESCE(BapApprox, 'F') = 'Y' THEN 'A'
        ELSE NULL
    END AS Status,
    DatePlace.Place,
    DatePlace.Address1,
    DatePlace.CityState,
    DatePlace.Zip,
    DatePlace.Country,
    PerformedBy
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
    AND MemRecNum IS NOT NULL
    AND BapDate IS NOT NULL;
-- MakeFirstComm
CREATE TABLE MakeFirstComm AS
SELECT DISTINCT
    MemDates.MemRecNum,
    DateType.Description,
    MemDates.Date,
    MemDates.Status,
    DatePlace.Place,
    DatePlace.Address1,
    DatePlace.CityState,
    DatePlace.Zip,
    DatePlace.Country,
    MemSac.PerformedBy,
    MemSac.GenNotes
FROM
    MemDates
    LEFT JOIN MemSac ON MemSac.SacMemDateRec = MemDates.MemDateRecNum
    LEFT JOIN Ask ON Ask.AskMemNum = MemDates.MemRecNum
    LEFT JOIN DatePlace ON MemDates.DatePlaceRecNum = DatePlace.DatePlaceRecNum
    INNER JOIN DateType ON MemDates.DescRec = DateType.DescRec
WHERE
    DateType.Description = 'FirstCommunion';

-- MakeConf
CREATE TABLE MakeConf AS
SELECT DISTINCT
    MemDates.MemRecNum,
    DateType.Description,
    MemDates.Date,
    MemDates.Status,
    DatePlace.Place,
    DatePlace.Address1,
    DatePlace.CityState,
    DatePlace.Zip,
    DatePlace.Country,
    MemSac.PerformedBy,
    MemSac.GenNotes,
    MemSac.ExtraInfo
FROM
    MemDates
    LEFT JOIN MemSac ON MemSac.SacMemDateRec = MemDates.MemDateRecNum
    LEFT JOIN Ask ON Ask.AskMemNum = MemDates.MemRecNum
    LEFT JOIN DatePlace ON MemDates.DatePlaceRecNum = DatePlace.DatePlaceRecNum
    INNER JOIN DateType ON MemDates.DescRec = DateType.DescRec
    LEFT JOIN ConfReg ON MemDates.MemDateRecNum = ConfReg.MemDateRecNum
WHERE
    DateType.Description = 'Confirmation';

-- MakeMar
CREATE TABLE MakeMar AS
SELECT DISTINCT
    MemDates.MemRecNum,
    DateType.Description,
    MemDates.Date,
    MemDates.Status,
    DatePlace.Place,
    DatePlace.Address1,
    DatePlace.CityState,
    DatePlace.Zip,
    DatePlace.Country,
    MemSac.PerformedBy,
    MemSac.GenNotes,
    MemSac.Extrainfo
FROM
    MemDates
    LEFT JOIN MemSac ON MemSac.SacMemDateRec = MemDates.MemDateRecNum
    LEFT JOIN Ask ON Ask.AskMemNum = MemDates.MemRecNum
    LEFT JOIN DatePlace ON MemDates.DatePlaceRecNum = DatePlace.DatePlaceRecNum
    INNER JOIN DateType ON MemDates.DescRec = DateType.DescRec
    LEFT JOIN MarReg ON MemDates.MemDateRecNum = MarReg.MemDateRecNum
WHERE
    DateType.Description = 'Marriage';

-- MakeDeath
CREATE TABLE MakeDeath AS
SELECT DISTINCT
    MemDates.MemRecNum,
    DateType.Description,
    MemDates.Date,
    MemDates.Status,
    DatePlace.Place,
    DatePlace.Address1,
    DatePlace.CityState,
    DatePlace.Zip,
    DatePlace.Country,
    MemSac.PerformedBy,
    MemSac.GenNotes,
    DeathReg.PlaceOfBurial,
    DeathReg.BurialPlaceCityState
FROM
    MemDates
    LEFT JOIN MemSac ON MemSac.SacMemDateRec = MemDates.MemDateRecNum
    LEFT JOIN Ask ON Ask.AskMemNum = MemDates.MemRecNum
    LEFT JOIN DatePlace ON MemDates.DatePlaceRecNum = DatePlace.DatePlaceRecNum
    INNER JOIN DateType ON MemDates.DescRec = DateType.DescRec
    LEFT JOIN DeathReg ON MemDates.MemDateRecNum = DeathReg.MemDateRecNum
WHERE
    DateType.Description = 'Deceased';

-- OCIAReg Inserts
INSERT INTO
    OCIAReg (
        MemRecNum,
        ProfDate,
        Place,
        "Add",
        City,
        Zip
    )
SELECT MakeOCIAConf.MemRecNum, MakeOCIAConf.Date, MakeOCIAConf.Place, MakeOCIAConf.Address1, MakeOCIAConf.CityState, MakeOCIAConf.Zip
FROM MakeOCIAConf;

INSERT INTO
    OCIAReg (
        MemRecNum,
        ProfDate,
        Place,
        "Add",
        City,
        Zip
    )
SELECT MakeOCIABap.MemRecNum, MakeOCIABap.Date, MakeOCIABap.Place, MakeOCIABap.Address1, MakeOCIABap.CityState, MakeOCIABap.Zip
FROM MakeOCIABap;

INSERT INTO
    OCIAReg (
        ProfDate,
        Place,
        City,
        "Add",
        Zip,
        MemRecNum
    )
SELECT MakeOCIAFirstComm.Date, MakeOCIAFirstComm.Place, MakeOCIAFirstComm.CityState, MakeOCIAFirstComm.Address1, MakeOCIAFirstComm.Zip, MakeOCIAFirstComm.MemRecNum
FROM MakeOCIAFirstComm;

INSERT INTO
    OCIAReg (
        MemRecNum,
        ProfDate,
        "Add",
        City,
        Zip,
        Place
    )
SELECT MakeOCIAMar.MemRecNum, MakeOCIAMar.Date, MakeOCIAMar.Address1, MakeOCIAMar.CityState, MakeOCIAMar.Zip, MakeOCIAMar.Place
FROM MakeOCIAMar;

INSERT INTO
    OCIAReg (MemRecNum, ProfDate)
SELECT MemSac.SacMemRec, MemSac.ProfDate
FROM MemSac
WHERE
    MemSac.ProfDate IS NOT NULL;