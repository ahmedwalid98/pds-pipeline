INSERT INTO
    Ministries (PDSMemberID, Ministry)
SELECT DISTINCT
    MemMin.MemRecNum AS PDSMemberID,
    MinType.Description AS Ministry
FROM (
        MemMin
        INNER JOIN MinType ON MemMin.MinDescRec = MinType.MinDescRec
    )
    LEFT JOIN StatusType ON MemMin.StatusDescRec = StatusType.StatusDescRec
WHERE
    StatusType.Active IS NULL
    OR StatusType.Active = 'TRUE';