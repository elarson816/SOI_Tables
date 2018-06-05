/******************************************************************************************************************
SOI TABLES VARIABLE/INDICATOR GENERATION FILE

Set up dataset - Generate variables needed for analysis
******************************************************************************************************************/

* Section 1. Set up dataset: generate variables needed to analysis
cd "$datadir"
tempfile temp
save `temp', replace
use `temp', replace

*Country Code
local CCRX $CCRX
local country $country
local round $round
local today $today
local date $date

*Save country dataset as temp dataset 
tempfile temp
save `temp', replace

*Create blank dataset
clear
gen Country="`country'"
save "`CCRX'_SDP_DataViz.dta", replace

*Go back to temp dataset
use `temp', replace

*Generate county/ round variable
gen CCRX="`CCRX'"

*Generate correct "Category" variables
gen all=1
gen count=1

*Rename or generate neccessary variables
capture rename county region
capture replace region=geography if country=="Ethiopia"
*gen region=1 if country=="Nigeria_`state'" | country=="Nigeria_Kaduna" | country=="Nigeria_Lagos" | country=="Nigeria"
capture replace facility_type=facility_type_soi if country=="Indonesia" | country=="Nigeria_`state'" | country=="Nigeria_Kaduna" | country=="Nigeria_Lagos" | country=="Nigeria" | country=="Burkina"
*replace facility_type_soi=. if facility_type_soi==96

*For all calculations: 
keep if SDP_result==1
recode fees -99=0
	
save `temp', replace

******************************************************************************************************************
* 1a. Public Facilities Offering FP: 
*		SOI Table 1 -- Fees
*		SOI Table 4 -- Contraceptive stock-outs, by method
****************************************************************************************************************** 

use `temp', replace

foreach var in all facility_type_soi ur beds_cat {
preserve

keep if fp_offered==1
keep if sector12==1

collapse (mean) fees_public=fees ///
stockout_3mo_now_pills_public=stockout_3mo_now_pills ///
stockout_3mo_now_inject_public=stockout_3mo_now_injectables ///
stockout_3mo_now_iud_public=stockout_3mo_now_iud ///
stockout_3mo_now_impla_public=stockout_3mo_now_implants ///
stockout_3mo_now_maleco_public=stockout_3mo_now_male_condoms ///
stockout_3mo_now_ec_public=stockout_3mo_now_ec, by(`var')
	*stockout_3mo_now_sayana_public=stockout_3mo_now_sayana_press ///
	*stockout_3mo_now_depo_public=stockout_3mo_now_depo_provera ///
	
replace fees_public=fees_public*100
replace stockout_3mo_now_pills_public=stockout_3mo_now_pills_public*100
replace stockout_3mo_now_inject_public=stockout_3mo_now_inject_public*100 
replace stockout_3mo_now_iud_public=stockout_3mo_now_iud_public*100
replace stockout_3mo_now_impla_public=stockout_3mo_now_impla_public*100
replace stockout_3mo_now_maleco_public=stockout_3mo_now_maleco_public*100
replace stockout_3mo_now_ec_public=stockout_3mo_now_ec_public*100 
	*capture replace stockout_3mo_now_sayana_public=stockout_3mo_now_sayana_public*100
	*capture replace stockout_3mo_now_depo_public=stockout_3mo_now_depo_public*100
	
tempfile temp2
save `temp2', replace

use "`CCRX'_SDP_DataViz.dta"
append using `temp2'
save "`CCRX'_SDP_DataViz.dta", replace
restore
}
*

******************************************************************************************************************
* 1b. Private Facilities Offering FP:
*		SOI Table 1 -- Fees
*		SOI Table 4 -- Contraceptive stock-outs, by method
****************************************************************************************************************** 

use `temp', replace

foreach var in all facility_type_soi ur beds_cat {
preserve

keep if fp_offered==1
keep if sector12==2

collapse (mean) fees_private=fees ///
stockout_3mo_now_pills_private=stockout_3mo_now_pills ///
stockout_3mo_now_inject_private=stockout_3mo_now_injectables ///
stockout_3mo_now_iud_private=stockout_3mo_now_iud ///
stockout_3mo_now_impla_private=stockout_3mo_now_implants ///
stockout_3mo_now_maleco_private=stockout_3mo_now_male_condoms ///
stockout_3mo_now_ec_private=stockout_3mo_now_ec, by(`var')
	*stockout_3mo_now_sayana_private=stockout_3mo_now_sayana_press ///
	*stockout_3mo_now_depo_private=stockout_3mo_now_depo_provera ///
	
replace fees_private=fees_private*100
replace stockout_3mo_now_pills_private=stockout_3mo_now_pills_private*100
replace stockout_3mo_now_inject_private=stockout_3mo_now_inject_private*100 
replace stockout_3mo_now_iud_private=stockout_3mo_now_iud_private*100
replace stockout_3mo_now_impla_private=stockout_3mo_now_impla_private*100
replace stockout_3mo_now_maleco_private=stockout_3mo_now_maleco_private*100
replace stockout_3mo_now_ec_private=stockout_3mo_now_ec_private*100 
	*capture replace stockout_3mo_now_sayana_private=stockout_3mo_now_sayana_private*100
	*capture replace stockout_3mo_now_depo_private=stockout_3mo_now_depo_private*100
	
tempfile temp2
save `temp2', replace

use "`CCRX'_SDP_DataViz.dta", replace
append using `temp2'
save "`CCRX'_SDP_DataViz.dta", replace
restore
}
*

