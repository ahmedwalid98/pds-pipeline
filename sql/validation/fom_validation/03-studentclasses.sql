DELETE FROM StudentClasses
WHERE
    NOT EXISTS (
        SELECT 1
        FROM WPMemberExport
        WHERE
            WPMemberExport.PDSMemberID = StudentClasses.MemRecNum
    );

-- Auto-fix: orphaned sessions
DELETE FROM StudentClasses
WHERE
    NOT EXISTS (
        SELECT 1
        FROM Sessions
        WHERE
            Sessions.REClassRecNum = StudentClasses.REClassRecNum
    );