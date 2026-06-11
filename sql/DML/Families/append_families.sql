INSERT INTO
    WPFamilyExport (
        EnvelopeNumber,
        PDSDioceseID,
        LastName,
        HouseholdType,
        StreetAddress1,
        StreetAddress2,
        StreetAddressCity,
        StreetAddressState,
        StreetAddressZip,
        StreetAddressCountry,
        MailingAddress1,
        MailingAddress2,
        MailingAddressCity,
        MailingAddressState,
        MailingAddressZip,
        MailingAddressCountry,
        AddressUnlisted,
        SendNoMail,
        PhoneNumber,
        PhoneNumberUnlisted,
        DateRegistered,
        DateLeft,
        ParishHousehold,
        SchoolHousehold,
        Notes,
        ConfidentialNotes,
        Inactive,
        NoEnvelopes,
        PDSParishID
    )
SELECT DISTINCT
    TRIM(fam.ParKey),
    Trim(fam.SecondID),
    CASE
        WHEN INSTR(fam.name, ',') > 0 THEN Trim(
            SUBSTR(
                fam.name,
                1,
                INSTR(fam.name, ',') - 1
            )
        )
        ELSE Trim(fam.Name)
    END AS LastName,
    Trim(FamStatType.Description),
    TRIM(fam.StreetAddress1),
    TRIM(fam.StreetAddress2),
    CASE
        WHEN INSTR(CityState.CityState, ',') > 0 THEN TRIM(
            SUBSTR(
                CityState.CityState,
                1,
                INSTR(CityState.CityState, ',') - 1
            )
        )
        ELSE TRIM(
            SUBSTR(
                CityState.CityState,
                1,
                LENGTH(CityState.CityState) - (
                    LENGTH(CityState.CityState) - LENGTH(
                        REPLACE (CityState.CityState, ' ', '')
                    )
                ) - 1
            )
        )
    END AS StreetAddressCity,
    CASE
        WHEN INSTR(CityState.CityState, ',') > 0 THEN TRIM(
            SUBSTR(
                CityState.CityState,
                INSTR(CityState.CityState, ',') + 1
            )
        )
        ELSE TRIM(
            SUBSTR(
                CityState.CityState,
                LENGTH(CityState.CityState) - (
                    LENGTH(CityState.CityState) - LENGTH(
                        REPLACE (CityState.CityState, ' ', '')
                    )
                )
            )
        )
    END AS StreetAddressState,
    TRIM(fam.StreetZip),
    NULL,
    TRIM(fam.MailingAddress1),
    TRIM(fam.MailingAddress2),
    CASE
        WHEN INSTR(MailingCity.CityState, ',') > 0 THEN TRIM(
            SUBSTR(
                MailingCity.CityState,
                1,
                INSTR(MailingCity.CityState, ',') - 1
            )
        )
        ELSE TRIM(
            SUBSTR(
                MailingCity.CityState,
                1,
                LENGTH(MailingCity.CityState) - (
                    LENGTH(MailingCity.CityState) - LENGTH(
                        REPLACE (
                                MailingCity.CityState,
                                ' ',
                                ''
                            )
                    )
                ) -1
            )
        )
    END AS MailingAddressCity,
    CASE
        WHEN INSTR(MailingCity.CityState, ',') > 0 THEN TRIM(
            SUBSTR(
                MailingCity.CityState,
                INSTR(MailingCity.CityState, ',') + 1
            )
        )
        ELSE TRIM(
            SUBSTR(
                MailingCity.CityState,
                LENGTH(MailingCity.CityState) - (
                    LENGTH(MailingCity.CityState) - LENGTH(
                        REPLACE (
                                MailingCity.CityState,
                                ' ',
                                ''
                            )
                    )
                )
            )
        )
    END AS MailingAddressState,
    TRIM(fam.MailingZip),
    NULL,
    CASE
        WHEN fam.SendNoMail = 'TRUE' THEN 'YES'
        ELSE 'NO'
    END AS SendNoMail,
    CASE
        WHEN fam.UnlAddresses = 'FALSE' THEN 'NO'
        ELSE 'YES'
    END as AddressUnlisted,
    Home.Number,
    CASE
        WHEN Home.Unlisted = 'TRUE' THEN 'YES'
        ELSE 'NO'
    END AS PhoneUnlisted,
    TRIM(fam.DateRegistered),
    TRIM(fam.DateLeftParish),
    'YES' AS ParishHousehold,
    'NO' AS SchoolHousehold,
    TRIM(fam.GenRemarks1),
    TRIM(fam.ConfRemarks1),
    CASE
        WHEN fam.PDSInactive1 = 'TRUE' THEN 'YES'
        ELSE 'NO'
    END AS Inactive,
    CASE
        WHEN fam.EnvelopeUser = 'FALSE' THEN 1
        ELSE 0
    END AS NoEnvelopes,
    TRIM(fam.FamRecNum)
FROM
    fam
    LEFT JOIN FamStatType ON fam.StatDescRec = FamStatType.StatDescRec
    LEFT JOIN City AS MailingCity ON MailingCity.CityRec = fam.MailingCityRec
    LEFT JOIN City AS CityState ON CityState.CityRec = fam.StreetCityRec
    LEFT JOIN "Home#" AS Home ON fam.FamRecNum = Home.FamRecNum;

UPDATE WPFamilyExport
SET
    MailingAddress1 = NULL,
    MailingAddress2 = NULL,
    MailingAddressCity = NULL,
    MailingAddressState = NULL,
    MailingAddressCountry = NULL,
    MailingAddressZip = NULL
WHERE
    StreetAddress1 = MailingAddress1;

DELETE FROM WPFamilyExport
WHERE (
        EnvelopeNumber IS null
        AND (
            LastName IS NULL
            OR length(LastName) = 0
        )
        AND StreetAddress1 IS NULL
        AND StreetAddress2 IS NULL
        AND StreetAddressCity IS NULL
        AND StreetAddressState IS NULL
        AND StreetAddressZip IS NULL
        AND StreetAddressCountry IS NULL
        AND MailingAddress1 IS NULL
        AND MailingAddress2 IS NULL
        AND MailingAddressCity IS NULL
        AND MailingAddressState IS NULL
        AND MailingAddressZip IS NULL
        AND MailingAddressCountry IS NULL
    );

DELETE FROM ttblMissingLinks;

INSERT INTO
    ttblMissingLinks (MissingRecId)
select FamRecNum
from fam
    left join WPFamilyExport on fam.FamRecNum = WPFamilyExport.PDSParishID
WHERE
    WPFamilyExport.PDSParishID is null;

DELETE FROM fam
WHERE
    FamRecNum in (
        SELECT MissingRecId
        FROM ttblMissingLinks
    );