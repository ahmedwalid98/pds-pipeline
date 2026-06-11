INSERT INTO
    SessionCatechists (
        ClassRecNum,
        MemRecNum,
        Name,
        Description
    )
SELECT REClassTea.ClassRecNum, ChurchContact.MemRecNum, ChurchContact.Name, REPosType.Description
FROM (
        REClassTea
        INNER JOIN ChurchContact on REClassTea.TeacherRec = ChurchContact.CCRec
    )
    LEFT JOIN REPosType ON REClassTea.PositionDescRec = REPosType.PositionDescRec;