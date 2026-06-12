CREATE TABLE [ContributionsExport](
    [PDSFamilyID] TEXT,
    [FundNumber] TEXT,
    [FundYear] TEXT,
    [Amount] TEXT,
    [Activity] TEXT,
    [CheckNumber] TEXT,
    [ContributionDate] TEXT,
    [Comments] TEXT,
    [BatchNumber] TEXT
);

CREATE TABLE [FamilyKeywords](
        [PDSParishID] TEXT,
        [Keyword] TEXT
    );

CREATE TABLE [FundActivities](
        [FundNumber] TEXT,
        [Activity] TEXT
    );

CREATE TABLE [Funds](
        [FundNumber] TEXT,
        [FundDescription] TEXT,
        [Inactive] TEXT,
        [Recurring] TEXT,
        [NonRecurringStartDate] TEXT,
        [NonRecurringEndDate] TEXT
    );

CREATE TABLE [HouseholdEmails](
        [FamilyEmail1] TEXT,
        [FirstName] TEXT,
        [LastName] TEXT,
        [FamilyEmail2] TEXT,
        [Email1] TEXT,
        [Email2] TEXT,
        [Email3] TEXT,
        [Email4] TEXT,
        [Email5] TEXT,
        [PDSMemberID] TEXT,
        [PDSFamilyID] TEXT
    );

CREATE TABLE [MemberKeywords](
        [PDSMemberID] TEXT,
        [Keyword] TEXT
    );

CREATE TABLE [Ministries](
        [PDSMemberID] TEXT,
        [Ministry] TEXT
    );

CREATE TABLE [Pledge](
        [PDSFamilyID] TEXT,
        [PaymentFrequency] TEXT,
        [StartDate] TEXT,
        [EndDate] TEXT,
        [PledgeTotal] TEXT,
        [PaymentAmount] TEXT,
        [Activity] TEXT,
        [FundNumber] TEXT
    );

CREATE TABLE [SacramentBooks](
        [PDSMemberID] TEXT,
        [Sacrament] TEXT,
        [Date] TEXT,
        [Volume] TEXT,
        [Page] TEXT,
        [Entry] TEXT
    );

CREATE TABLE [Sacraments](
        [PDSMemberID] TEXT,
        [BirthPlace] TEXT,
        [FathersName] TEXT,
        [MothersName] TEXT,
        [MothersMaidenName] TEXT,
        [BaptismName] TEXT,
        [BaptismDate] TEXT,
        [BaptismStatus] TEXT,
        [BaptismPlace] TEXT,
        [BaptismStreetAddress] TEXT,
        [BaptismCity] TEXT,
        [BaptismState] TEXT,
        [BaptismZip] TEXT,
        [BaptismCountry] TEXT,
        [BaptismCelebrant] TEXT,
        [BaptismNotes] TEXT,
        [ReconciliationDate] TEXT,
        [FirstCommunionDate] TEXT,
        [FirstCommunionStatus] TEXT,
        [FirstCommunionPlace] TEXT,
        [FirstCommunionStreetAddress] TEXT,
        [FirstCommunionCity] TEXT,
        [FirstCommunionState] TEXT,
        [FirstCommunionZip] TEXT,
        [FirstCommunionCountry] TEXT,
        [FirstCommunionCelebrant] TEXT,
        [FirstCommunionNotes] TEXT,
        [ConfirmationName] TEXT,
        [ConfirmationDate] TEXT,
        [ConfirmationStatus] TEXT,
        [ConfirmationPlace] TEXT,
        [ConfirmationStreetAddress] TEXT,
        [ConfirmationCity] TEXT,
        [ConfirmationState] TEXT,
        [ConfirmationZip] TEXT,
        [ConfirmationCountry] TEXT,
        [ConfirmationCelebrant] TEXT,
        [ConfirmationNotes] TEXT,
        [RCIADate] TEXT,
        [RCIAStatus] TEXT,
        [RCIAPlace] TEXT,
        [RCIAStreetAddress] TEXT,
        [RCIACity] TEXT,
        [RCIAState] TEXT,
        [RCIAZip] TEXT,
        [RCIACountry] TEXT,
        [RCIACelebrant] TEXT,
        [RCIANotes] TEXT,
        [MarriageSpouseName] TEXT,
        [MarriageDate] TEXT,
        [MarriageStatus] TEXT,
        [MarriagePlace] TEXT,
        [MarriageStreetAddress] TEXT,
        [MarriageCity] TEXT,
        [MarriageState] TEXT,
        [MarriageZip] TEXT,
        [MarriageCountry] TEXT,
        [MarriageCelebrant] TEXT,
        [MarriageNotes] TEXT,
        [DeceasedDate] TEXT,
        [DeceasedStatus] TEXT,
        [DeceasedPlace] TEXT,
        [DeceasedStreetAddress] TEXT,
        [DeceasedCity] TEXT,
        [DeceasedState] TEXT,
        [DeceasedZip] TEXT,
        [DeceasedCountry] TEXT,
        [DeceasedCelebrant] TEXT,
        [DeceasedNotes] TEXT,
        [DeceasedPlaceofBurial] TEXT,
        [DeathCityState] TEXT
    );

