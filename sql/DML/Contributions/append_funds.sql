INSERT INTO
    Funds (FundNumber, FundDescription)
SELECT FundSetup.FundNumber, FundSetup.FundName
FROM FundSetup;