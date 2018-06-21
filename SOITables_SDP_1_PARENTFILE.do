/******************************************************************************************************************
SOI TABLES PARENT FILE

INSTRUCTIONS

1. Update this do file for a country/ round:
	Section A: 
		-Update directories
		-Call in dataset (Run CCRX_HHQFQDoFile3_Analysis Prep on publically-released dataset) 
		-Set macros
		-Recode/ collapse school categories if neccessary
2. Run .do file vargen: Set up dataset - Generate variables needed for analysis
3. Run .do file countryspecific: Set country-specific Categories for School and Region Groupings -- Regions must be numbers in data (twice) 
4. Run .do file formatting: Format Data into wide version and order variables

******************************************************************************************************************/
* Section A. Call in data set & set macros
******************************************************************************************************************

clear
clear matrix
clear mata
capture log close
set more off
numlabel, add

*Directory
local analysisdata "/Users/ealarson/Documents/Ghana/Data_NotShared/Round5/SOI/SDP"
global datadir "/Users/ealarson/Documents/Ghana/Data_NotShared/Round5/SOI/SDP"
local dofiles "/Users/ealarson/Documents/RandomCoding/SOI_Tables"
global csv_results "$datadir/csv_results"

*Macros for .do files subsequent .do files
local othertables "`dofiles'/SOITables_SDP_2_OtherTables.do"
local vargen "`dofiles'/SOITables_SDP_3_VarGen.do"
local countryspecific "`dofiles'/SOITables_SDP_4_CountrySpecific.do"
local formatting "`dofiles'/SOITables_SDP_5_Formatting.do"

*Date Macro
local today=c(current_date)
local c_today= "`today'"
global today=subinstr("`c_today'", " ", "",.)

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

*GHR5
use "`analysisdata'/GHR5_SDP_AnalysisData.dta", clear
*Set macros for country and round
global country "Ghana"
global round "Round 5"
global date "2016-10"
global CCRX "GHR5"
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

/*INR2
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

/******************************************************************************************************************
Run .do files
******************************************************************************************************************/
include `othertables'
include `vargen'
include `countryspecific'
include `formatting'
use "$datadir/`CCRX'_SDP_SOITable_$today.dta", clear
export delimited using "$csv_results/`CCRX'_SDP_SOITable_$today", replace