******************************************************************************************************************
* 2a. Public Facility (Regardless of Offering FP): 
*		SOI Table 2 -- 3 or more methods & 5 or more methods
*		SOI Table 3 -- Availability of modern contraception, by method
****************************************************************************************************************** 

use `temp', replace
	
foreach var in all facility_type_soi ur beds_cat {
preserve

keep if sector12==1

recode provided_pills .=0
recode provided_injectables .=0
	*capture recode provided_sayana_press .=0
	*capture recode provided_depo_provera .=0
recode provided_iud .=0
recode provided_implants .=0
recode provided_male_condoms .=0
recode provided_female_ster .=0
recode provided_ec .=0

collapse (mean) threshold_3_public=threshold_3 threshold_5_public=threshold_5 ///
provided_pills_public=provided_pills ///
provided_injectables_public=provided_injectables ///
provided_iud_public=provided_iud ///
provided_implants_public=provided_implants ///
provided_male_condoms_public=provided_male_condoms ///
provided_female_ster_public=provided_female_ster ///
provided_ec_public=provided_ec, by(`var')
	*provided_sayana_press_public=provided_sayana_press ///
	*provided_depo_provera_public=provided_depo_provera ///
	
*Methods
replace threshold_3_public=threshold_3_public*100 
replace threshold_5_public=threshold_5_public*100 
replace provided_pills_public=provided_pills_public*100 
replace provided_injectables_public=provided_injectables_public*100
replace provided_iud_public=provided_iud_public*100
replace provided_implants_public=provided_implants_public*100
replace provided_male_condoms_public=provided_male_condoms_public*100 
replace provided_female_ster_public=provided_female_ster_public*100 
replace provided_ec_public=provided_ec_public*100
	*capture replace provided_sayana_press_public=provided_sayana_press*100
	*capture replace provided_depo_provera_public=provided_depo_provera*100
	
tempfile temp2
save `temp2', replace

use "`CCRX'_SDP_DataViz.dta", replace
append using `temp2'
save "`CCRX'_SDP_DataViz.dta", replace
restore
}
* 

use `temp', replace

******************************************************************************************************************
* 2b. Private Facility (Regardless of Offering FP):
*		SOI Table 2 -- 3 or more methods & 5 or more methods
*		SOI Table 3 -- Availability of modern contraception, by method
******************************************************************************************************************

use `temp', replace

