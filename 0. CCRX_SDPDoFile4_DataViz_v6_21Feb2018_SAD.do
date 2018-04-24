clear
clear matrix
clear mata
capture log close
set more off
numlabel, add


******************************************************************************************************************/
*
*  FILENAME:	CCR#_SDPDoFile4_DataViz_v#_$date_initials.do
*  PURPOSE:		PMA2020 SDP Data Viz Data Set
*  CREATED:		07.10.16 by Tasmia Naz
*  DATA IN:		CCR#_SDP_AnalysisData.dta
*  DATA OUT:	CCR#_SDP_DataViz_$date.dta
*  UPDATES:		
*
******************************************************************************************************************/

/******************************************************************************************************************

INSTRUCTIONS

1. Run this do file on a country/ round:
	Section A: 
		-Update directories
		-Call in dataset (Use CCRX_SDP_AnalysisData in SOI_Table_CHekcing folder) 
		-Set macros
	Section C: Set country-specific Categories for Faciity type and Region Groupings
2. Cross check output with SOI tables

******************************************************************************************************************/
* A. Call in data set & set macros
******************************************************************************************************************

*Sally's directory
local datadir "~/Dropbox (Gates Institute)/SOI_Table_Checking"
*cd "$datadir"
cd "~/Dropbox (Gates Institute)/Gates"

/*BFR1
use "`datadir'/Burkina Faso/Round1/BFR1_SDP_AnalysisData.dta", clear
*Set macros for country and round
local country "Burkina"
local round "Round 1"
local date "2014-12"
local CCRX "BFR1"
rename geography region
*/

/*BFR2
use "`datadir'/Burkina Faso/Round2/BFR2_SDP_AnalysisData.dta", clear
*Set macros for country and round
local country "Burkina"
local round "Round 2"
local date "2015-05"
local CCRX "BFR2"
rename geography region
*/

/*BFR3
use "`datadir'/Burkina Faso/Round3/BFR3_SDP_AnalysisData.dta", clear
*Set macros for country and round
local country "Burkina"
local round "Round 3"
local date "2016-07"
local CCRX "BFR3"
rename geography region
*/

/*CDR2
use "`datadir'/DRC/Round2/CDR2_SDP_AnalysisData.dta", clear
*Set macros for country and round
local country "DRC_Kinshasa"
local round "Round 2"
local date "2014-09"
local CCRX "CDR2_Kinshasa"
*Generate vars=. for CDR2 stock questions (questions not asked)
foreach method in pills injectables iud implants male_condoms ec {
gen stockout_3mo_now_`method'=.
}
gen threshold_3=.
gen threshold_5=.
gen ur=1
gen region=1
*/

/*CDR3
use "`datadir'/DRC/Round3/CDR3_SDP_AnalysisData.dta"
*Set macros for country and round
local country "DRC_Kinshasa"
local round "Round 3"
local date "2015-06"
local CCRX "CDR3_Kinshasa"
gen ur=1
gen region=1
*/

/*CDR4
*use "~/Dropbox (Gates Institute)/Gates/DRC/Round4/CDR4_Kinshasa_SDP_AnalysisData.dta"
use "~/Dropbox (Gates Institute)/Gates/DRC/Round4/CDR4_KongoCentral_SDP_AnalysisData.dta"
*Set macros for country and round
*local country "DRC_Kinshasa"
local country "DRC_KongoCentral"
local round "Round 4"
local date "2016-01"
*local CCRX "CDR4_Kinshasa"
local CCRX "CDR4_KongoCentral"
*/

/*CDR5
use "~/Dropbox (Gates Institute)/Gates/DRC/Round5/CDR5_Kinshasa_SDP_AnalysisData.dta"
*use "~/Dropbox (Gates Institute)/Gates/DRC/Round5/CDR5_KongoCentral_SDP_AnalysisData.dta"
*Set macros for country and round
local country "DRC_Kinshasa"
*local country "DRC_KongoCentral"
local round "Round 5"
local date "2016-09"
local CCRX "CDR5_Kinshasa"
*local CCRX "CDR5_KongoCentral"
*/

/*ETR1
use "`datadir'/Ethiopia/Round1/ETR1_SDP_AnalysisData.dta", clear
*Set macros for country and round
local country "Ethiopia"
local round "Round 1"
local date "2014-03"
local CCRX "ETR1"
*Generate vars=. for KER1 stock questions (questions not asked)
foreach method in pills injectables iud implants male_condoms ec {
gen stockout_3mo_now_`method'=.
}
gen threshold_3=.
gen threshold_5=.
*/

/*ETR2
use "`datadir'/Ethiopia/Round2/ETR2_SDP_AnalysisData.dta", clear
*Set macros for country and round
local country "Ethiopia"
local round "Round 2"
local date "2014-10"
local CCRX "ETR2"
*/

