
*Instructions
	* Section 1. Read in dataset: find country & set round macro
	* Do file 3. To add a country, follow instructions in do file 3

clear
local datadir "~/Dropbox (Gates Institute)/PMADataManagement_All/DataVisualization/Data Lab Datasets/Datasets_wide format/HHQFQ Datasets"
cd "~/Dropbox (Gates Institute)/PMADataManagement_All/DataVisualization/Data Lab Datasets/Datasets_API format/HHQFQ Datasets"

********************************************************************************
* Section 1. Read in dataset
********************************************************************************

/*****Burkina
local round 4
use "`datadir'/BFR`round'_DataViz.dta"
local CCRX "BFR`round'"
*/
/*****DRC
local round 5
local province Kinshasa
use "`datadir'/CDR`round'_`province'_DataViz.dta"
local CCRX "CDR`round'_`province'"
*/
/*****Ethiopia
local round 4
use "`datadir'/ETR`round'_DataViz.dta"
local CCRX "ETR`round'"
*/
/*****Ghana
local round 5
use "`datadir'/GHR`round'_DataViz.dta"
local CCRX "GHR`round'"
*/
*****India
local round 2
use "`datadir'/INR`round'_Rajasthan_DataViz.dta"
local CCRX "INR`round'_Rajasthan"
*/
/*****Indonesia
local round 1
use "`datadir'/IDR`round'_DataViz.dta"
local CCRX "IDR`round'"
*/
/*****Kenya
local round 5
use "`datadir'/KER`round'_DataViz.dta"
local CCRX "KER`round'"
*/
/*****Niger
local round 2
*use "`datadir'/NER`round'_Niamey_DataViz.dta"
*local CCRX "NER`round'_Niamey"
use "`datadir'/NER`round'_DataViz.dta"
local CCRX "NER`round'"
*/
/*****Nigeria
local round 3
local state "Taraba"
*use "`datadir'/NGR`round'_DataViz.dta"
use "`datadir'/NGR`round'_`state'_DataViz.dta"
*local CCRX "NGR`round'"
local CCRX "NGR`round'_`state'"
*/
/*****Uganda
local round 4
use "`datadir'/UGR`round'_DataViz.dta"
local CCRX "UGR`round'"
*/

********************************************************************************
* Section 2. Foramt CCRX datasets to match Data Lab API
********************************************************************************

*Generate survey_code
do "~/Dropbox (Gates Institute)/PMADataManagement_All/DataVisualization/API do files/3. Country codes and cleaning.do"

*All
order survey_code, first
rename Category char1_code

*Drop variables not needed in data tab
drop Country Round Date 

********************************************************************************
* Section 3. Create method mix vars
********************************************************************************

* Gernate blanks
capture drop methodmix*
gen methodmix_allw_modernm=.
gen methodmix_marw_modernm=.
gen methodmix_allw_anym=.
gen methodmix_marw_anym=.
gen methodmix_allw_plusnon=.
gen methodmix_marw_plusnon=.

* A. Fill in values for method mix among ALL USERS (all & married)
foreach var in modern all non {
foreach Category in ster implant IUD injectables pill condom other_modern traditional {
local obs=_N+1
set obs `obs'
replace Grouping="Method mix_`var'" if Grouping==""
replace char1_code="`Category'_`var'" if char1_code==""
replace methodmix_allw_anym = `Category'_all[1] if char1_code=="`Category'_`var'"
replace methodmix_marw_anym = `Category'_mar[1] if char1_code=="`Category'_`var'"
replace methodmix_allw_modernm = `Category'_all[1] if char1_code=="`Category'_`var'"
replace methodmix_marw_modernm = `Category'_mar[1] if char1_code=="`Category'_`var'"
replace methodmix_allw_plusnon = `Category'_all[1] if char1_code=="`Category'_`var'"
replace methodmix_marw_plusnon = `Category'_mar[1] if char1_code=="`Category'_`var'"
}
}

* Drop non-sensical values
drop if Grouping=="Method mix_modern" & char1_code=="traditional_modern"
replace methodmix_allw_modernm=. if Grouping=="Method mix_all" | Grouping=="Method mix_non"
replace methodmix_marw_modernm=. if Grouping=="Method mix_all" | Grouping=="Method mix_non" 
replace methodmix_allw_anym=. if Grouping=="Method mix_modern" | Grouping=="Method mix_non"
replace methodmix_marw_anym=. if Grouping=="Method mix_modern" | Grouping=="Method mix_non"
replace methodmix_allw_plusnon=. if Grouping=="Method mix_all" | Grouping=="Method mix_modern" 
replace methodmix_marw_plusnon=. if Grouping=="Method mix_all" | Grouping=="Method mix_modern" 

