


clear all

set maxvar 30000


* The Effects of Household Water, Sanitation, and Hygiene on Early Childhood Education Enrollment: Evidence from the 2022 Nepal Demographic and Health Survey




*Household Water, Handwashing, and Socioeconomic Determinants of Early Childhood Education Participation in Nepal: Evidence from a Nationally Representative Survey
 * Data Load
use "D:\Research\BDHS Research\Nepal\Child\Data\NPPR82FL.DTA", clear


svyset hv021 [pw=hv005], strata(hv022)
svy: tab hv121


* Outcome variables


tab hv121
describe hv121
codebook hv121




* Children under five
tab hv014
describe hv014
codebook hv014



*-------------------------------
* ECE outcome
*-------------------------------
tab hv121
describe hv121
codebook hv121

*-------------------------------
* WASH variables
*-------------------------------
tab hv201
describe hv201
codebook hv201

tab hv237
describe hv237
codebook hv237

tab hv205
describe hv205
codebook hv205

tab hv225
describe hv225
codebook hv225

tab hv230a
codebook hv230a
describe hv230a




tab hv230b
describe hv230b
codebook hv230b














*--------------------------------------------------
* Toilet facility (JMP: Improved vs Unimproved)
*--------------------------------------------------
gen toilet_imp = .

* Improved sanitation (JMP)
replace toilet_imp = 1 if inlist(hv205, ///
    11,12,13,14,15, /// flush toilets
    21,22, /// ventilated improved pit / pit latrine with slab
    41,42) /// composting toilet with slab / biogas attached toilet

* Unimproved sanitation / no facility (JMP)
replace toilet_imp = 0 if inlist(hv205, ///
    31,32,33,34, /// pit latrine without slab / open pit
    96) /// no facility / bush / field

label define toiletlbl 0 "Unimproved/no facility" 1 "Improved"
label values toilet_imp toiletlbl

* Check recode
tab toilet_imp









tab hv105
tab hv102


*==================================================
* STEP 1: Keep living children under five
*==================================================
* hv105 = age in completed years
keep if hv105 < 5

* keep only de jure household members
keep if hv102 == 1


*==================================================
* STEP 2: Keep ECE-eligible age group (3–4 years)
*==================================================
keep if hv105 >= 3 & hv105 <= 4


*==================================================
* STEP 3: Create ECE outcome variable from hv121
* hv121: 0 = no, 2 = attended at some time
*==================================================
gen ECE = .
replace ECE = 1 if hv121 == 2
replace ECE = 0 if hv121 == 0
label define ECElbl 0 "No" 1 "Yes"
label values ECE ECElbl

tab ECE





*==================================================
* STEP 4: Recode WASH variables using JMP definitions
*==================================================

*--------------------------------------------------
* Source of drinking water (JMP: Improved vs Unimproved)
*--------------------------------------------------
gen water_imp = .

* Improved water sources (JMP)
replace water_imp = 1 if inlist(hv201, ///
    11,12,13,14, /// piped water
    21, /// tube well or borehole
    31, /// protected well
    41, /// protected spring
    51) /// rainwater

* Unimproved water sources (JMP)
replace water_imp = 0 if inlist(hv201, ///
    32, /// unprotected well
    42, /// unprotected spring
    43, /// surface water
    61, /// tanker truck
    71, /// bottled water
    96) /// other

label define waterlbl 0 "Unimproved" 1 "Improved"
label values water_imp waterlbl


*--------------------------------------------------
* Treatment of household drinking water
*--------------------------------------------------
gen water_treat = .
replace water_treat = 1 if hv237 == 1
replace water_treat = 0 if hv237 == 0
label define treatlbl 0 "No" 1 "Yes"
label values water_treat treatlbl






*--------------------------------------------------
* Handwashing facility (JMP: Basic vs Limited)
* Basic = water available at observed handwashing place
*--------------------------------------------------
gen handwash_basic = .
replace handwash_basic = 1 if hv230b == 1
replace handwash_basic = 0 if hv230b == 0
label define hwlbl 0 "Limited" 1 "Basic"
label values handwash_basic hwlbl


*--------------------------------------------------
* Handwashing place (Fixed vs Mobile)
*--------------------------------------------------
gen handwash_place = .
replace handwash_place = 1 if inlist(hv230a,1,6)   // fixed place
replace handwash_place = 0 if hv230a == 2          // mobile place
label define placelbl 0 "Mobile" 1 "Fixed"
label values handwash_place placelbl



*--------------------------------------------------
* Household Handwashing Environment (Binary)
*--------------------------------------------------
gen handwash_env = . 

* Adequate handwashing = Basic facility AND Fixed place
replace handwash_env = 1 if handwash_basic == 1 & handwash_place == 1

* Limited handwashing = everything else
replace handwash_env = 0 if handwash_env == .

label define hwenvlbl 0 "Limited" 1 "Adequate"
label values handwash_env hwenvlbl

* Check distribution
tab handwash_env



