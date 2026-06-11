INSERT INTO
    Sessions (
        Name,
        REClassRecNum,
        REYear_Description,
        GradeType_Description,
        RETimeType_Description,
        RERoomType_Description,
        StartDate,
        EndDate,
        Inactive
    )
SELECT DISTINCT
    REClass.Name,
    REClass.REClassRecNum,
    REYear.Description,
    GradeType.Description,
    RETimeType.Description,
    RERoomType.Description,
    REClass.StartDate,
    REClass.EndDate,
    CASE
        WHEN REClass.Inactive = 'FALSE' THEN 'NO'
    END
FROM
    REClass
    LEFT JOIN REYear ON REClass.YearDescRec = REYear.YearDescRec
    LEFT JOIN RETimeType ON REClass.TimeDescRec = RETimeType.TimeDescRec
    LEFT JOIN RERoomType ON REClass.RoomDescRec = RERoomType.RoomDescRec
    LEFT JOIN GradeType ON REClass.GradeDescRec = GradeType.GradeDescRec
WHERE
    REClass.Inactive = 'FALSE';