/*ETR3
use "`datadir'/Ethiopia/Round3/ETR3_SDP_AnalysisData.dta", clear
local country "Ethiopia"
local round "Round 3"
local date "2015-05"
local CCRX "ETR3"
*/

/*ETR4
use "`datadir'/Ethiopia/Round4/ETR4_SDP_AnalysisData.dta", clear
local country "Ethiopia"
local round "Round 4"
local date "2016-04"
local CCRX "ETR4"
*/

/*GHR1
use "`datadir'/Ghana/Round1/GHR1_SDP_AnalysisData.dta", clear
*Set macros for country and round
local country "Ghana"
local round "Round 1"
local date "2013-10"
local CCRX "GHR1"
*Generate vars=. for KER1 stock questions (questions not asked)
foreach method in pills injectables iud implants male_condoms ec {
gen stockout_3mo_now_`method'=.
}
gen threshold_3=.
gen threshold_5=.
*/

/*GHR2
use "`datadir'/Ghana/Round2/GHR2_SDP_AnalysisData.dta", clear
*Set macros for country and round
local country "Ghana"
local round "Round 2"
local date "2014-05"
local CCRX "GHR2"
*Generate vars=. for KER1 stock questions (questions not asked)
foreach method in pills injectables iud implants male_condoms ec {
gen stockout_3mo_now_`method'=.
}
gen threshold_3=.
gen threshold_5=.
*/

/*GHR3
use "`datadir'/Ghana/Round3/GHR3_SDP_AnalysisData.dta", clear
*Set macros for country and round
local country "Ghana"
local round "Round 3"
local date "2014-12"
local CCRX "GHR3"
*/

/*GHR4
use "`datadir'/Ghana/Round4/GHR4_SDP_AnalysisData.dta", clear
*Set macros for country and round
local country "Ghana"
local round "Round 4"
local date "2015-06"
local CCRX "GHR4"
*/

/*IDR1
use "`datadir'/Indonesia/Round1/IDR1_SDP_AnalysisData.dta", clear
* If 1 and 3 month injectables and are presenting as one category, combine injectable variables here if doing so
gen offered_injectables=""
replace offered_injectables=offered_injectables_1mo if offered_injectables_1mo!=""
replace offered_injectables=offered_injectables_3mo if offered_injectables_3mo!=""
foreach var in counseled_injectables provided_injectables prescribed_injectables charged_injectables {
gen `var'=.
replace `var'=0 if `var'_3mo==0 & `var'_1mo==0
replace `var'=1 if `var'_3mo==1 |`var'_1mo==1
}
gen visits_injectables_total=visits_injectables_3mo_total+visits_injectables_1mo_total 
gen visits_injectables_new=visits_injectables_3mo_new+visits_injectables_1mo_new

gen stock_injectables=.
replace stock_injectables=3 if stock_injectables_3mo==3 & stock_injectables_1mo==3 
replace stock_injectables=2 if stock_injectables_3mo==2 | stock_injectables_1mo==2
replace stock_injectables=1 if stock_injectables_3mo==1 | stock_injectables_1mo==1
*
gen stockout_3mo_injectables=.
replace stockout_3mo_injectables=0 if stockout_3mo_injectables_3mo==0 & stockout_3mo_injectables_1mo==0 
replace stockout_3mo_injectables=1 if stockout_3mo_injectables_3mo==1 | stockout_3mo_injectables_1mo==1
*
gen stockout_3mo_now_injectables=0 if provided_injectables==1
replace stockout_3mo_now_injectables=1 if stock_injectables==3
replace stockout_3mo_now_injectables=1 if stockout_3mo_injectables==1

*Set macros for country and round
local country "Indonesia"
local round "Round 1"
local date "2015-08"
local CCRX "IDR1"
*/

/*INR1
use "`datadir'/Rajasthan/Round1/RJR1_SDP_AnalysisData.dta"
*Set macros for country and round
local country "India_Rajasthan"
local round "Round 1"
local date "2016-05"
local CCRX "INR1_Rajasthan"
gen region=1
*/

*INR2
use "`datadir'/Rajasthan/Round2/RJR2_SDP_AnalysisData.dta"
rename fees_rw fees
*Set macros for country and round
local country "India_Rajasthan"
local round "Round 2"
local date "2017-05"
local CCRX "INR2_Rajasthan"
gen region=1
*/

/*KER1
use "`datadir'/Kenya/Round1/KER1_SDP_AnalysisData.dta", clear
*Set macros for country and round
local country "Kenya"
local round "Round 1"
local date "2014-07"
local CCRX "KER1"
*Generate vars=. for KER1 stock questions (questions not asked)
foreach method in pills injectables iud implants male_condoms ec {
gen stockout_3mo_now_`method'=.
}
gen threshold_3=.
gen threshold_5=.
*/