*==================================================
* STEP 5: Keep COMPLETE CASES only
*==================================================
keep if !missing(ECE) ///
    & !missing(water_imp) ///
    & !missing(water_treat) ///
    & !missing(handwash_basic) ///
    & !missing(handwash_place)



	
	
	
*========================================
* Outcome variable
*========================================
tab ECE


*========================================
* WASH variables
*========================================
tab water_imp
tab water_treat
tab handwash_basic
tab handwash_place	
	
	
	
	
	















*-------------------------------
* Household & contextual variables
*-------------------------------
tab hv025 // residence
describe hv025
codebook hv025


*-----------------------------------------------
* Residence: Urban vs Rural
*-----------------------------------------------
gen residence = .
replace residence = 1 if hv025 == 1   // urban
replace residence = 0 if hv025 == 2   // rural

label define reslbl 0 "Rural" 1 "Urban"
label values residence reslbl

* Check
tab residence




tab hv024 // province
describe hv024
codebook hv024





*-----------------------------------------------
* Province / Division
*-----------------------------------------------
gen division = hv024

label define divlbl 1 "Koshi" 2 "Madhesh" 3 "Bagmati" 4 "Gandaki" ///
                  5 "Lumbini" 6 "Karnali" 7 "Sudurpashchim"

label values division divlbl

* Check
tab division











tab hv270 // wealth
describe hv270
codebook hv270



*-----------------------------------------------
* Household wealth index
*-----------------------------------------------
gen wealth = hv270

label define wealthlbl 1 "Poorest" 2 "Poorer" 3 "Middle" 4 "Richer" 5 "Richest"
label values wealth wealthlbl

* Check
tab wealth











tab hv009 // household members
describe hv009
codebook hv009



*-----------------------------------------------
* Household size: <5 vs >=5 members
*-----------------------------------------------
gen hh_size = .
replace hh_size = 0 if hv009 < 5     // Less than 5 members
replace hh_size = 1 if hv009 >= 5    // 5 or more members

label define hhslbl 0 "<5 members" 1 ">=5 members"
label values hh_size hhslbl

* Check
tab hh_size








tab hv219 // sex of household head
describe hv219
codebook hv219



*-----------------------------------------------
* Sex of household head: Male vs Female
*-----------------------------------------------
gen hh_head_sex = .
replace hh_head_sex = 1 if hv219 == 1    // Male
replace hh_head_sex = 0 if hv219 == 2    // Female

label define hhsexlbl 0 "Female" 1 "Male"
label values hh_head_sex hhsexlbl

* Check
tab hh_head_sex






*-------------------------------
* Maternal & child variables
*-------------------------------
/*
tab ha1 // mothers age
describe ha1
codebook ha1
*/


 
tab sh17b1 // mother eucation
describe sh17b1

codebook sh17b1




*-----------------------------------------------
* Mother's education: No education vs Primary (1-5)
*-----------------------------------------------
gen mother_edu = .
replace mother_edu = 0 if sh17b1 == 0    // No education
replace mother_edu = 1 if sh17b1 == 1    // Primary (1-5)

label define motheredulbl 0 "No education" 1 "Primary (1-5)"
label values mother_edu motheredulbl

* Check
tab mother_edu










tab hv104 // sex of children
describe hv104
codebook hv104





*-----------------------------------------------
* Child sex: Male vs Female
*-----------------------------------------------
gen child_sex = .
replace child_sex = 1 if hv104 == 1    // Male
replace child_sex = 0 if hv104 == 2    // Female

label define childsexlbl 0 "Female" 1 "Male"
label values child_sex childsexlbl

* Check
tab child_sex







tab hc64 // birth order
describe hc64
codebook hc64

*-----------------------------------------------
* Birth order: 1, 2-3, 4+
*-----------------------------------------------
gen birth_order_cat = .
replace birth_order_cat = 1 if hc64 == 1
replace birth_order_cat = 2 if inlist(hc64, 2, 3)
replace birth_order_cat = 3 if hc64 >= 4

label define birthorderlbl3 1 "1" 2 "2-3" 3 "4+"
label values birth_order_cat birthorderlbl3

* Check
tab birth_order_cat




tab hv243a // mobile
describe hv243a
codebook hv243a


tab hv208 // television
describe hv208
codebook hv208






*-----------------------------------------------
* Mass media access: mobile or television
*-----------------------------------------------
gen media_access = .
replace media_access = 1 if hv243a == 1 | hv208 == 1
replace media_access = 0 if hv243a == 0 & hv208 == 0

label define medialbl 0 "No access" 1 "Has access"
label values media_access medialbl

* Check
tab media_access






keep hv021 hv022 hv121 hv005 media_access birth_order_cat child_sex mother_edu hh_head_sex hh_size wealth division residence water_imp water_treat handwash_env handwash_basic  handwash_place	 ECE



* Save dataset to your desired path
save "D:\Research\BDHS Research\Nepal\Child\Data\BDHS_Nepal_Child_Clean.dta", replace

