# SAS Steps Summary

## Step 0-1: Load Data and Add Useful Column Names

## Step 2: Summary Statistics 
- Create a "Last Dates" Dataset which contains the latest `PoolCutOffDate` for each `EDCode` and its accompanying `PoolIdentifier`
- Create a "Deal Names" Dataset which contains the deal name for each `EDCode`
- Merge "Last Dates" and "Deal Names"
- Create a "one-way frequency table for each variable" for : `AccountStatus, 
AccountStatusDate, 
BorrowerType, 
BorrowerYearofBirth, 
BorrowersEmploymentStatus, 
ClassofBorrower, 
ConstructionYear, 
CurrentInterestRateIndex, 
CurrentValuationDate, 
ForeignNational, 
FirsttimeBuyer, 
GeographicRegionList, 
InterestRateType, 
InterestRateResetInterval, 
LengthofPaymentHoliday, 
Lien, 
Litigation, 
LoanCurrencyDenomination, 
LoanOriginationDate, 
LoanTerm, 
NewProperty, 
NumberofDebtors, 
OccupancyType, 
Originator, 
PoolIdentifier, 
PrepaymentDate, 
PropertyRating, 
PropertyType, 
Purpose, 
Resident, 
RighttoBuy, 
ValuationDate`
- Get means of `Arrears1MonthAgo,
Arrears2MonthsAgo,
ArrearsBalance,
BureauScoreValue,
CumulativePrepayments,
CumulativeRecoveries,
CurrentBalance,
CurrentInterestRate,
CurrentInterestRateMargin,
CurrentValuationAmount,
DebttoIncome,
DefaultorForeclosure,
FlexibleLoanAmount,
Ipoteca,
NumberMonthsinArrears,
OriginalBalance,
OriginalLoantoValue,
PariPassuLoans,
PrimaryIncome,
SecondaryIncome,
ValuationAmount`


## Step 3: Clean Discrete Values
- Starts by hand-fixing some Lien values
- Cleans up the following (to make sure they only contain legal, discrete values) : `AccountStatus, 
        BK, 
        BorrowersEmploymentStatus, 
        BorrowerType, 
        BureauScoreProvider, 
        BureauScoreType, 
        CurrentInterestRateIndex, 
        CurrentValuationType, 
        DeedofPostponement, 
        FirsttimeBuyer, 
        ForeignNational, 
        FractionedSubrogatedLoans, 
        GeographicRegionList, 
        InterestRateType, 
        IsPropertyTransferabilityLimited, 
        Lien, 
        Litigation, 
        LoanflaggedasContencioso, 
        NewProperty, 
        PropertyType, 
        OccupancyType, 
        OrigChannel, 
        OriginalValuationType, 
        PaymentFrequency, 
        PaymentType, 
        PIncomeVerification, 
        Purpose, 
        Resident, 
        PriorRepossessions, 
        RealEstateOwned, 
        RegulatedLoan, 
        RepaymentMethod, 
        RestructuringArrangement, 
        RevisedInterestRateIndex, 
        RighttoBuy, 
        SharedOwnership, 
        SIncomeVerification, 
        Subsidy, 
        TypeofGuaranteeProvider`

- Bounds check these variables:
        `BorrowerYearofBirth, 
        ConstructionYear`

- New Variables Defined: `PayAhead,
        PayAhead1MonthAgo,
        PayAhead2MonthsAgo` (by checking for negative balances)

## Step 4: Working with Static Vars
- The steps in this file cleans up/selects static variables (those that don't change over time).
However, the EUDW has values of these variables for every reporting period.  We can leverage this to look
for the best values going. 

## Step 5: Aggregate Static Vars
- Before we aggregate, we need to clean up LoanIdentifiers that change over time. Also, there are some complete duplicates that have different LoanIdentifiers

## Step 6: Clean Time Series
- Eliminate dates that are out of sequence for the deal (e.g. it reports quarterly but one year there are 5 dates)
- Take care of balances that have been multiplied by 100.
- Fill in gaps in balance, arrears, valuations.

## Step 7: Add Variables to Time Series

## Step 8: Aggregate Time Series
- Aggregates the time series by PropertyIdentifier and BorrowerIdentifier
- Calculates LTVs based on (a) original appraisal updated by HPI and (b) most current appraisal updated by HPI.