CREATE TABLE [SacramentSponsors](
        [PDSMemberID] TEXT,
        [Sacrament] TEXT,
        [SponsorName] TEXT,
        [SponsorType] TEXT,
        [Proxy] TEXT
    );

CREATE TABLE [Talents](
        [PDSMemberID] TEXT,
        [Talent] TEXT
    );

CREATE TABLE [WPFamilyExport](
        [EnvelopeNumber] TEXT,
        [PDSDioceseID] TEXT,
        [LastName] TEXT,
        [HouseholdType] TEXT,
        [StreetAddress1] TEXT,
        [StreetAddress2] TEXT,
        [StreetAddressCity] TEXT,
        [StreetAddressState] TEXT,
        [StreetAddressZip] TEXT,
        [StreetAddressCountry] TEXT,
        [MailingAddress1] TEXT,
        [MailingAddress2] TEXT,
        [MailingAddressCity] TEXT,
        [MailingAddressState] TEXT,
        [MailingAddressZip] TEXT,
        [MailingAddressCountry] TEXT,
        [AddressUnlisted] TEXT,
        [SendNoMail] TEXT,
        [PhoneNumber] TEXT,
        [PhoneNumberUnlisted] TEXT,
        [DateRegistered] TEXT,
        [DateLeft] TEXT,
        [ParishHousehold] TEXT,
        [SchoolHousehold] TEXT,
        [Notes] TEXT,
        [ConfidentialNotes] TEXT,
        [Inactive] TEXT,
        [PDSParishID] TEXT,
        [NoEnvelopes] TEXT
    );

CREATE TABLE [WPMemberExport](
        [MemberType] TEXT,
        [Relation] TEXT,
        [LastName] TEXT,
        [FirstName] TEXT,
        [MiddleName] TEXT,
        [Title] TEXT,
        [Suffix] TEXT,
        [Gender] TEXT,
        [DOB] TEXT,
        [DateDeceased] TEXT,
        [DateDeceasedUnknown] TEXT,
        [MaritalStatus] TEXT,
        [Religion] TEXT,
        [Grade] TEXT,
        [PreferredLanguage] TEXT,
        [CellPhoneNumber] TEXT,
        [CellPhoneNumberUnlisted] TEXT,
        [WorkPhoneNumber] TEXT,
        [EmailAddress] TEXT,
        [Notes] TEXT,
        [PDSFamilyID] TEXT,
        [PDSMemberID] TEXT,
        [Inactive] TEXT,
        [DateInactive] TEXT,
        [ConfidentialNotes] TEXT,
        [Location] TEXT,
        [MaidenName] TEXT,
        [PreferredName] TEXT,
        [School] TEXT,
        [Occupation] TEXT
    );

CREATE TABLE [WPMemberExportFamPhone](
        [PDSFamilyID] TEXT,
        [PDSMemberID] TEXT,
        [Inactive] TEXT,
        [MemberType] TEXT,
        [Gender] TEXT,
        [LastName] TEXT,
        [FirstName] TEXT,
        [CellPhoneNumber] TEXT,
        [FamPhoneNumber] TEXT,
        [FamPhoneType] TEXT,
        [FamPhoneUnlisted] TEXT
    );

CREATE TABLE [OCIAReg](
        [MemRecNum] TEXT,
        [ProfDate] TEXT,
        [Place] TEXT,
        [Add] TEXT,
        [City] TEXT,
        [Zip] TEXT
    );

CREATE TABLE ttblDatePlaces_Reg (
    RegRecNum TEXT,
    RegName Text,
    SacramentName TEXT,
    PlaceID TEXT,
    Place TEXT,
    Address1 TEXT,
    CityState TEXT,
    City TEXT,
    State TEXT,
    Zip Text,
    Country TEXT,
    MatchKey TEXT,
    BurialPlace Text
);

CREATE TABLE IF NOT EXISTS ValidationResults (
    CheckName TEXT,
    FailedRows INTEGER,
    RunTime TEXT
);