INSERT INTO
    Attendance (
        MemRecNum,
        REClassRecNum,
        Date,
        Code
    )
SELECT TRIM(MemREAttn.MemRecNum), TRIM(MemREAttn.REClassRecNum), TRIM(MemREAttn.Date), TRIM(MemREAttn.Code)
FROM MemREAttn
WHERE
    MemREAttn.MemRecNum IS NOT NULL
    AND MemREAttn.REClassRecNum IS NOT NULL;