/*KER2
use "`datadir'/Kenya/Round2/KER2_SDP_AnalysisData.dta", clear
*Set macros for country and round
local country "Kenya"
local round "Round 2"
local date "2014-12"
local CCRX "KER2"
*/

/*KER3
use "`datadir'/Kenya/Round3/KER3_SDP_AnalysisData.dta", clear
*Set macros for country and round
local country "Kenya"
local round "Round 3"
local date "2015-07"
local CCRX "KER3"
*/

/*KER4
use "`datadir'/Kenya/Round4/KER4_SDP_AnalysisData.dta", clear
*Set macros for country and round
local country "Kenya"
local round "Round 4"
local date "2015-11"
local CCRX "KER4"
*/

/*NER1
use "`datadir'/Niger/Round1/NER1_SDP_AnalysisData.dta", clear
*Set macros for country and round
local country "Niger_Niamey"
local round "Round 1"
local date "2015-08"
local CCRX "NER1_Niamey"
*/

/*NER2
use "`datadir'/Niger/Round2/NER2_SDP_AnalysisData.dta", clear
*Set macros for country and round
local country "Niger"
local round "Round 2"
local date "2016-06"
local CCRX "NER2"
rename geography region
recode region 1=2 2=3 3=4 4=5 5=1
*/

/*NER3
use "`datadir'/Niger/Round3/Data/NER3_Niamey_SDP_AnalysisData.dta", clear
rename fees_rw fees
*Set macros for country and round
local country "Niger_Niamey"
local round "Round 3"
local date "2016-11"
local CCRX "NER3_Niamey"
*/

/*NGR1 -- KADUNA
use "`datadir'/Nigeria/Round1/NGR1_SDP_AnalysisData_Kaduna.dta", clear
*Set macros for country and round
local country "Nigeria_Kaduna"
local round "Round 1"
local date "2014-10"
local CCRX "NGR1_Kaduna"
*/

/*NGR1 -- LAGOS
use "`datadir'/Nigeria/Round1/NGR1_SDP_AnalysisData_Lagos.dta", clear
*Set macros for country and round
local country "Nigeria_Lagos"
local round "Round 1"
local date "2014-10"
local CCRX "NGR1_Lagos"
*/

/*NGR2 -- KADUNA
use "`datadir'/Nigeria/Round2/NGR2_SDP_AnalysisData_Kaduna.dta", clear
*Set macros for country and round
local country "Nigeria_Kaduna"
local round "Round 2"
local date "2015-09"
local CCRX "NGR2_Kaduna"
*/

/*NGR2 -- LAGOS
use "`datadir'/Nigeria/Round2/NGR2_SDP_AnalysisData_Lagos.dta", clear
*Set macros for country and round
local country "Nigeria_Lagos"
local round "Round 2"
local date "2015-09"
local CCRX "NGR2_Lagos"
*/

/*NGR3 --
use "`datadir'/Nigeria/Round3/NGR3_SDP_AnalysisData.dta", clear
*1. Kaduna
*2. Lagos
*3. Taraba
*4. Kano
*5. Rivers
*6. Nasarawa
*7. Anambra
local state "Anambra"
keep if state==7
*Set macros for country and round
local country "Nigeria_`state'"
local round "Round 3"
local date "2016-06"
local CCRX "NGR3_`state'"
*/

/*UGR2
use "`datadir'/Uganda/Round2/UGR2_SDP_AnalysisData.dta", clear
*Set macros for country and round
local country "Uganda"
local round "Round 2"
local date "2015-02"
local CCRX "UGR2"
*/

/*UGR3
use "`datadir'/Uganda/Round3/UGR3_SDP_AnalysisData.dta", clear
*Set macros for country and round
local country "Uganda"
local round "Round 3"
local date "2015-11"
local CCRX "UGR3"
*/

/*UGR4
use "`datadir'/Uganda/Round4/UGR4_SDP_AnalysisData.dta", clear
*Set macros for country and round
local country "Uganda"
local round "Round 4"
local date "2016-05"
local CCRX "UGR4"
*/

*Incorrect var name in DRC, need to correct in public datasets
capture rename visits_female_ster_total visits_female_ster
capture rename visits_male_ster_total visits_male_ster

******************************************************************************************************************
* B. Set up dataset: generate variables needed to analysis
******************************************************************************************************************

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

******************************************************************************************************************
* C. Format new dataset
******************************************************************************************************************

use "`CCRX'_SDP_DataViz.dta", clear

*Create columns for Country, Round, Date
replace Country="`country'"
gen Round="`round'"
order Round, after(Country)
gen Date="`date'"
order Date, after(Round)

*Generate Category & Grouping vars
order Category, after(Date)
order facility_type_soi-beds_cat, after (all)
order sector12-fp_offered, after(beds_cat)