* B. Fill in value for method mix among MODERN USERS (all & married)
egen modern_all = total(methodmix_allw_modernm)
egen modern_mar = total(methodmix_marw_modernm)
foreach Category in ster implant IUD injectables pill condom other_modern {
replace methodmix_allw_modernm = (methodmix_allw_modernm/modern_all) * 100 if char1_code=="`Category'_modern"
replace methodmix_marw_modernm = (methodmix_marw_modernm/modern_mar) * 100 if char1_code=="`Category'_modern"
}

* C. Fill in value for method mix among ALL WOMEN (all & married)
gen cp_all1 = cp_all
gen cp_mar1 = cp_mar
destring cp_all1 cp_mar1, replace
foreach Category in ster implant IUD injectables pill condom other_modern traditional {
replace methodmix_allw_plusnon = (methodmix_allw_plusnon/100) * cp_all1[1] if char1_code=="`Category'_non"
replace methodmix_marw_plusnon = (methodmix_marw_plusnon/100) * cp_mar1[1] if char1_code=="`Category'_non"
}
local obs=_N+1
set obs `obs'
replace Grouping="Method mix_non" if Grouping==""
replace char1_code="Non-user" if char1_code==""
replace methodmix_allw_plusnon = 100 - cp_all1[1] if char1_code=="Non-user"
replace methodmix_marw_plusnon = 100 - cp_mar1[1] if char1_code=="Non-user"

*Clean up
drop cp_all1 cp_mar1 modern_all modern_mar
replace survey_code=survey_code[1] if survey_code==""

/*
replace cp_all=methodmix_allw_anym if cp_all==. & methodmix_allw_anym!=.
replace cp_mar=methodmix_marw_anym if cp_mar==. & methodmix_marw_anym!=.
replace cp_all=methodmix_allw_plusnon if cp_all==. & methodmix_allw_plusnon!=.
replace cp_mar=methodmix_marw_plusnon if cp_mar==. & methodmix_marw_plusnon!=.
replace mcp_all=methodmix_allw_modernm if mcp_all==. & methodmix_allw_modernm!=.
replace mcp_mar=methodmix_marw_modernm if mcp_mar==. & methodmix_marw_modernm!=.

drop methodmix_allw_modernm methodmix_marw_modernm methodmix_allw_anym methodmix_marw_anym methodmix_allw_plusnon methodmix_marw_plusnon

foreach var in modern all non {
replace char1_code="Sterilization" if char1_code=="ster_`var'"
replace char1_code="Implants" if char1_code=="implant_`var'"
replace char1_code="IUD" if char1_code=="IUD_`var'"
replace char1_code="Injectables" if char1_code=="injectables_`var'"
replace char1_code="Pill" if char1_code=="pill_`var'"
replace char1_code="Condom" if char1_code=="condom_`var'"
replace char1_code="Other modern methods" if char1_code=="other_modern_`var'"
replace char1_code="Traditional methods" if char1_code=="traditional_`var'"
}
*/

replace Grouping="Method type (All methods)" if Grouping=="Method mix_all"
replace Grouping="Method type (Modern methods)" if Grouping=="Method mix_modern"
replace Grouping="Method type (Including non-users)" if Grouping=="Method mix_non" 

********************************************************************************
* Section 4. Reshape data wide to long to match API format
********************************************************************************

rename fp_side_effects_instructions_all fpse_instructions_all
rename fp_side_effects_instructions_mar fpse_instructions_mar

foreach var in cp_all cp_mar mcp_all mcp_mar tcp_all tcp_mar ///
	ster_all implant_all IUD_all injectables_all pill_all condom_all other_modern_all traditional_all ///
	ster_mar implant_mar IUD_mar injectables_mar pill_mar condom_mar other_modern_mar traditional_mar ///
	unmetspace_all unmetlimit_all unmettot_all unmetspace_mar unmetlimit_mar unmettot_mar ///
	totaldemand_all demandsatis_all totaldemand_mar demandsatis_mar ///
	wanted_then_all wanted_later_all wanted_not_all wanted_then_mar wanted_later_mar wanted_not_mar ///
	methodchoice_self_all methodchoice_joint_all methodchoice_other_all ///
	fees_12months_all fees_12months_mar ///
	fp_told_other_methods_all fp_told_other_methods_mar fp_side_effects_all fp_side_effects_mar fpse_instructions_all fpse_instructions_mar ///
	return_to_provider_all refer_to_relative_all returnrefer_dir_all ///
	visited_by_health_worker_all visited_by_health_worker_mar visited_facility_fp_disc_all visited_facility_fp_disc_mar fp_discussion_all fp_discussion_mar ///
	methodmix_allw_modernm methodmix_marw_modernm methodmix_allw_anym methodmix_marw_anym methodmix_allw_plusnon methodmix_marw_plusnon {
rename `var' ind_`var'
}

