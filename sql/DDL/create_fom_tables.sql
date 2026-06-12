CREATE TABLE [Attendance](
    [MemRecNum] TEXT,
    [REClassRecNum] TEXT,
    [Date] TEXT,
    [Code] TEXT
    );

CREATE TABLE [ClassDates](
    [ClassRecNum] TEXT,
    [ClassDate] TEXT
    );

CREATE TABLE [FormationFamilies](
        [FamRecNum] TEXT,
        [Last_Name] TEXT,
        [REGenRemarks1] TEXT,
        [REConfRemarks1] TEXT,
        [REInactive1] TEXT,
        [REFamily1] TEXT,
        [CensusFamily1] TEXT
    );

CREATE TABLE [FormationHealthRemarks] (
        [MemRecNum] TEXT,
        [FamRecNum] TEXT,
        [HealthRemaks] TEXT,
        [REGenRemarks1] TEXT,
        [REConfRemarks1] TEXT
    );

CREATE TABLE [PermanentRecord](
        [MemRecNum] TEXT,
        [OrderNum] TEXT,
        [PRYear] TEXT,
        [Description] TEXT,
        [SessionName] TEXT,
        [PRTeacher] TEXT,
        [PRAbsent] TEXT,
        [PRPresent] TEXT,
        [PRComment] TEXT
    );

CREATE TABLE [SessionCatechists](
        [ClassRecNum] TEXT,
        [MemRecNum] TEXT,
        [Name] TEXT,
        [Description] TEXT
    );

CREATE TABLE [Sessions](
        [Name] TEXT,
        [REClassRecNum] TEXT,
        [REYear_Description] TEXT,
        [GradeType_Description] TEXT,
        [RETimeType_Description] TEXT,
        [RERoomType_Description] TEXT,
        [StartDate] TEXT,
        [EndDate] TEXT,
        [Inactive] TEXT
    );

CREATE TABLE [StudentClasses](
        [MemRecNum] TEXT,
        [REClassRecNum] TEXT,
        [Mem_Name] TEXT,
        [REClass_Name] TEXT
    );