*Replace numbers with Labels before moving to Category column
foreach var in all facility_type_soi ur beds_cat sector12 region_soi fp_offered {
tostring `var', force replace
}

*Finish cleaning Category & Grouping
foreach var in all facility_type_soi ur beds_cat sector12 {
forval y=1/96 {
replace `var'="`y'" if Category=="`var'_`y'"
}
}

*Same categories for all countries
replace all="All" if all=="1"
replace ur="Urban" if ur=="1"
replace ur="Rural" if ur=="2"
replace beds_cat="0-50" if beds_cat=="1"
replace beds_cat="51-100" if beds_cat=="2"
replace beds_cat="101 or more" if beds_cat=="3"
replace sector12="Public" if sector12=="1"
replace sector12="Private" if sector12=="2"
replace fp_offered="No" if fp_offered=="0"
replace fp_offered="Yes" if fp_offered=="1"

*Country-specific categories	
*facility type
				 
				   replace facility_type_soi="Hospital" if facility_type_soi=="1" & Country=="Burkina"
			  replace facility_type_soi="Health center" if facility_type_soi=="2" & Country=="Burkina"
	replace facility_type_soi="Pharmacy/ other private" if facility_type_soi=="3" & Country=="Burkina"
			          replace facility_type_soi="Other" if facility_type_soi=="4" & Country=="Burkina"

				   replace facility_type_soi="Hospital" if facility_type_soi=="1" & (Country=="DRC" | Country=="DRC_Kinshasa" | Country=="DRC_KongoCentral")
			  replace facility_type_soi="Health center" if facility_type_soi=="2" & (Country=="DRC" | Country=="DRC_Kinshasa" | Country=="DRC_KongoCentral")
			  replace facility_type_soi="Health clinic" if facility_type_soi=="3" & (Country=="DRC" | Country=="DRC_Kinshasa" | Country=="DRC_KongoCentral")
				 replace facility_type_soi="Dispensary" if facility_type_soi=="4" & (Country=="DRC" | Country=="DRC_Kinshasa" | Country=="DRC_KongoCentral")
				   replace facility_type_soi="Pharmacy" if facility_type_soi=="5" & (Country=="DRC" | Country=="DRC_Kinshasa" | Country=="DRC_KongoCentral")
				      replace facility_type_soi="Other" if facility_type_soi=="96" & (Country=="DRC" | Country=="DRC_Kinshasa" | Country=="DRC_KongoCentral")
 
				   replace facility_type_soi="Hospital" if facility_type_soi=="1" & Country=="Ethiopia"
	   replace facility_type_soi="Health center/clinic" if facility_type_soi=="2" & Country=="Ethiopia"
				replace facility_type_soi="Health post" if facility_type_soi=="3" & Country=="Ethiopia"
   replace facility_type_soi="Pharmacy/drug shop/other" if facility_type_soi=="4" & Country=="Ethiopia"
				
		  replace facility_type_soi="Hospital/Polyclinic" if facility_type_soi=="1" & Country=="Ghana"
  replace facility_type_soi="Health center/Health clinic" if facility_type_soi=="2" & Country=="Ghana"
					     replace facility_type_soi="CHPS" if facility_type_soi=="3" & Country=="Ghana"
replace facility_type_soi="Pharmacy/Chemist/Retail/Other" if facility_type_soi=="4" & Country=="Ghana"

				   replace facility_type_soi="Hospital" if facility_type_soi=="1" & Country=="India_Rajasthan"
				     replace facility_type_soi="Clinic" if facility_type_soi=="2" & Country=="India_Rajasthan"
				        replace facility_type_soi="CHC" if facility_type_soi=="3" & Country=="India_Rajasthan"				  
				        replace facility_type_soi="PHC" if facility_type_soi=="4" & Country=="India_Rajasthan"				   
				 replace facility_type_soi="Dispensary" if facility_type_soi=="5" & Country=="India_Rajasthan"
				 replace facility_type_soi="Sub center" if facility_type_soi=="6" & Country=="India_Rajasthan"				   
				   replace facility_type_soi="Pharmacy" if facility_type_soi=="7" & Country=="India_Rajasthan"				   
				      replace facility_type_soi="Other" if facility_type_soi=="96" & Country=="India_Rajasthan"				   
			  
				   replace facility_type_soi="Hospital" if facility_type_soi=="1" & Country=="Indonesia"
	  replace facility_type_soi="Primary Health Center" if facility_type_soi=="2" & Country=="Indonesia"
			replace facility_type_soi="Pharmacy/ Other" if facility_type_soi=="3" & Country=="Indonesia"
	 
				   replace facility_type_soi="Hospital" if facility_type_soi=="1" & Country=="Kenya"
			  replace facility_type_soi="Health center" if facility_type_soi=="2" & Country=="Kenya"
			  replace facility_type_soi="Health clinic" if facility_type_soi=="3" & Country=="Kenya"
				 replace facility_type_soi="Dispensary" if facility_type_soi=="4" & Country=="Kenya"
				   replace facility_type_soi="Pharmacy" if facility_type_soi=="5" & Country=="Kenya"

				 
			   replace facility_type_soi="Hospital" if facility_type_soi=="1" & (Country=="Niger_Niamey" | Country=="Niger")
          replace facility_type_soi="Health center" if facility_type_soi=="2" & (Country=="Niger_Niamey" | Country=="Niger") 
			 replace facility_type_soi="Health hut" if facility_type_soi=="3" & (Country=="Niger_Niamey" | Country=="Niger")
