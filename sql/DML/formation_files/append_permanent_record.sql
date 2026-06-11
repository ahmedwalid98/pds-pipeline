INSERT INTO
    PermanentRecord (
        MemRecNum,
        OrderNum,
        PRYear,
        Description,
        SessionName,
        PRTeacher,
        PRAbsent,
        PRPresent,
        PRComment
    )
SELECT DISTINCT
    MemREPR.MemRecNum,
    MemREPR.OrderNum,
    MemREPR.PRYear,
    GradeType.Description,
    MemREPR.SessionName,
    MemREPR.PRTeacher,
    MemREPR.PRAbsent,
    MemREPR.PRPresent,
    MemREPR.PRComment
FROM MemREPR
    LEFT JOIN GradeType ON GradeType.GradeDescRec = MemREPR.GradeDescRec;