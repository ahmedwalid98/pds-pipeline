DELETE FROM Attendance
WHERE
    NOT EXISTS (
        SELECT 1
        FROM WPMemberExport
        WHERE
            WPMemberExport.PDSMemberID = Attendance.MemRecNum
    );

-- Auto-fix: orphaned sessions
DELETE FROM Attendance
WHERE
    NOT EXISTS (
        SELECT 1
        FROM Sessions S
        WHERE
            S.REClassRecNum = Attendance.REClassRecNum
    );

-- Auto-fix: null date
DELETE FROM Attendance WHERE Date IS NULL OR TRIM(Date) = '';

-- Flag: invalid attendance code
INSERT INTO
    ValidationResults (
        CheckName,
        FailedRows,
        RunTime
    )
SELECT 'Attendance_InvalidCode', COUNT(*), datetime('now')
FROM Attendance
WHERE
    Code NOT IN(0, 1, 3, 4);

DELETE FROM Attendance WHERE Code NOT IN(0, 1, 3, 4);