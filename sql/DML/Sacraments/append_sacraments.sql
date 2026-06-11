INSERT INTO
    SacramentBooks (
        PDSMemberID,
        Sacrament,
        Date,
        Volume,
        Page,
        Entry
    )
SELECT DISTINCT
    MemDates.MemRecNum,
    DateType.Description AS Sacrament,
    MemDates.Date,
    MemSac.Vol,
    MemSac.Page,
    MemSac.Entry
FROM MemSac
    LEFT JOIN (
        MemDates
        LEFT JOIN DateType ON MemDates.DescRec = DateType.DescRec
    ) ON MemSac.SacMemDateRec = MemDates.MemDateRecNum
WHERE
    DateType.Description IS NOT NULL
    AND MemDates.Date IS NOT NULL
    AND (
        MemSac.Vol IS NOT NULL
        OR MemSac.Page IS NOT NULL
        OR MemSac.Entry IS NOT NULL
    );

INSERT INTO
    Sacraments (
        PDSMemberID,
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
        ReconciliationDate,
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
        RCIADate,
        RCIAPlace,
        RCIAStreetAddress,
        RCIACity,
        RCIAState,
        RCIAZip,
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
    mem.MemRecNum,

-- Baptism
"MakeBaptisms/Rconcil".BirthPlace,
"MakeBaptisms/Rconcil".FatherName,
"MakeBaptisms/Rconcil".MotherName,
"MakeBaptisms/Rconcil".MothersMaiden,
"MakeBaptisms/Rconcil".BaptismalName,
CASE
    WHEN "MakeBaptisms/Rconcil".Status IN ('N', 'U', 'D', 'I') THEN NULL
    ELSE "MakeBaptisms/Rconcil".Date
END AS BaptismDate,
CASE
    WHEN "MakeBaptisms/Rconcil".Status IN ('Y', 'A') THEN 'YES'
    WHEN "MakeBaptisms/Rconcil".Status = 'O' THEN 'Annulled'
    WHEN "MakeBaptisms/Rconcil".Status = 'W' THEN 'Widowed'
    ELSE NULL
END AS BaptismStatus,
CASE
    WHEN "MakeBaptisms/Rconcil".Status IN ('N', 'U', 'D', 'I') THEN NULL
    ELSE "MakeBaptisms/Rconcil".Place
END AS BaptismPlace,
CASE
    WHEN "MakeBaptisms/Rconcil".Status IN ('N', 'U', 'D', 'I') THEN NULL
    ELSE "MakeBaptisms/Rconcil".Address1
END AS BaptismAddress1,
CASE
    WHEN "MakeBaptisms/Rconcil".Status IN ('N', 'U', 'D', 'I') THEN NULL
    ELSE CASE
        WHEN INSTR(
            "MakeBaptisms/Rconcil".CityState,
            ','
        ) > 0 THEN substr(
            "MakeBaptisms/Rconcil".CityState,
            1,
            instr(
                "MakeBaptisms/Rconcil".CityState,
                ','
            ) - 1
        )
        ELSE "MakeBaptisms/Rconcil".CityState
    END
END AS BaptismCity,
CASE
    WHEN "MakeBaptisms/Rconcil".Status IN ('N', 'U', 'D', 'I') THEN NULL
    ELSE CASE
        WHEN INSTR(
            "MakeBaptisms/Rconcil".CityState,
            ','
        ) > 0 THEN substr(
            "MakeBaptisms/Rconcil".CityState,
            instr(
                "MakeBaptisms/Rconcil".CityState,
                ','
            ) + 2,
            length(
                "MakeBaptisms/Rconcil".CityState
            ) - instr(
                "MakeBaptisms/Rconcil".CityState,
                ','
            )
        )
        ELSE NULL
    END
END AS BaptismState,
CASE
    WHEN "MakeBaptisms/Rconcil".Status IN ('N', 'U', 'D', 'I') THEN NULL
    ELSE "MakeBaptisms/Rconcil".Zip
END AS BaptismZip,
CASE
    WHEN "MakeBaptisms/Rconcil".Status IN ('N', 'U', 'D', 'I') THEN NULL
    ELSE "MakeBaptisms/Rconcil".Country
END AS BaptismCountry,
CASE
    WHEN "MakeBaptisms/Rconcil".Status IN ('N', 'U', 'D', 'I') THEN NULL
    ELSE "MakeBaptisms/Rconcil".PerformedBy
END AS BaptismPerformedBy,
CASE
    WHEN "MakeBaptisms/Rconcil".Status IN ('N', 'U', 'D', 'I') THEN NULL
    ELSE "MakeBaptisms/Rconcil".GenNotes
END AS BaptismGenNotes,
CASE
    WHEN "MakeBaptisms/Rconcil".Status IN ('N', 'U', 'D', 'I') THEN NULL
    ELSE MakeReconcilDates.Date
END AS ReconcilDate,

-- First Communion
CASE
    WHEN MakeFirstComm.Status IN ('N', 'U', 'D', 'I') THEN NULL
    ELSE MakeFirstComm.Date
END AS FirstCommDate,
CASE
    WHEN MakeFirstComm.Status IN ('Y', 'A') THEN 'YES'
    ELSE NULL
END AS FirstCommStatus,
CASE
    WHEN MakeFirstComm.Status IN ('N', 'U', 'D', 'I') THEN NULL
    ELSE MakeFirstComm.Place
END AS FirstCommPlace,
CASE
    WHEN MakeFirstComm.Status IN ('N', 'U', 'D', 'I') THEN NULL
    ELSE MakeFirstComm.Address1
END AS FirstCommAddress1,
CASE
    WHEN MakeFirstComm.Status IN ('N', 'U', 'D', 'I') THEN NULL
    ELSE CASE
        WHEN INSTR(MakeFirstComm.CityState, ',') > 0 THEN substr(
            MakeFirstComm.CityState,
            1,
            instr(MakeFirstComm.CityState, ',') - 1
        )
        ELSE MakeFirstComm.CityState
    END
END AS FirstCommCity,
CASE
    WHEN MakeFirstComm.Status IN ('N', 'U', 'D', 'I') THEN NULL
    ELSE CASE
        WHEN INSTR(MakeFirstComm.CityState, ',') > 0 THEN substr(
            MakeFirstComm.CityState,
            instr(MakeFirstComm.CityState, ',') + 2,
            length(MakeFirstComm.CityState) - instr(MakeFirstComm.CityState, ',')
        )
        ELSE NULL
    END
END AS FirstCommState,
CASE
    WHEN MakeFirstComm.Status IN ('N', 'U', 'D', 'I') THEN NULL
    ELSE MakeFirstComm.Zip
END AS FirstCommZip,
CASE
    WHEN MakeFirstComm.Status IN ('N', 'U', 'D', 'I') THEN NULL
    ELSE MakeFirstComm.Country
END AS FirstCommCountry,
CASE
    WHEN MakeFirstComm.Status IN ('N', 'U', 'D', 'I') THEN NULL
    ELSE MakeFirstComm.PerformedBy
END AS FirstCommPerformedBy,
CASE
    WHEN MakeFirstComm.Status IN ('N', 'U', 'D', 'I') THEN NULL
    ELSE MakeFirstComm.GenNotes
END AS FirstCommGenNotes,

-- Confirmation
CASE
    WHEN MakeConf.Status IN ('N', 'U', 'D', 'I') THEN NULL
    ELSE MakeConf.Date
END AS ConfDate,
MakeConf.ExtraInfo,
CASE
    WHEN MakeConf.Status IN ('Y', 'A') THEN 'YES'
    WHEN MakeConf.Status = 'O' THEN 'Annulled'
    WHEN MakeConf.Status = 'W' THEN 'Widowed'
    ELSE NULL
END AS ConfStatus,
CASE
    WHEN MakeConf.Status IN ('N', 'U', 'D', 'I') THEN NULL
    ELSE MakeConf.Place
END AS ConfPlace,
CASE
    WHEN MakeConf.Status IN ('N', 'U', 'D', 'I') THEN NULL
    ELSE MakeConf.Address1
END AS ConfAddress1,
CASE
    WHEN MakeConf.Status IN ('N', 'U', 'D', 'I') THEN NULL
    ELSE CASE
        WHEN INSTR(MakeConf.CityState, ',') > 0 THEN substr(
            MakeConf.CityState,
            1,
            instr(MakeConf.CityState, ',') - 1
        )
        ELSE MakeConf.CityState
    END
END AS ConfCity,
CASE
    WHEN MakeConf.Status IN ('N', 'U', 'D', 'I') THEN NULL
    ELSE CASE
        WHEN INSTR(MakeConf.CityState, ',') > 0 THEN substr(
            MakeConf.CityState,
            instr(MakeConf.CityState, ',') + 2,
            length(MakeConf.CityState) - instr(MakeConf.CityState, ',')
        )
        ELSE NULL
    END
END AS ConfState,
CASE
    WHEN MakeConf.Status IN ('N', 'U', 'D', 'I') THEN NULL
    ELSE MakeConf.Zip
END AS ConfZip,
CASE
    WHEN MakeConf.Status IN ('N', 'U', 'D', 'I') THEN NULL
    ELSE MakeConf.Country
END AS ConfCountry,
CASE
    WHEN MakeConf.Status IN ('N', 'U', 'D', 'I') THEN NULL
    ELSE MakeConf.PerformedBy
END AS ConfPerformedBy,
CASE
    WHEN MakeConf.Status IN ('N', 'U', 'D', 'I') THEN NULL
    ELSE MakeConf.GenNotes
END AS ConfGenNotes,

-- OCIA
OCIAReg.ProfDate,
    OCIAReg.Place,
    OCIAReg.[Add],
    SUBSTR(OCIAReg.City, 1, INSTR(OCIAReg.City, ',') - 1) AS OciaCity,
    SUBSTR(OCIAReg.City, INSTR(OCIAReg.City, ',') + 2, LENGTH(OCIAReg.City) - INSTR(OCIAReg.City, ',')) AS OciaState,
    OCIAReg.Zip,

-- Marriage
CASE
    WHEN MakeMar.Status IN ('N', 'U', 'D', 'I') THEN NULL
    ELSE MakeMar.Date
END AS MarDate,
MakeMar.ExtraInfo,
CASE
    WHEN MakeMar.Status IN ('Y', 'A') THEN 'YES'
    ELSE NULL
END AS MarStatus,
CASE
    WHEN MakeMar.Status IN ('N', 'U', 'D', 'I') THEN NULL
    ELSE MakeMar.Place
END AS MarPlace,
CASE
    WHEN MakeMar.Status IN ('N', 'U', 'D', 'I') THEN NULL
    ELSE MakeMar.Address1
END AS MarAddress1,
CASE
    WHEN MakeMar.Status IN ('N', 'U', 'D', 'I') THEN NULL
    ELSE CASE
        WHEN INSTR(MakeMar.CityState, ',') > 0 THEN substr(
            MakeMar.CityState,
            1,
            instr(MakeMar.CityState, ',') - 1
        )
        ELSE MakeMar.CityState
    END
END AS MarCity,
CASE
    WHEN MakeMar.Status IN ('N', 'U', 'D', 'I') THEN NULL
    ELSE CASE
        WHEN INSTR(MakeMar.CityState, ',') > 0 THEN substr(
            MakeMar.CityState,
            instr(MakeMar.CityState, ',') + 2,
            length(MakeMar.CityState) - instr(MakeMar.CityState, ',')
        )
        ELSE NULL
    END
END AS MarState,
CASE
    WHEN MakeMar.Status IN ('N', 'U', 'D', 'I') THEN NULL
    ELSE MakeMar.Zip
END AS MarZip,
CASE
    WHEN MakeMar.Status IN ('N', 'U', 'D', 'I') THEN NULL
    ELSE MakeMar.Country
END AS MarCountry,
CASE
    WHEN MakeMar.Status IN ('N', 'U', 'D', 'I') THEN NULL
    ELSE MakeMar.PerformedBy
END AS MarPerformedBy,
CASE
    WHEN MakeMar.Status IN ('N', 'U', 'D', 'I') THEN NULL
    ELSE MakeMar.GenNotes
END AS MarGenNotes,

-- Death
CASE
    WHEN MakeDeath.Status IN ('N', 'U', 'D', 'I') THEN NULL
    ELSE MakeDeath.Date
END AS DeathDate,
CASE
    WHEN MakeDeath.Status IN ('Y', 'A') THEN 'YES'
    ELSE NULL
END AS DeathStatus,
CASE
    WHEN MakeDeath.Status IN ('N', 'U', 'D', 'I') THEN NULL
    ELSE MakeDeath.Place
END AS DeathPlace,
CASE
    WHEN MakeDeath.Status IN ('N', 'U', 'D', 'I') THEN NULL
    ELSE MakeDeath.Address1
END AS DeathAddress1,
CASE
    WHEN MakeDeath.Status IN ('N', 'U', 'D', 'I') THEN NULL
    ELSE CASE
        WHEN INSTR(MakeDeath.CityState, ',') > 0 THEN substr(
            MakeDeath.CityState,
            1,
            instr(MakeDeath.CityState, ',') - 1
        )
        ELSE MakeDeath.CityState
    END
END AS DeathCity,
CASE
    WHEN MakeDeath.Status IN ('N', 'U', 'D', 'I') THEN NULL
    ELSE CASE
        WHEN INSTR(MakeDeath.CityState, ',') > 0 THEN substr(
            MakeDeath.CityState,
            instr(MakeDeath.CityState, ',') + 2,
            length(MakeDeath.CityState) - instr(MakeDeath.CityState, ',')
        )
        ELSE NULL
    END
END AS DeathState,
CASE
    WHEN MakeDeath.Status IN ('N', 'U', 'D', 'I') THEN NULL
    ELSE MakeDeath.Zip
END AS DeathZip,
CASE
    WHEN MakeDeath.Status IN ('N', 'U', 'D', 'I') THEN NULL
    ELSE MakeDeath.Country
END AS DeathCountry,
CASE
    WHEN MakeDeath.Status IN ('N', 'U', 'D', 'I') THEN NULL
    ELSE MakeDeath.PerformedBy
END AS DeathPerformedBy,
CASE
    WHEN MakeDeath.Status IN ('N', 'U', 'D', 'I') THEN NULL
    ELSE MakeDeath.GenNotes
END AS DeathGenNotes,
CASE
    WHEN MakeDeath.Status IN ('N', 'U', 'D', 'I') THEN NULL
    ELSE MakeDeath.PlaceOfBurial
END AS PlaceOfBurial,
CASE
    WHEN MakeDeath.Status IN ('N', 'U', 'D', 'I') THEN NULL
    ELSE MakeDeath.BurialPlaceCityState
END AS BurialPlaceCityState
FROM
    Mem
    LEFT JOIN MakeMar ON Mem.MemRecNum = MakeMar.MemRecNum
    LEFT JOIN "MakeBaptisms/Rconcil" ON Mem.MemRecNum = "MakeBaptisms/Rconcil".MemRecNum
    LEFT JOIN MakeFirstComm ON Mem.MemRecNum = MakeFirstComm.MemRecNum
    LEFT JOIN MakeReconcilDates ON Mem.MemRecNum = MakeReconcilDates.MemRecNum
    LEFT JOIN OCIAReg ON Mem.MemRecNum = OCIAReg.MemRecNum
    LEFT JOIN MakeConf ON Mem.MemRecNum = MakeConf.MemRecNum
    LEFT JOIN MakeDeath ON Mem.MemRecNum = MakeDeath.MemRecNum
WHERE (
        MakeMar.MemRecNum IS NOT NULL
        OR "MakeBaptisms/Rconcil".MemRecNum IS NOT NULL
        OR MakeFirstComm.MemRecNum IS NOT NULL
        OR OCIAReg.MemRecNum IS NOT NULL
        OR MakeConf.MemRecNum IS NOT NULL
        OR MakeDeath.MemRecNum IS NOT NULL
    )
GROUP BY
    mem.MemRecNum;

INSERT INTO
    SacramentSponsors (
        PDSMemberID,
        Sacrament,
        SponsorName,
        SponsorType
    )
SELECT DISTINCT
    MemDates.MemRecNum,
    DateType.Description,
    MemSpons.Name,
    AskSpType.Description
FROM
    MemSpons
    INNER JOIN MemSac ON MemSpons.SacRecNum = MemSac.SacRecNum
    INNER JOIN MemDates ON MemSac.SacMemDateRec = MemDates.MemDateRecNum
    INNER JOIN DateType ON MemDates.DescRec = DateType.DescRec
    LEFT JOIN AskSpType ON MemSpons.SponsorDescRec = AskSpType.SponsorDescRec
WHERE
    MemSpons.Name IS NOT NULL;

DELETE FROM SacramentSponsors
WHERE
    Sacrament NOT IN(
        'Baptism',
        'Confirmation',
        'Marriage',
        'RCIA'
    );

UPDATE SacramentSponsors
SET
    Proxy = (
        SELECT BapReg.Proxy1
        FROM BapReg
        WHERE
            BapReg.Sponsor1 = SacramentSponsors.SponsorName
            AND CAST(BapReg.MemRecNum AS INTEGER) = CAST(
                SacramentSponsors.PDSMemberID AS INTEGER
            )
    )
WHERE
    Sacrament = 'Baptism'
    AND Proxy IS NULL
    AND EXISTS (
        SELECT 1
        FROM BapReg
        WHERE
            BapReg.Sponsor1 = SacramentSponsors.SponsorName
            AND CAST(BapReg.MemRecNum AS INTEGER) = CAST(
                SacramentSponsors.PDSMemberID AS INTEGER
            )
    );

UPDATE SacramentSponsors
SET
    Proxy = (
        SELECT BapReg.Proxy2
        FROM BapReg
        WHERE
            BapReg.Sponsor2 = SacramentSponsors.SponsorName
            AND CAST(BapReg.MemRecNum AS INTEGER) = CAST(
                SacramentSponsors.PDSMemberID AS INTEGER
            )
    )
WHERE
    Sacrament = 'Baptism'
    AND Proxy IS NULL
    AND EXISTS (
        SELECT 1
        FROM BapReg
        WHERE
            BapReg.Sponsor2 = SacramentSponsors.SponsorName
            AND CAST(BapReg.MemRecNum AS INTEGER) = CAST(
                SacramentSponsors.PDSMemberID AS INTEGER
            )
    );

UPDATE SacramentSponsors
SET
    Proxy = (
        SELECT ConfReg.Proxy
        FROM ConfReg
        WHERE
            ConfReg.Sponsor = SacramentSponsors.SponsorName
            AND CAST(ConfReg.MemRecNum AS INTEGER) = CAST(
                SacramentSponsors.PDSMemberID AS INTEGER
            )
    )
WHERE
    Sacrament = 'Confirmation'
    AND Proxy IS NULL
    AND EXISTS (
        SELECT 1
        FROM ConfReg
        WHERE
            ConfReg.Sponsor = SacramentSponsors.SponsorName
            AND CAST(ConfReg.MemRecNum AS INTEGER) = CAST(
                SacramentSponsors.PDSMemberID AS INTEGER
            )
    );

UPDATE SacramentSponsors
SET
    Proxy = (
        SELECT MarReg.Proxy1
        FROM MarReg
        WHERE
            MarReg.Witness1 = SacramentSponsors.SponsorName
            AND CAST(MarReg.MemRecNum AS INTEGER) = CAST(
                SacramentSponsors.PDSMemberID AS INTEGER
            )
    )
WHERE
    Sacrament = 'Marriage'
    AND Proxy IS NULL
    AND EXISTS (
        SELECT 1
        FROM MarReg
        WHERE
            MarReg.Witness1 = SacramentSponsors.SponsorName
            AND CAST(MarReg.MemRecNum AS INTEGER) = CAST(
                SacramentSponsors.PDSMemberID AS INTEGER
            )
    );

UPDATE SacramentSponsors
SET
    Proxy = (
        SELECT MarReg.Proxy2
        FROM MarReg
        WHERE
            MarReg.Witness2 = SacramentSponsors.SponsorName
            AND CAST(MarReg.MemRecNum AS INTEGER) = CAST(
                SacramentSponsors.PDSMemberID AS INTEGER
            )
    )
WHERE
    Sacrament = 'Marriage'
    AND Proxy IS NULL
    AND EXISTS (
        SELECT 1
        FROM MarReg
        WHERE
            MarReg.Witness2 = SacramentSponsors.SponsorName
            AND CAST(MarReg.MemRecNum AS INTEGER) = CAST(
                SacramentSponsors.PDSMemberID AS INTEGER
            )
    );

INSERT INTO
    SacramentSponsors (
        PDSMemberID,
        Sacrament,
        SponsorName,
        SponsorType,
        Proxy
    )
SELECT
    MemRecNum,
    'Baptism' AS Sacrament,
    Sponsor1,
    'Christian Witness' AS SponsorType,
    Proxy1
FROM BapReg
WHERE
    MemRecNum IS NOT NULL
    AND (
        Sponsor1 IS NOT NULL
        OR Proxy1 IS NOT NULL
    );

INSERT INTO
    SacramentSponsors (
        PDSMemberID,
        Sacrament,
        SponsorName,
        SponsorType,
        Proxy
    )
SELECT
    MemRecNum,
    'Baptism' AS Sacrament,
    Sponsor2,
    'Christian Witness' AS SponsorType,
    Proxy1
FROM BapReg
WHERE
    MemRecNum IS NOT NULL
    AND (
        Sponsor2 IS NOT NULL
        OR Proxy1 IS NOT NULL
    );

INSERT INTO
    SacramentSponsors (
        PDSMemberID,
        Sacrament,
        SponsorName,
        SponsorType,
        Proxy
    )
SELECT
    MemRecNum,
    'Confirmation' AS Sacrament,
    Sponsor,
    'Sponsor' AS SponsorType,
    Proxy
FROM ConfReg
WHERE
    MemRecNum IS NOT NULL
    AND (
        Sponsor IS NOT NULL
        OR Proxy IS NOT NULL
    );

INSERT INTO
    SacramentSponsors (
        PDSMemberID,
        Sacrament,
        SponsorName,
        SponsorType,
        Proxy
    )
SELECT
    MemRecNum,
    'Marriage' AS Sacrament,
    Witness1,
    'Witness' AS SponsorType,
    Proxy1
FROM MarReg
WHERE
    MemRecNum IS NOT NULL
    AND (
        Witness1 IS NOT NULL
        OR Proxy1 IS NOT NULL
    );

INSERT INTO
    SacramentSponsors (
        PDSMemberID,
        Sacrament,
        SponsorName,
        SponsorType,
        Proxy
    )
SELECT
    MemRecNum,
    'Marriage' AS Sacrament,
    Witness2,
    'Witness' AS SponsorType,
    Proxy2
FROM MarReg
WHERE
    MemRecNum IS NOT NULL
    AND (
        Witness1 IS NOT NULL
        OR Proxy1 IS NOT NULL
    );

CREATE TABLE IF NOT EXISTS ttblSacramentSponsors AS
SELECT
    CAST(TRIM(PDSMemberID) AS INTEGER) AS PDSMemberID,
    Sacrament,
    CASE
        WHEN INSTR(SponsorName, '&') > 0 THEN SUBSTR(
            SponsorName,
            1,
            INSTR(SponsorName, '&') - 1
        )
        WHEN INSTR(SponsorName, ' and ') > 0 THEN SUBSTR(
            SponsorName,
            1,
            INSTR(SponsorName, ' and ') - 1
        )
        ELSE SponsorName
    END || '' || CASE
        WHEN INSTR(SponsorName, '&') > 0 THEN SUBSTR(
            SUBSTR(
                SponsorName,
                INSTR(SponsorName, '&') + 2,
                length(SponsorName) - INSTR(SponsorName, '&')
            ),
            INSTR(
                SUBSTR(
                    SponsorName,
                    INSTR(SponsorName, '&') + 2
                ),
                ' '
            ) + 1
        )
        WHEN INSTR(SponsorName, ' and ') > 0 THEN SUBSTR(
            SUBSTR(
                SponsorName,
                INSTR(SponsorName, ' and ') + 2,
                length(SponsorName) - INSTR(SponsorName, ' and ')
            ),
            INSTR(
                SUBSTR(
                    SponsorName,
                    INSTR(SponsorName, ' and ') + 2
                ),
                ' '
            ) + 1
        )
        ELSE ''
    END AS SponsorName1,
    CASE
        WHEN Sacrament = 'Baptism' THEN 'Godparent'
        WHEN Sacrament = 'Marriage' THEN 'Witness'
        WHEN Sacrament = 'Confirmation' THEN 'Sponsor'
        ELSE SponsorType
    END AS SponsorType,
    Proxy
FROM SacramentSponsors
UNION
SELECT
    CAST(TRIM(PDSMemberID) AS INTEGER) as PDSMember,
    Sacrament,
    CASE
        WHEN INSTR(SponsorName, '&') > 0 THEN SUBSTR(
            SponsorName,
            INSTR(SponsorName, '&') + 2,
            length(SponsorName) - INSTR(SponsorName, '&')
        )
        WHEN INSTR(SponsorName, ' and ') > 0 THEN SUBSTR(
            SponsorName,
            INSTR(SponsorName, ' and ') + 2,
            length(SponsorName) - INSTR(SponsorName, ' and ')
        )
        ELSE NULL
    END AS SponsorName1,
    CASE
        WHEN Sacrament = 'Baptism' THEN 'Godparent'
        WHEN Sacrament = 'Marriage' THEN 'Witness'
        WHEN Sacrament = 'Confirmation' THEN 'Sponsor'
        ELSE SponsorType
    END AS SponsorType,
    Proxy
FROM SacramentSponsors
WHERE
    SponsorName1 IS NOT NULL;

DELETE FROM SacramentSponsors;

INSERT INTO
    SacramentSponsors (
        PDSMemberID,
        Sacrament,
        SponsorName,
        SponsorType,
        Proxy
    )
SELECT
    PDSMemberID,
    Sacrament,
    SponsorName1,
    SponsorType,
    Proxy
FROM ttblSacramentSponsors;

DROP TABLE ttblSacramentSponsors;