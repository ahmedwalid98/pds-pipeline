INSERT INTO
    StudentClasses (
        MemRecNum,
        REClassRecNum,
        Mem_Name,
        REClass_Name
    )
SELECT DISTINCT
    MemREShd.MemRecNum,
    MemREShd.REClassRecNum,
    Mem.Name,
    REClass.Name
FROM MemREShd
    LEFT JOIN REClass ON MemREShd.REClassRecNum = REClass.REClassRecNum
    LEFT JOIN Mem ON MemREShd.MemRecNum = Mem.MemRecNum
WHERE
    MemREShd.REClassRecNum IS NOT NULL;