INSERT INTO
    MemberKeywords (PDSMemberID, Keyword)
SELECT MemKW.MemRecNum AS PDSMemberID, MemKWType.Description AS Keyword
FROM MemKW
    INNER JOIN MemKWType ON MemKW.DescRec = MemKWType.DescRec;