replace facility_type_soi="Pharmacy/ other private" if facility_type_soi=="4" & (Country=="Niger_Niamey" | Country=="Niger")
				 
				   replace facility_type_soi="Hospital" if facility_type_soi=="1" & (Country=="Nigeria_`state'" | Country=="Nigeria_Kaduna" | Country== "Nigeria_Lagos" | Country== "Nigeria")
	          replace facility_type_soi="Health Center" if facility_type_soi=="2" & (Country=="Nigeria_`state'" | Country=="Nigeria_Kaduna" | Country== "Nigeria_Lagos" | Country== "Nigeria")
			       replace facility_type_soi="Pharmacy" if facility_type_soi=="3" & (Country=="Nigeria_`state'" | Country=="Nigeria_Kaduna" | Country== "Nigeria_Lagos" | Country== "Nigeria")			   
				   
				   replace facility_type_soi="Hospital" if facility_type_soi=="1" & Country=="Uganda"
		   replace facility_type_soi="Health center IV" if facility_type_soi=="2" & Country=="Uganda"
		  replace facility_type_soi="Health center III" if facility_type_soi=="3" & Country=="Uganda"
		   replace facility_type_soi="Health center II" if facility_type_soi=="4" & Country=="Uganda"			  
		      replace facility_type_soi="Health clinic" if facility_type_soi=="5" & Country=="Uganda"
   replace facility_type_soi="Pharmacy/ Chemist/ Other" if facility_type_soi=="6" & Country=="Uganda"
	   
*Regions

replace region_soi="Boucle de Mouhon" if region_soi=="1" & Country=="Burkina"
		replace region_soi="Cascades" if region_soi=="2" & Country=="Burkina"
		  replace region_soi="Centre" if region_soi=="3" & Country=="Burkina"
	  replace region_soi="Centre-Est" if region_soi=="4" & Country=="Burkina"
	 replace region_soi="Centre-Nord" if region_soi=="5" & Country=="Burkina"
	replace region_soi="Centre-Ouest" if region_soi=="6" & Country=="Burkina"
	  replace region_soi="Centre-Sud" if region_soi=="7" & Country=="Burkina"
			 replace region_soi="Est" if region_soi=="8" & Country=="Burkina"
   replace region_soi="Hauts-Bassins" if region_soi=="9" & Country=="Burkina"
		   replace region_soi="Nord" if region_soi=="10" & Country=="Burkina"
replace region_soi="Plateau-Central" if region_soi=="11" & Country=="Burkina"
		  replace region_soi="Sahel" if region_soi=="12" & Country=="Burkina"
	  replace region_soi="Sud-Ouest" if region_soi=="13" & Country=="Burkina"
	 
	replace region_soi="Addis" if region_soi=="1" & Country=="Ethiopia"
   replace region_soi="Amhara" if region_soi=="2" & Country=="Ethiopia"
  replace region_soi="Oromiya" if region_soi=="3" & Country=="Ethiopia"
	 replace region_soi="SNNP" if region_soi=="4" & Country=="Ethiopia"
   replace region_soi="Tigray" if region_soi=="5" & Country=="Ethiopia"
	replace region_soi="Other" if region_soi=="6" & Country=="Ethiopia"
								
replace region_soi="Bungoma" if region_soi=="1" & Country=="Kenya"
replace region_soi="Kericho" if region_soi=="2" & Country=="Kenya"
 replace region_soi="Kiambu" if region_soi=="3" & Country=="Kenya"
 replace region_soi="Kilifi" if region_soi=="4" & Country=="Kenya"
  replace region_soi="Kitui" if region_soi=="5" & Country=="Kenya"
replace region_soi="Nairobi" if region_soi=="6" & Country=="Kenya"
  replace region_soi="Nandi" if region_soi=="7" & Country=="Kenya"
