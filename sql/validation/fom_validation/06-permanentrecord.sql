DELETE FROM PermanentRecord
WHERE
    NOT EXISTS (
        SELECT 1
        FROM WPMemberExport M
        WHERE
            M.PDSMemberID = PermanentRecord.MemRecNum
    );