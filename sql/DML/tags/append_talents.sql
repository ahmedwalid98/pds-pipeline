INSERT INTO
    Talents (PDSMemberID, Talent)
SELECT DISTINCT
    MemTal.MemRecNum,
    TalType.Description
FROM MemTal
    INNER JOIN TalType ON MemTal.TalDescRec = TalType.TalDescRec;