replace region_soi="Nyawira" if region_soi=="8" & Country=="Kenya"
  replace region_soi="Siaya" if region_soi=="9" & Country=="Kenya"
								
					  replace region="Ashanti" if region_soi=="1" & Country=="Ghana"
      			  replace region="Brong Ahafo" if region_soi=="2" & Country=="Ghana"
          			  replace region="Central" if region_soi=="3" & Country=="Ghana"
          			  replace region="Eastern" if region_soi=="4" & Country=="Ghana"
    			replace region="Greater Accra" if region_soi=="5" & Country=="Ghana"
         			 replace region="Northern" if region_soi=="6" & Country=="Ghana"
       			   replace region="Upper East" if region_soi=="7" & Country=="Ghana"
       			   replace region="Upper West" if region_soi=="8" & Country=="Ghana"
            			replace region="Volta" if region_soi=="9" & Country=="Ghana"
         			  replace region="Western" if region_soi=="10" & Country=="Ghana"
								  
         			replace region="Java-Bali" if region_soi=="1" & Country=="Indonesia"
         			    replace region="Other" if region_soi=="2" & Country=="Indonesia"								  
 
   replace region_soi="Niamey" if region_soi=="1" & (Country=="Niger_Niamey" | Country=="Niger")								 
   replace region_soi="Agadez" if region_soi=="2" & (Country=="Niger_Niamey" | Country=="Niger")
    replace region_soi="Diffa" if region_soi=="3" & (Country=="Niger_Niamey" | Country=="Niger")
    replace region_soi="Dosso" if region_soi=="4" & (Country=="Niger_Niamey" | Country=="Niger")
   replace region_soi="Maradi" if region_soi=="5" & (Country=="Niger_Niamey" | Country=="Niger")
   replace region_soi="Tahoua" if region_soi=="6" & (Country=="Niger_Niamey" | Country=="Niger")
replace region_soi="Tillaberi" if region_soi=="7" & (Country=="Niger_Niamey" | Country=="Niger")
   replace region_soi="Zinder" if region_soi=="8" & (Country=="Niger_Niamey" | Country=="Niger")
 
replace region="None" if region_soi=="1" & (Country=="Nigeria_`state'" | Country=="Nigeria_Kaduna" | Country=="Nigeria_Lagos" | Country=="Nigeria")

 replace region="Central" if region_soi=="1" & Country=="Uganda"
 replace region="Eastern" if region_soi=="2" & Country=="Uganda"
replace region="Northern" if region_soi=="3" & Country=="Uganda"
 replace region="Western" if region_soi=="4" & Country=="Uganda"
									
*Create "Category" column
foreach x in all facility_type_soi ur beds_cat sector12 region_soi fp_offered {
replace `x'="" if `x'=="."
replace Category=`x' if `x'!=""
}
*
replace Category="" if Category=="."
drop if Category=="-99" | Category=="99" | Category=="96" | Category=="6" | Category==""

