DELETE FROM Ministries
WHERE
    NOT EXISTS (
        SELECT 1
        FROM WPMemberExport WM
        WHERE
            WM.PDSMemberID = Ministries.PDSMemberID
    );

-- Auto-fix: null ministry
DELETE FROM Ministries WHERE Ministry IS NULL;