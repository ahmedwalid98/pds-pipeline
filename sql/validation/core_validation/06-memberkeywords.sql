DELETE FROM MemberKeywords
WHERE
    NOT EXISTS (
        SELECT 1
        FROM WPMemberExport M
        WHERE
            M.PDSMemberID = MemberKeywords.PDSMemberID
    );

-- Auto-fix: null keyword
DELETE FROM MemberKeywords WHERE Keyword IS NULL;