*Groupings: None (all), Facility Type, Location, Number of Beds, Sector, Offers Family Planning 
*Create "Grouping" column
gen Grouping="none" if Category!=""
replace Grouping="Facility Type" if facility_type_soi!=""
replace Grouping="Location" if ur!=""
replace Grouping="Number of beds" if beds_cat!=""
replace Grouping="Sector" if sector12!=""
replace Grouping="Region" if region_soi!=""
replace Grouping="Offers Family Planning" if fp_offered!=""
order Grouping, after(Date)
foreach x in all facility_type_soi ur beds_cat sector12 region_soi fp_offered {
drop `x'
}
*

*Drop Cateogries we don't want
drop if Grouping=="Location" & (Country=="DRC" | Country=="DRC_Kinshasa" | Country=="DRC_KongoCentral")
drop if Grouping=="Region" & (Country=="DRC" | Country=="DRC_Kinshasa" | Country=="DRC_KongoCentral")
drop if Grouping=="Region" & Country=="Niger_Niamey"

save "`CCRX'_SDP_DataViz.dta", replace

******************************************************************************************************************
* D. Split by denominator, and merge back together
******************************************************************************************************************
gen feespub=1 if fees_public!=. 
gen feespriv=1 if fees_private!=. 
gen threshold3pub=1 if threshold_3_public!=. | provided_pills_public!=.
gen threshold3priv=1 if threshold_3_private!=. | provided_pills_private!=.
gen sterfemale=1 if visits_female_ster!=. 
gen stermale=1 if visits_male_ster!=.
gen injectablestotal=1 if visits_injectables_total!=. 
gen injectablesnew=1 if visits_injectables_new!=.
gen iudtotal=1 if visits_iud_total!=. 
gen iudnew=1 if visits_iud_new!=.
gen implantstotal=1 if visits_implants_total!=. 
gen implantsnew=1 if visits_implants_new!=.
gen malecondomstotal=1 if visits_male_condoms_total!=. 
gen malecondomsnew=1 if visits_male_condoms_new!=.
gen pillstotal=1 if visits_pills_total!=. 
gen pillsnew=1 if visits_pills_new!=.
gen ectotal=1 if visits_ec_total!=. 
gen ecnew=1 if visits_ec_new!=.
gen facilitiesnumb=1 if one_number!=.
gen facilitiesperc=1 if one_percentage!=. 

*1a. Public: Fees & Stock
preserve
keep if feespub==1
keep Country Round Date Grouping Category ///
fees_public-stockout_3mo_now_ec_public 
tempfile temp_feespub
save `temp_feespub.dta', replace 
restore 

*1b. Private: Fees & Stock Fees
preserve
keep if feespriv==1
keep Country Round Date Grouping Category ///
fees_private-stockout_3mo_now_ec_private 
tempfile temp_feespriv
save `temp_feespriv.dta', replace 
restore 

*2a. Public: 3+/5+ & Provision
preserve
keep if threshold3pub==1
keep Country Round Date Grouping Category ///
threshold_3_public-provided_ec_public
tempfile temp_threshold3pub
save `temp_threshold3pub.dta', replace 
restore 

*2b. Private: Public: 3+/5+ & Provision
preserve
keep if threshold3priv==1
keep Country Round Date Grouping Category ///
threshold_3_private-provided_ec_private
tempfile temp_threshold3priv
save `temp_threshold3priv.dta', replace 
restore 

*3a_1. Public & Private: Visits
preserve
keep if sterfemale==1
keep Country Round Date Grouping Category ///
visits_female_ster
gen id=_n + 100
tempfile temp_sterfemale
save `temp_sterfemale.dta', replace 
restore 

*3a_2. Public & Private: Visits 
preserve
keep if stermale==1
keep Category ///
visits_male_ster
gen id=_n + 100
tempfile temp_stermale
save `temp_stermale.dta', replace 
restore 

*3a_3. Public & Private: Visits
preserve
keep if injectablestotal==1
keep Category ///
visits_injectables_total
tempfile temp_injectablestotal
save `temp_injectablestotal.dta', replace 
restore 

*3a_4. Public & Private: Visits
preserve
keep if injectablesnew==1
keep Category ///
visits_injectables_new
tempfile temp_injectablesnew
save `temp_injectablesnew.dta', replace 
restore 

*3a_5. Public & Private: Visits
preserve
keep if iudtotal==1
keep Category ///
visits_iud_total
tempfile temp_iudtotal
save `temp_iudtotal.dta', replace 
restore 

*3a_6. Public & Private: Visits
preserve
keep if iudnew==1
keep Category ///
visits_iud_new
tempfile temp_iudnew
save `temp_iudnew.dta', replace 
restore 

*3a_7. Public & Private: Visits
preserve
keep if implantstotal==1
keep Category ///
visits_implants_total
tempfile temp_implantstotal
save `temp_implantstotal.dta', replace 
restore 

*3a_8. Public & Private: Visits
preserve
keep if implantsnew==1
keep Category ///
visits_implants_new
tempfile temp_implantsnew
save `temp_implantsnew.dta', replace 
restore 

*3a_9. Public & Private: Visits
preserve
keep if malecondomstotal==1
keep Category ///
visits_male_condoms_total
tempfile temp_malecondomstotal
save `temp_malecondomstotal.dta', replace 
restore 

*3a_10. Public & Private: Visits
preserve
keep if malecondomsnew==1
keep Category ///
visits_male_condoms_new
tempfile temp_malecondomsnew
save `temp_malecondomsnew.dta', replace 
restore 

*3a_11. Public & Private: Visits
preserve
keep if pillstotal==1
keep Category ///
visits_pills_total
tempfile temp_pillstotal
save `temp_pillstotal.dta', replace 
restore 

*3a_12. Public & Private: Visits
preserve
keep if pillsnew==1
keep Category ///
visits_pills_new
tempfile temp_pillsnew
save `temp_pillsnew.dta', replace 
restore 

*3a_13. Public & Private: Visits
preserve
keep if ectotal==1
keep Category ///
visits_ec_total
tempfile temp_ectotal
save `temp_ectotal.dta', replace 
restore 

*3a_13. Public & Private: Visits
preserve
keep if ecnew==1
keep Category ///
visits_ec_new
tempfile temp_ecnew
save `temp_ecnew.dta', replace 
restore 

*4a. Number facilities
preserve
keep if facilitiesnumb==1
keep Country Round Date Grouping Category ///
one_number
gen id=_n + 200
tempfile temp_facilitiesnumb
save `temp_facilitiesnumb.dta', replace 
restore

*4b. Percent facilities 
preserve
keep if facilitiesperc==1
keep Country Round Date Grouping Category ///
one_percentage
tempfile temp_facilitiesperc
save `temp_facilitiesperc.dta', replace 
restore

use `temp_feespub.dta', clear
merge 1:1 Category using `temp_feespriv.dta', gen(merge_feespriv)
merge 1:1 Category using `temp_threshold3pub.dta', gen(merge_threshold3pub)
merge 1:1 Category using `temp_threshold3priv.dta', gen(merge_threshold3priv)
merge 1:m Category using `temp_sterfemale.dta', gen(merge_sterfemale)
merge 1:1 Category using `temp_stermale.dta', gen(merge_stermale)
merge 1:m Category using `temp_injectablestotal.dta', gen(merge_injectablestotal)
merge 1:m Category using `temp_injectablesnew.dta', gen(merge_injectablesnew)
merge 1:m Category using `temp_iudtotal.dta', gen(merge_iudtotal)
merge 1:m Category using `temp_iudnew.dta', gen(merge_iudnew)
merge 1:m Category using `temp_implantstotal.dta', gen(merge_implantstotal)
merge 1:m Category using `temp_implantsnew.dta', gen(merge_implantsnew)
merge 1:m Category using `temp_malecondomstotal.dta', gen(merge_malecondomstotal)
merge 1:m Category using `temp_malecondomsnew.dta', gen(merge_malecondomsnew)
merge 1:m Category using `temp_pillstotal.dta', gen(merge_pillstotal)
merge 1:m Category using `temp_pillsnew.dta', gen(merge_pillsnew)
merge 1:m Category using `temp_ectotal.dta', gen(merge_ectotal)
merge 1:m Category using `temp_ecnew.dta', gen(merge_ecnew)
merge m:m Category using `temp_facilitiesnumb.dta', gen(merge_facilitiesnumb)
merge 1:m Category using `temp_facilitiesperc.dta', gen(merge_facilitiesperc) // *note -- with: merge 1:m received this error: "variable Category does not uniquely identify observations in the master data"

sort id
drop id merge_feespriv merge_threshold3pub merge_threshold3priv ///
merge_sterfemale merge_stermale ///
merge_injectablestotal merge_injectablesnew merge_iudtotal merge_iudnew ///
merge_implantstotal merge_implantsnew merge_malecondomstotal merge_malecondomsnew ///
merge_pillstotal merge_pillsnew merge_ectotal merge_ecnew ///
merge_facilitiesnumb merge_facilitiesperc

foreach var in fees threshold_3 threshold_5 ///
{
order `var'_private, after(`var'_public)
}
foreach var in visits_injectables visits_iud visits_implants ///
visits_male_condoms visits_pills visits_ec ///
{
order `var'_new, after(`var'_total)
}
order threshold_3_public-threshold_3_private, after(fees_private)
order threshold_5_public-threshold_5_private, after(threshold_3_private)
order provided_pills_public-provided_ec_public, after(threshold_5_private)
order provided_pills_private-provided_ec_private, after(provided_ec_public)
order stockout_3mo_now_pills_public-stockout_3mo_now_ec_public, after(provided_ec_private)
order stockout_3mo_now_pills_private-stockout_3mo_now_ec_private, after(stockout_3mo_now_ec_public)
order visits_male_ster, after(visits_female_ster)
order visits_injectables_total, after(visits_male_ster)
order one_number, after(visits_ec_new)
order one_percentage, after(one_number)

*Niger Round 1: no SDPs for some categories
if Country=="Niger_Niamey" & Round=="Round 1" {
set obs 13
replace Category="Health hut" if Category==""
replace Grouping="Facility type" if Grouping==""
set obs 14
replace Category="51-100" if Grouping==""
replace Grouping="Number of beds" if Grouping==""
replace Country="Niger_Niamey" if Country==""
replace Round="Round 1" if Round==""
replace Date="2015-08" if Date==""
gen n=_n
replace n=3.1 if n==13
replace n=7.1 if n==14
sort n
drop n
}

*Niger Round 3: no SDPs for some categories
if Country=="Niger_Niamey" & Round=="Round 3" {
set obs 12
replace Category="51-100" if Grouping==""
replace Grouping="Number of beds" if Grouping==""
replace Country="Niger_Niamey" if Country==""
replace Round="Round 3" if Round==""
replace Date="2016-11" if Date==""
gen n=_n
replace n=6.1 if n==12
sort n
drop n
}

*DRC Round 4 Kongo Central: no SDPs for some categories
if Country=="DRC_KongoCentral" & Round=="Round 4" {
set obs 14
replace Category="Health clinic" if Category==""
replace Grouping="Facility type" if Grouping==""
replace Country="DRC_KongoCentral" if Country==""
replace Round="Round 4" if Round==""
replace Date="2016-01" if Date==""
gen n=_n
replace n=3.1 if n==14
sort n
drop n
}

save "`CCRX'_SDP_DataViz.dta", replace
exit