reshape long ind_, i(char1_code) j(indicator_code) string

rename ind_ value
replace indicator_code="fp_side_effects_instructions_all" if indicator_code=="fpse_instructions_all"
replace indicator_code="fp_side_effects_instructions_mar" if indicator_code=="fpse_instructions_mar"

********************************************************************************
* Section 5. Create the remaining columns to match API format
********************************************************************************

*Replace blanks with "none" for totals
replace char1_code="none" if Grouping=="none"

*Generate remaining columns in data tab
gen lower_ci=""
gen upper_ci=""
gen level_ci=""
gen precision="1"
gen is_total=""
	replace is_total="1" if char1_code=="All"
	replace char1_code="" if char1_code=="All"
gen denom_w=""
gen denom_uw=""
gen char2_code=""

*Order columns to match data tab
order value, first
order lower_ci-denom_uw, after(value)
order char2_code, after(char1_code)
order survey_code, after(char2_code)
order indicator_code, before(char1_code)
gsort indicator_code Grouping char1_code

********************************************************************************
* Section 6. Replace results we don't want to report/ don't make sense to report
********************************************************************************

* Drop data points for all indicators not broken down by method type
foreach var in cp_all cp_mar mcp_all mcp_mar tcp_all tcp_mar ///
ster_all implant_all IUD_all injectables_all pill_all condom_all other_modern_all traditional_all ///
ster_mar implant_mar IUD_mar injectables_mar pill_mar condom_mar other_modern_mar traditional_mar ///
unmetspace_all unmetlimit_all unmettot_all unmetspace_mar unmetlimit_mar unmettot_mar ///
totaldemand_all demandsatis_all totaldemand_mar demandsatis_mar ///
wanted_then_all wanted_later_all wanted_not_all wanted_then_mar wanted_later_mar wanted_not_mar ///
methodchoice_self_all methodchoice_joint_all methodchoice_other_all ///
fees_12months_all fees_12months_mar ///
fp_told_other_methods_all fp_told_other_methods_mar fp_side_effects_all fp_side_effects_mar fp_side_effects_instructions_all fp_side_effects_instructions_mar ///
return_to_provider_all refer_to_relative_all returnrefer_dir_all ///
visited_by_health_worker_all visited_by_health_worker_mar visited_facility_fp_disc_all visited_facility_fp_disc_mar fp_discussion_all fp_discussion_mar {
drop if indicator_code=="`var'" & (Grouping=="Method type (Modern methods)" | Grouping=="Method type (All methods)" | Grouping=="Method type (Including non-users)")
}

* Drop data points for indicators among married women broken down by marital status (does not make sense)
foreach var in cp_mar mcp_mar tcp_mar ///
unmettot_mar unmetspace_mar unmetlimit_mar ///
totaldemand_mar demandsatis_mar ///
visited_by_health_worker_mar visited_facility_fp_disc_mar fp_discussion_mar ///
ster_mar implant_mar IUD_mar injectables_mar pill_mar condom_mar other_modern_mar traditional_mar ///
fees_12months_mar fp_told_other_methods_mar fp_side_effects_mar fp_side_effects_instructions_mar ///
wanted_then_mar wanted_later_mar wanted_not_mar {
drop if indicator_code=="`var'" & Grouping=="marital status"
}

* Drop data points for method mix indicators not broken down by the methods in the mix
foreach var in methodmix_allw_modernm methodmix_marw_modernm {
drop if indicator_code=="`var'" & Grouping!="Method type (Modern methods)"
}
foreach var in methodmix_allw_anym methodmix_marw_anym {
drop if indicator_code=="`var'" & Grouping!="Method type (All methods)"
}
foreach var in methodmix_allw_plusnon methodmix_marw_plusnon {
drop if indicator_code=="`var'" & Grouping!="Method type (Including non-users)"
}

* Drop any data point that is blank (i.e. denominator = 0)
drop if value==.

drop Grouping

********************************************************************************
* Section 7. Save formatted dataset
********************************************************************************

save "`CCRX'_HHQFQ_API.dta", replace


