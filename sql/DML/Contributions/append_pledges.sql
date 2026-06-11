INSERT INTO
    Pledge (
        PDSFamilyID,
        PaymentFrequency,
        StartDate,
        EndDate,
        PledgeTotal,
        PaymentAmount,
        Activity,
        FundNumber
    )
SELECT
    FamFund.FDFamRec AS PDSFamilyID,
    FamFundRate.PeriodDescription AS PaymentFrequency,
    FamFundRate.FDStartDate AS StartDate,
    FamFundRate.FDEndDate AS EndDate,
    FamFundRate.FDTotal AS PledgeTotal,
    FamFundRate.FDRate AS PaymentAmount,
    FundAct.Activity,
    FamFund.FDFund AS FundNumber
FROM
    FamFundRate
    INNER JOIN FamFund ON FamFundRate.FundRecNum = FamFund.FDRecNum
    INNER JOIN FundAct ON FamFundRate.ActRecNum = FundAct.ActRecNum
WHERE
    FamFundRate.FDStartDate > '2009-01-01';

DELETE FROM Pledge
WHERE
    CAST(PledgeTotal AS INTEGER) = 0
    or PledgeTotal IS NULL;