foreach var in all facility_type_soi ur beds_cat {
preserve

keep if sector12==2

recode provided_pills .=0
recode provided_injectables .=0
	*capture recode provided_sayana_press .=0
	*capture recode provided_depo_provera .=0
recode provided_iud .=0
recode provided_implants .=0
recode provided_male_condoms .=0
recode provided_female_ster .=0
recode provided_ec .=0

collapse (mean) threshold_3_private=threshold_3 threshold_5_private=threshold_5 ///
provided_pills_private=provided_pills ///
provided_injectables_private=provided_injectables ///
provided_iud_private=provided_iud ///
provided_implants_private=provided_implants ///
provided_male_condoms_private=provided_male_condoms ///
provided_female_ster_private=provided_female_ster ///
provided_ec_private=provided_ec, by(`var')
	*provided_sayana_press_private=provided_sayana_press ///
	*provided_depo_provera_private=provided_depo_provera ///
	
*Methods
replace threshold_3_private=threshold_3_private*100 
replace threshold_5_private=threshold_5_private*100 
replace provided_pills_private=provided_pills_private*100 
replace provided_injectables_private=provided_injectables_private*100
replace provided_iud_private=provided_iud_private*100
replace provided_implants_private=provided_implants_private*100
replace provided_male_condoms_private=provided_male_condoms_private*100 
replace provided_female_ster_private=provided_female_ster_private*100 
replace provided_ec_private=provided_ec_private*100
	*capture replace provided_sayana_press_private=provided_sayana_press*100
	*capture replace provided_depo_provera_private=provided_depo_provera*100
	
tempfile temp2
save `temp2', replace

use "`CCRX'_SDP_DataViz.dta", replace
append using `temp2'
save "`CCRX'_SDP_DataViz.dta", replace
restore
}
* 

******************************************************************************************************************
* 3a. All facilities (public and private combined)
*		SOI Table 5 -- Visits, by method
****************************************************************************************************************** 

use `temp', replace

foreach method in female_ster male_ster ///
injectables_total injectables_new  ///
iud_total iud_new  ///
implants_total implants_new  ///
male_condoms_total male_condoms_new  ///
pills_total pills_new  ///
ec_total ec_new {
 
foreach var in all facility_type_soi ur beds_cat sector12 {

levelsof `var', local(levels)
foreach l of local levels {
preserve

keep if visits_`method'>=0 
collapse(sum) visits_`method' if `var' == `l'

gen Category="`var'_`l'"

tempfile temp2
save `temp2', replace

use "`CCRX'_SDP_DataViz.dta", replace
append using `temp2'
save "`CCRX'_SDP_DataViz.dta", replace
restore
}
}
}
*

******************************************************************************************************************
* 4a. All facilities (public and private combined)
*		SOI Table 6-- Characteristics of health facilities (Number) 
****************************************************************************************************************** 

use `temp', replace

rename region region_soi

foreach var in all facility_type_soi ur beds_cat sector12 region_soi fp_offered {
preserve

collapse (count) one_number=one, by(`var')

tempfile temp2
save `temp2', replace

use "`CCRX'_SDP_DataViz.dta", replace
append using `temp2'
save "`CCRX'_SDP_DataViz.dta", replace
restore
}
*

******************************************************************************************************************
* 4b. All facilities (public and private combined)
*		SOI Table 6-- Characteristics of health facilities (Percentage) 
****************************************************************************************************************** 

use `temp', replace

rename region region_soi

foreach var in all facility_type_soi ur beds_cat sector12 region_soi fp_offered {
preserve

collapse (percent) one_percentage=one, by(`var')

tempfile temp2
save `temp2', replace

use "`CCRX'_SDP_DataViz.dta", replace
append using `temp2'
save "`CCRX'_SDP_DataViz.dta", replace
restore
}
