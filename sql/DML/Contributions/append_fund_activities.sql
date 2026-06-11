INSERT INTO
    FundActivities (FundNumber, Activity)
SELECT TRIM(FundSetup.FundNumber), TRIM(FundAct.Activity)
FROM FundAct
    Inner JOIN FundSetup on FundAct.FundRecNum = FundSetup.SetupRecnum
WHERE (
        FundAct.Activity IS NOT NULL
        AND FundAct.GroupOrder <> 0
    )
    AND (
        CAST(FundAct.Function AS INTEGER) <> 16
    );

DELETE FROM FundActivities
WHERE
    Activity in (
        SELECT Activity
        FROM FundAct
        WHERE
            Function in (10, 16, 17, 18)
    );