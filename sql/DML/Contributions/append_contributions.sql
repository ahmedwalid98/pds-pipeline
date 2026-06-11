INSERT INTO
    ContributionsExport (
        PDSFamilyID,
        FundNumber,
        FundYear,
        Amount,
        Activity,
        CheckNumber,
        ContributionDate,
        Comments,
        BatchNumber
    )
SELECT
    FamFundHist.FEFamRec,
    FamFund.FDFund,
    FamFund.FDYear,
    FamFundHist.FEAmt,
    FundAct.Activity,
    FamFundHist.FEChk,
    FamFundHist.FEDate,
    FamFundHist.FEComment,
    CASE
        WHEN FamFundHist.FEBatch < 0 THEN NULL
        ELSE FamFundHist.FEBatch
    END
FROM FundAct
    INNER JOIN (
        FamFund
        INNER JOIN FamFundHist ON FamFund.FDRecNum = FamFundHist.FEFundRec
    ) ON FundAct.ActRecNum = FamFundHist.ActRecNum
WHERE
    FamFundHist.FEDate >= '2016-01-01';

DELETE FROM ContributionsExport
WHERE
    CheckNumber = 'EFT-Error'
    OR CheckNumber = 'Mistake';

WITH
    cte AS (
        SELECT ffh.FEFamRec, fa.FundRecNum, ff.FDRecNum, ff.FDFund, ff.FDYear, fa.Activity, ffh.FEDate
        FROM
            FundAct fa
            JOIN FamFundHist ffh ON fa.ActRecNum = ffh.ActRecNum
            JOIN FamFund ff ON ff.FDRecNum = ffh.FEFundRec
        WHERE
            ffh.FEDate >= '2016-01-01'
    ),
    link_families AS (
        SELECT *
        FROM cte c
        WHERE
            NOT EXISTS (
                SELECT 1
                FROM FundPeriod fp
                WHERE
                    fp.SetupRecNum = c.FundRecNum
                    AND fp.FundNumber = c.FDFund
            )
    ),
    new_values AS (
        SELECT lf.FEFamRec, lf.FEDate, fs.FundNumber AS NewFundNumber, lf.Activity
        FROM
            link_families lf
            JOIN FundSetup fs ON fs.SetupRecNum = lf.FundRecNum
    )
UPDATE ContributionsExport
SET
    FundNumber = (
        SELECT NewFundNumber
        FROM new_values
        where
            new_values.FEFamRec = ContributionsExport.PDSFamilyID
            AND new_values.FEDate = ContributionsExport.ContributionDate
            AND ContributionsExport.Activity = new_values.Activity
    )
WHERE
    EXISTS (
        SELECT 1
        FROM new_values nv
        WHERE
            nv.FEFamRec = ContributionsExport.PDSFamilyID
            AND nv.FEDate = ContributionsExport.ContributionDate
            AND ContributionsExport.Activity = nv.Activity
    );