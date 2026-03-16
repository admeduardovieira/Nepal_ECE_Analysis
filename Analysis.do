

use "D:\Research\BDHS Research\Nepal\Child\Data\BDHS_Nepal_Child_Clean.dta", clear

*Household Water, Handwashing, and Socioeconomic Determinants of Early Childhood Education Participation in Nepal: Evidence from a Nationally Representative Survey

*-------------------------------
* Set survey design for DHS
*-------------------------------
gen weight = hv005/1000000   // DHS weight needs to be scaled
svyset hv021 [pw=weight], strata(hv022)






tab ECE water_imp, row col cell chi2

* Explanation:
* row   → shows row percentages
* col   → shows column percentages
* cell  → shows cell percentages
* chi2  → Pearson chi-square test



*==================================================
* Crosstabs with Chi-square and percentages
*==================================================

* Example syntax for one variable:
tab ECE water_imp, chi2 row col cell

* For all predictors, repeat similarly:

tab ECE water_treat, chi2 row col cell
tab ECE handwash_basic, chi2 row col cell
tab ECE handwash_place, chi2 row col cell
tab ECE handwash_env, chi2 row col cell

tab ECE residence, chi2 row col cell
tab ECE division, chi2 row col cell
tab ECE wealth, chi2 row col cell
tab ECE hh_size, chi2 row col cell
tab ECE hh_head_sex, chi2 row col cell
tab ECE mother_edu, chi2 row col cell
tab ECE birth_order_cat, chi2 row col cell
tab ECE child_sex, chi2 row col cell
tab ECE media_access, chi2 row col cell





********************************************************************************
********************************************************************************
* Univariates
********************************************************************************
********************************************************************************
*-----------------------------------------------
* Logistic regression for ECE
*-----------------------------------------------

* Water improved
svy: logistic ECE i.water_imp

* Water treatment
svy: logistic ECE i.water_treat

* Basic handwashing
svy: logistic ECE i.handwash_basic

* Handwashing place
svy: logistic ECE i.handwash_place

* Handwashing environment
svy: logistic ECE i.handwash_env

* Residence (Urban/Rural)
svy: logistic ECE i.residence

* Division
svy: logistic ECE i.division

* Wealth
svy: logistic ECE i.wealth

* Household size
svy: logistic ECE i.hh_size

* Household head sex
svy: logistic ECE i.hh_head_sex

* Mother education
svy: logistic ECE i.mother_edu

* Birth order category
svy: logistic ECE i.birth_order_cat

* Child sex
svy: logistic ECE i.child_sex

* Media access
svy: logistic ECE i.media_access





* Run logistic regression
svy: logit ECE water_imp water_treat handwash_env division hh_size mother_edu birth_order_cat media_access residence wealth child_sex




water facility, water treatment, handwash environment, province, household size, mother education, birth order, media access, residence, wealth, child sex


*--------------------------------------------------
* Final multivariable logistic regression with i. prefix
*--------------------------------------------------
svy: logistic ECE ///
    i.handwash_place ///
    i.handwash_basic ///
    i.water_imp /// categorical (0/1)
    i.water_treat /// categorical (0/1)
    i.handwash_env /// categorical (Limited/Adequate)
    i.division /// categorical
    hh_size /// numeric or binary (<5 vs ≥5)
    i.mother_edu /// categorical
    i.birth_order_cat /// categorical (1, 2-3, 4+)
    i.media_access /// categorical
    i.residence /// categorical (Rural/Urban)
    i.wealth /// categorical (Poorest → Richest)
    i.child_sex 





*********************************************************
********************************************************
* ROCCURVE
*********************************************************
********************************************************
* Predict probabilities
predict phat, pr

* ROC curve (requires outcome ECE 0/1)
roctab ECE phat


* Generate ROC data points
roctab ECE phat, graph detail











* Subset: Rural households
svy, subpop(if residence==0): logistic ECE ///
    i.water_imp ///
    i.water_treat ///
    i.handwash_env ///
    i.division ///
    hh_size ///
    i.mother_edu ///
    i.birth_order_cat ///
    i.media_access ///
    i.wealth ///
    i.child_sex

* Store model for plotting
estimates store rural_model







* Subset: Urban households
svy, subpop(if residence==1): logistic ECE ///
    i.water_imp ///
    i.water_treat ///
    i.handwash_env ///
    i.division ///
    hh_size ///
    i.mother_edu ///
    i.birth_order_cat ///
    i.media_access ///
    i.wealth ///
    i.child_sex

* Store model for plotting
estimates store urban_model










********************************************************************************
* Folder path
********************************************************************************
local folder "D:\Research\BDHS Research\Nepal\Child\Data"

********************************************************************************
* Helper program: collapse YES cases and export % (division-wise)
********************************************************************************
capture program drop make_pct
program define make_pct
    syntax varname using/

    preserve
        * Keep only YES (=1)
        keep if `varlist' == 1

        * Count YES cases by division
        collapse (count) Yes_cases = `varlist', by(division)

        * Total YES cases
        quietly summarize Yes_cases
        local total_yes = r(sum)

        * Percentage
        gen pct_yes = round((Yes_cases / `total_yes') * 100, 1)

        * Export to Excel
        export excel division Yes_cases pct_yes ///
            using "`using'", firstrow(variables) replace
    restore
end
********************************************************************************


********************************************************************************
* Early Childhood Education (ECE)
********************************************************************************
make_pct ECE using "`folder'\ECE_division_pct.xlsx"





























