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
save "`CCRX'_SOIPrep_SDP_vargen.dta", replace

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
	
save `temp', replace

******************************************************************************************************************
* 1.Backgroun Characteristics
****************************************************************************************************************** 
use `temp', replace

rename region region_soi

foreach var in all facility_type_soi ur beds_cat sector12 region_soi fp_offered {
	preserve
	
	collapse (count) one, by(`var')
	egen sum=sum(one)
	gen percent_`var'=(one/sum)*100
	gen count_`var'=one
	drop one
	drop sum	
	
	tempfile temp2
	save `temp2', replace
	
	use "`CCRX'_SOIPrep_SDP_vargen.dta"
	append using `temp2'
	save "`CCRX'_SOIPrep_SDP_vargen.dta", replace
	restore
	}
	
*Combine into one variable
preserve
	use "`CCRX'_SOIPrep_SDP_vargen.dta", clear
		gen percent_of_total=.
		gen SDP_count=.
	foreach var in all facility_type_soi beds sector12 region_soi fp_offered {
		replace percent_of_total=percent_`var' if percent_`var'!=.
		replace SDP_count=count_`var' if count_`var'!=.
		}
	save "`CCRX'_SOIPrep_SDP_vargen.dta", replace
restore


******************************************************************************************************************
* 2a. Public Facilities Offering FP: 
*		SOI Table 1 -- Fees
*		SOI Table 4 -- Contraceptive stock-outs, by method
****************************************************************************************************************** 

use `temp', replace

rename region region_soi

foreach var in all facility_type_soi beds_cat {
	preserve

	keep if fp_offered==1
	keep if sector12==1

	collapse (mean) fees_public=fees_rw ///
					stockout_3mo_now_pills_public=stockout_3mo_now_pills ///
					stockout_3mo_now_dmpa_public=stockout_3mo_now_dmpa ///
					stockout_3mo_now_dmpasc_public=stockout_3mo_now_dmpasc ///
					stockout_3mo_now_iud_public=stockout_3mo_now_iud ///
					stockout_3mo_now_impla_public=stockout_3mo_now_implants ///
					stockout_3mo_now_maleco_public=stockout_3mo_now_male_condoms ///
					stockout_3mo_now_ec_public=stockout_3mo_now_ec, by(`var')
		
	replace fees_public=fees_public*100
	replace stockout_3mo_now_pills_public=stockout_3mo_now_pills_public*100
	replace stockout_3mo_now_dmpa_public=stockout_3mo_now_dmpa_public*100 
	replace stockout_3mo_now_dmpasc_public=stockout_3mo_now_dmpasc_public*100
	replace stockout_3mo_now_iud_public=stockout_3mo_now_iud_public*100
	replace stockout_3mo_now_impla_public=stockout_3mo_now_impla_public*100
	replace stockout_3mo_now_maleco_public=stockout_3mo_now_maleco_public*100
	replace stockout_3mo_now_ec_public=stockout_3mo_now_ec_public*100 
		
	tempfile temp2
	save `temp2', replace

	use "`CCRX'_SOIPrep_SDP_vargen.dta"
	append using `temp2'
	save "`CCRX'_SOIPrep_SDP_vargen.dta", replace
	restore
	
	*Generate Denominators
	preserve
	
	keep if fp_offered==1
	keep if sector12==1
	
	collapse (count) d_fees_public=fees_rw ///
					 d_stockout_3mo_now_pills_public=stockout_3mo_now_pills ///
					 d_stockout_3mo_now_dmpa_public=stockout_3mo_now_dmpa ///
					 d_stockout_3mo_now_dmpasc_public=stockout_3mo_now_dmpasc ///
					 d_stockout_3mo_now_iud_public=stockout_3mo_now_iud ///
					 d_stockout_3mo_now_impla_public=stockout_3mo_now_implant ///
					 d_stockout_3mo_now_maleco_public=stockout_3mo_now_male_condoms ///
					 d_stockout_3mo_now_ec_public=stockout_3mo_now_ec, by(`var')
	
	tempfile temp2
	save `temp2', replace
	
	use "`CCRX'_SOIPrep_SDP_vargen.dta"
	append using `temp2'
	save "`CCRX'_SOIPrep_SDP_vargen.dta", replace
	restore
	}
*

******************************************************************************************************************
* 1b. Private Facilities Offering FP:
*		SOI Table 1 -- Fees
*		SOI Table 4 -- Contraceptive stock-outs, by method
****************************************************************************************************************** 

use `temp', replace

rename region region_soi

foreach var in all facility_type_soi beds_cat {
	preserve

	keep if fp_offered==1
	keep if sector12==2

	collapse (mean) fees_priv=fees_rw ///
					stockout_3mo_now_pills_priv=stockout_3mo_now_pills ///
					stockout_3mo_now_dmpa_priv=stockout_3mo_now_dmpa ///
					stockout_3mo_now_dmpasc_priv=stockout_3mo_now_dmpasc ///
					stockout_3mo_now_iud_priv=stockout_3mo_now_iud ///
					stockout_3mo_now_impla_priv=stockout_3mo_now_implants ///
					stockout_3mo_now_maleco_priv=stockout_3mo_now_male_condoms ///
					stockout_3mo_now_ec_priv=stockout_3mo_now_ec, by(`var')
		
	replace fees_priv=fees_priv*100
	replace stockout_3mo_now_pills_priv=stockout_3mo_now_pills_priv*100
	replace stockout_3mo_now_dmpa_priv=stockout_3mo_now_dmpa_priv*100 
	replace stockout_3mo_now_dmpasc_priv=stockout_3mo_now_dmpasc_priv*100 	
	replace stockout_3mo_now_iud_priv=stockout_3mo_now_iud_priv*100
	replace stockout_3mo_now_impla_priv=stockout_3mo_now_impla_priv*100
	replace stockout_3mo_now_maleco_priv=stockout_3mo_now_maleco_priv*100
	replace stockout_3mo_now_ec_priv=stockout_3mo_now_ec_priv*100 
		
	tempfile temp2
	save `temp2', replace

	use "`CCRX'_SOIPrep_SDP_vargen.dta", replace
	append using `temp2'
	save "`CCRX'_SOIPrep_SDP_vargen.dta", replace
	restore
	
	*Generate Denominators
	preserve

	keep if fp_offered==1
	keep if sector12==2	
	
	collapse (count) d_fees_priv=fees_rw ///
					 d_stockout_3mo_now_pills_priv=stockout_3mo_now_pills ///
					 d_stockout_3mo_now_dmpa_priv=stockout_3mo_now_dmpa ///
					 d_stockout_3mo_now_dmpasc_priv=stockout_3mo_now_dmpasc ///
					 d_stockout_3mo_now_iud_priv=stockout_3mo_now_iud ///
					 d_stockout_3mo_now_impla_priv=stockout_3mo_now_implants ///
					 d_stockout_3mo_now_maleco_priv=stockout_3mo_now_male_condoms ///
					 d_stockout_3mo_now_ec_priv=stockout_3mo_now_ec, by(`var')
					
	tempfile temp2
	save `temp2', replace
	
	use "`CCRX'_SOIPrep_SDP_vargen.dta", replace
	append using `temp2'
	save "`CCRX'_SOIPrep_SDP_vargen.dta", replace
	restore
	}
*

******************************************************************************************************************
* 2a. Public Facility (Regardless of Offering FP): 
*		SOI Table 2 -- 3 or more methods & 5 or more methods
*		SOI Table 3 -- Availability of modern contraception, by method
****************************************************************************************************************** 

use `temp', replace

rename region region_soi
	
foreach var in all facility_type_soi beds_cat {
	preserve

	keep if sector12==1

	recode provided_pills .=0
	recode provided_dmpa .=0
	recode provided_dmpasc .=0
	recode provided_iud .=0
	recode provided_implants .=0
	recode provided_male_condoms .=0
	recode provided_female_ster .=0
	recode provided_ec .=0

	collapse (mean) threshold_3_public=threshold_3 threshold_5_public=threshold_5 ///
					provided_pills_public=provided_pills ///
					provided_dmpa_public=provided_dmpa ///
					provided_dmpasc_public=provided_dmpasc ///
					provided_iud_public=provided_iud ///
					provided_implants_public=provided_implants ///
					provided_male_condoms_public=provided_male_condoms ///
					provided_female_ster_public=provided_female_ster ///
					provided_ec_public=provided_ec, by(`var')
		
	*Methods
	replace threshold_3_public=threshold_3_public*100 
	replace threshold_5_public=threshold_5_public*100 
	replace provided_pills_public=provided_pills_public*100 
	replace provided_dmpa_public=provided_dmpa_public*100
	replace provided_dmpasc_public=provided_dmpasc_public*100
	replace provided_iud_public=provided_iud_public*100
	replace provided_implants_public=provided_implants_public*100
	replace provided_male_condoms_public=provided_male_condoms_public*100 
	replace provided_female_ster_public=provided_female_ster_public*100 
	replace provided_ec_public=provided_ec_public*100
		
	tempfile temp2
	save `temp2', replace

	use "`CCRX'_SOIPrep_SDP_vargen.dta", replace
	append using `temp2'
	save "`CCRX'_SOIPrep_SDP_vargen.dta", replace
	restore
	
	*Generate Denominators
	preserve
	
	keep if sector12==1	
	
	collapse (count) d_threshold_3_public=threshold_3 d_threshold_5_public=threshold_5 ///
					 d_provided_pills_public=provided_pills ///
					 d_provided_dmpa_public=provided_dmpa ///
					 d_provided_dmpasc_public=provided_dmpasc ///
					 d_provided_iud_public=provided_iud ///
					 d_provided_implants_public=provided_implants ///
					 d_provided_male_condoms_public=provided_male_condoms ///
					 d_provided_female_ster_public=provided_female_ster ///
					 d_provided_ec_public=provided_ec, by(`var')
					 
	tempfile temp2
	save `temp2', replace

	use "`CCRX'_SOIPrep_SDP_vargen.dta", replace
	append using `temp2'
	save "`CCRX'_SOIPrep_SDP_vargen.dta", replace
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

rename region region_soi

foreach var in all facility_type_soi beds_cat {
	preserve

	keep if sector12==2

	recode provided_pills .=0
	recode provided_dmpa .=0
	recode provided_dmpasc .=0
	recode provided_iud .=0
	recode provided_implants .=0
	recode provided_male_condoms .=0
	recode provided_female_ster .=0
	recode provided_ec .=0

	collapse (mean) threshold_3_private=threshold_3 threshold_5_private=threshold_5 ///
					provided_pills_private=provided_pills ///
					provided_dmpa_private=provided_dmpa ///
					provided_dmpasc_private=provided_dmpasc ///
					provided_iud_private=provided_iud ///
					provided_implants_private=provided_implants ///
					provided_male_condoms_private=provided_male_condoms ///
					provided_female_ster_private=provided_female_ster ///
					provided_ec_private=provided_ec, by(`var')

	*Methods
	replace threshold_3_private=threshold_3_private*100 
	replace threshold_5_private=threshold_5_private*100 
	replace provided_pills_private=provided_pills_private*100 
	replace provided_dmpa_private=provided_dmpa_private*100
	replace provided_dmpasc_private=provided_dmpasc_private*100
	replace provided_iud_private=provided_iud_private*100
	replace provided_implants_private=provided_implants_private*100
	replace provided_male_condoms_private=provided_male_condoms_private*100 
	replace provided_female_ster_private=provided_female_ster_private*100 
	replace provided_ec_private=provided_ec_private*100
		
	tempfile temp2
	save `temp2', replace

	use "`CCRX'_SOIPrep_SDP_vargen.dta", replace
	append using `temp2'
	save "`CCRX'_SOIPrep_SDP_vargen.dta", replace
	restore
	
	*Generate Denominators
	preserve
	
	keep if sector12==2	
	
	collapse (count) d_threshold_3_private=threshold_3 d_threshold_5_private=threshold_5 ///
					 d_provided_pills_private=provided_pills ///
					 d_provided_dmpa_private=provided_dmpa ///
					 d_provided_dmpasc_private=provided_dmpasc ///
					 d_provided_iud_private=provided_iud ///
					 d_provided_implants_private=provided_implants ///
					 d_provided_male_condoms_private=provided_male_condoms ///
					 d_provided_female_ster_private=provided_female_ster ///
					 d_provided_ec_private=provided_ec, by(`var')	
					 
	tempfile temp2
	save `temp2', replace

	use "`CCRX'_SOIPrep_SDP_vargen.dta", replace
	append using `temp2'
	save "`CCRX'_SOIPrep_SDP_vargen.dta", replace
	restore
	}
* 

******************************************************************************************************************
* 3a. All facilities (public and private combined)
*		SOI Table 5 -- Visits, by method
****************************************************************************************************************** 

use `temp', replace

rename region region_soi

foreach method in female_ster male_ster ///
	dmpa_total dmpa_new  ///
	dmpasc_total dmpasc_new ///
	iud_total iud_new  ///
	implants_total implants_new  ///
	male_condoms_total male_condoms_new  ///
	pills_total pills_new  ///
	ec_total ec_new {
 
	foreach var in all facility_type_soi beds_cat sector12 {

		levelsof `var', local(levels)
		foreach l of local levels {
			preserve

			keep if visits_`method'>=0 
			collapse(sum) visits_`method' if `var' == `l'

			gen Category="`var'_`l'"

			tempfile temp2
			save `temp2', replace

			use "`CCRX'_SOIPrep_SDP_vargen.dta", replace
			append using `temp2'
			save "`CCRX'_SOIPrep_SDP_vargen.dta", replace
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

	use "`CCRX'_SOIPrep_SDP_vargen.dta", replace
	append using `temp2'
	save "`CCRX'_SOIPrep_SDP_vargen.dta", replace
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

	use "`CCRX'_SOIPrep_SDP_vargen.dta", replace
	append using `temp2'
	save "`CCRX'_SOIPrep_SDP_vargen.dta", replace
	restore
	}
