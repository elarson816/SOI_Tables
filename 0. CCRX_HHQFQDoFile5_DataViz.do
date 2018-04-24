/******************************************************************************************************************

INSTRUCTIONS

Note: For full Data Lab instructions, see "Data Lab Instructions" in 
	  PMADataManagement_All/ DataVisualization

1. Update this do file for a country/ round:
	Section A: 
		-Update directories
		-Call in dataset (Run CCRX_HHQFQDoFile3_Analysis Prep on publically-released dataset) 
		-Set macros
		-Recode/ collapse school categories if neccessary
	Section C: Set country-specific Categories for School and Region Groupings -- Regions must be numbers in data (twice) 
2. Run Sections A-D

******************************************************************************************************************/
* Section A. Call in data set & set macros
******************************************************************************************************************

clear
clear all
set more off

*Sally's directory
cd "/Users/ealarson/Documents/Ghana/Data_NotShared/Round5/SOI/HHQFQ"
local datadir "/Users/ealarson/Documents/Ghana/Data_NotShared"
*local datadir "~/Dropbox (Gates Institute)/Gates"
*/

/*BFR1
use "`datadir'/Burkina Faso/Round1/BFR1_HHQFQ_AnalysisData.dta", clear
local country "Burkina"
local round "Round 1"
local date "2014-12"
local CCRX "BFR1"
recode wealth 2=3 3=5
*/

/*BFR2
use "`datadir'/Burkina Faso/Round2/BFR2_HHQFQ_AnalysisData.dta", clear
local country "Burkina"
local round "Round 2"
local date "2015-05"
local CCRX "BFR2"
recode wealth 2=3 3=5
*/

/*BFR3
use "`datadir'/Burkina Faso/Round3/BFR3_HHQFQ_AnalysisData.dta", clear
local country "Burkina"
local round "Round 3"
local date "2016-05"
local CCRX "BFR3"
recode wealth 2=3 3=5
*/

/*BFR4
use "/Users/Sally/Dropbox (Gates Institute)/SOI_Table_Checking/Burkina Faso/Round4/BFR4_HHQFQ_AnalysisData.dta", clear
local country "Burkina"
local round "Round 4"
local date "2016-12"
local CCRX "BFR4"
recode wealth 2=3 3=5
*/

/*CDR1
*use "`datadir'/DRC/Round1/CDR1_HHQFQ_AnalysisData.dta", clear
use "~/Dropbox (Gates Institute)/Gates/CDR1_HHQFQ_AnalysisData.dta"
*Set macros for country and round
local country "DRC_Kinshasa"
local round "Round 1"
local date "2014-01"
local CCRX "CDR1"
gen ur=1
gen region=1
gen tsinceb=70
*/

/*CDR2
use "`datadir'/DRC/Round2/CDR2_HHQFQ_AnalysisData.dta", clear
*Set macros for country and round
local country "DRC_Kinshasa"
local round "Round 2"
local date "2014-09"
local CCRX "CDR2"
gen ur=1
gen region=1
*Recode school
*recode school 0=0 1=1 2 4=2 3 5 6=3 -99=-99
*label define schoolcdr11 0 "Never attended" 1 "Primary" 2 "Secondary" 3 "Superior" -99 "-99", replace
*/

/*CDR3
use "`datadir'/DRC/Round3/CDR3_HHQFQ_AnalysisData.dta", clear
*Set macros for country and round
local country "DRC_Kinshasa"
local round "Round 3"
local date "2015-06"
local CCRX "CDR3"
*gen ur=1
gen region=1
*/

/*CDR4 -- Kinshasa
use "`datadir'/DRC/Round4/CDR4_HHQFQ_AnalysisData_kin.dta", clear
*Set macros for country and round
local country "DRC_Kinshasa"
local round "Round 4"
local date "2015-12"
local CCRX "CDR4_Kinshasa"
gen region=1
label def region_list 1 "Kinshasa"
label val region region_list
*/

/*CDR4 -- Kongo Central
use "`datadir'/DRC/Round4/CDR4_HHQFQ_AnalysisData_KC.dta", clear
*Set macros for country and round
local country "DRC_Kongo_Central"
local round "Round 4"
local date "2015-12"
local CCRX "CDR4_KC"
gen region=2
label def region_list 2 "Kongo Central"
label val region region_list
*/

/*CDR5 -- Kinshasa
use "`datadir'/DRC/Round5/CDR5_Kinshasa_HHQFQ_AnalysisData.dta", clear
*Set macros for country and round
local country "DRC_Kinshasa"
local round "Round 5"
local date "2016-09"
local CCRX "CDR5_Kinshasa"
gen region=1
label def region_list 1 "Kinshasa"
label val region region_list
*/

/*CDR5 -- Kongo Central
use "`datadir'/DRC/Round5/CDR5_KongoCentral_HHQFQ_AnalysisData.dta", clear
*Set macros for country and round
local country "DRC_KongoCentral"
local round "Round 5"
local date "2016-09"
local CCRX "CDR5_KC"
gen region=2
label def region_list 2 "Kongo Central"
label val region region_list
*/

/*ETR1
use "`datadir'/Ethiopia/Round1/ETR1_HHQFQ_AnalysisData.dta", clear
local country "Ethiopia"
local round "Round 1"
local date "2014-03"
local CCRX "ETR1"
drop region
rename regionnum region
gen region_soi=region
recode region_soi 10=1 3=2 4=3 7=4 1=5 2=6 5=6 6=6 8=6 9=6 11=6
label define region_soi_list 1 addis 2 amhara 3 oromiya 4 snnp 5 tigray 6 other
labe val region_soi region_soi_list
drop region
rename region_soi region
*/

/*ETR2
use "`datadir'/Ethiopia/Round2/ETR2_HHQFQ_AnalysisData.dta", clear
local country "Ethiopia"
local round "Round 2"
local date "2014-10"
local CCRX "ETR2"
recode school -88=-99
gen region_soi=region
recode region_soi 10=1 3=2 4=3 7=4 1=5 2=6 5=6 6=6 8=6 9=6 11=6
label define region_soi_list 1 addis 2 amhara 3 oromiya 4 snnp 5 tigray 6 other
labe val region_soi region_soi_list
drop region
rename region_soi region
*/

/*ETR3
use "`datadir'/Ethiopia/Round3/ETR3_HHQFQ_AnalysisData.dta", clear
local country "Ethiopia"
local round "Round 3"
local date "2015-05"
local CCRX "ETR3"
recode school -88=-99
gen region_soi=region
recode region_soi 10=1 3=2 4=3 7=4 1=5 2=6 5=6 6=6 8=6 9=6 11=6
label define region_soi_list 1 addis 2 amhara 3 oromiya 4 snnp 5 tigray 6 other
labe val region_soi region_soi_list
drop region
rename region_soi region
*/

/*ETR4
use "`datadir'/Ethiopia/Round4/ETR4_HHQFQ_AnalysisData.dta", clear
local country "Ethiopia"
local round "Round 4"
local date "2016-04"
local CCRX "ETR4"
recode school -88=-99
gen region_soi=region
recode region_soi 10=1 3=2 4=3 7=4 1=5 2=6 5=6 6=6 8=6 9=6 11=6
label define region_soi_list 1 addis 2 amhara 3 oromiya 4 snnp 5 tigray 6 other
labe val region_soi region_soi_list
drop region
rename region_soi region
*/

/*GHR1
use "`datadir'/Ghana/Round1/GHR1_HHQFQ_AnalysisData.dta", clear
local country "Ghana"
local round "Round 1"
local date "2013-10"
local CCRX "GHR1"
*/

/*GHR2
use "`datadir'/Ghana/Round2/GHR2_HHQFQ_AnalysisData.dta", clear
local country "Ghana"
local round "Round 2"
local date "2014-05"
local CCRX "GHR2"
rename fees_6months fees_12months
*/

/*GHR3
use "`datadir'/Ghana/Round3/GHR3_HHQFQ_AnalysisData.dta", clear
local country "Ghana"
local round "Round 3"
local date "2014-12"
local CCRX "GHR3"
*/

/*GHR4
use "`datadir'/Ghana/Round4/GHR4_HHQFQ_AnalysisData.dta", clear
local country "Ghana"
local round "Round 4"
local date "2015-06"
local CCRX "GHR4"
*/

*GHR5
use "`datadir'/Round5/SOI/HHQFQ/GHR5_HHQFQ_AnalysisData.dta", clear
local country "Ghana"
local round "Round 5"
local date "2016-08"
local CCRX "GHR5"
recode current_method_recode 11=9 32=10
*/

/*IDR1
use "`datadir'/Indonesia/Round1/IDR1_HHQFQ_AnalysisData.dta", clear
*Set macros for country and round
local country "Indonesia"
local round "Round 1"
local date "2015-08"
local CCRX "IDR1"
drop wealthquintile_SS wealthquintile_MK
recode school 5=4
*/

/*INR1_Rajasthan
use "~/Dropbox (Gates Institute)/SOI_Table_Checking/Rajasthan/Round1/RJR1_HHQFQ_AnalysisData.dta", clear
*Set macros for country and round
local country "India_Rajasthan"
local round "Round 1"
local date "2016-05"
local CCRX "INR1_Rajasthan"
gen region=1
*/

/*INR2_Rajasthan
use "~/Dropbox (Gates Institute)/SOI_Table_Checking/Rajasthan/Round2/RJR2_HHQFQ_AnalysisData.dta", clear
*Set macros for country and round
local country "India_Rajasthan"
local round "Round 2"
local date "2017-04"
local CCRX "INR2_Rajasthan"
gen region=1
*/

/*KER1
use "`datadir'/Kenya/Round1/KER1_HHQFQ_AnalysisData.dta", clear
local country "Kenya"
local round "Round 1"
local date "2014-07"
local CCRX "KER1"
*/

/*KER2
use "`datadir'/Kenya/Round2/KER2_HHQFQ_AnalysisData.dta", clear
local country "Kenya"
local round "Round 2"
local date "2014-12"
local CCRX "KER2"
*/

/*KER3
use "`datadir'/Kenya/Round3/KER3_HHQFQ_AnalysisData.dta", clear
local country "Kenya"
local round "Round 3"
local date "2015-07"
local CCRX "KER3"
*/

/*KER4
use "`datadir'/Kenya/Round4/KER4_HHQFQ_AnalysisData.dta", clear
local country "Kenya"
local round "Round 4"
local date "2015-11"
local CCRX "KER4"
*/

/*KER5
use "~/Dropbox (Gates Institute)/SOI_Table_Checking/Kenya/Round5/KER5_HHQFQ_AnalysisData.dta"
local country "Kenya"
local round "Round 5"
local date "2016-11"
local CCRX "KER5"
*/

/*NER1
use "~/Dropbox (Gates Institute)/SOI_Table_Checking/Niger/Round1/NER1_HHQFQ_AnalysisData.dta", clear
*Set macros for country and round
local country "Niger_Niamey"
local round "Round 1"
local date "2015-08"
local CCRX "NER1"
recode wealthtertile 1=1 2=3 3=5 
*/

/*NER2
*use "~/Dropbox (Gates Institute)/PMADataManagement_Niger/Round2/SOI_Tables/NER2_National_HHQFQ_AnalysisData.dta"
use "/Users/Sally/Downloads/NER2_National_HHQFQ_AnalysisData.dta"
*Set macros for country and round
local country "Niger_National"
local round "Round 2"
local date "2016-04"
local CCRX "NER2"
*/
/*Set macros for country and round
local country "Niger_Niamey"
local round "Round 2"
local date "2016-04"
local CCRX "NER2_Niamey"
*/
/*Generate region variable
drop region
label drop region_list
gen region=.
	replace region=1 if strata=="niamey"
	replace region=2 if strata=="other urban"
	replace region=3 if strata=="rural"
	label define region_list 1 "Niamey" 2 "Other Urban" 3 "Rural"
	label val region region_list
*/
/*Generate region variable
keep if level1=="niamey"
gen region=1
*/
/*Recode wealth tertiles to match quintiles
recode wealthtertile 1=1 2=3 3=5 
*/

/*NER3
use "~/Dropbox (Gates Institute)/SOI_Table_Checking/Niger/Round3/NER3_Niamey_HHQFQ_AnalysisData.dta", clear
local country "Niger_Niamey"
local round "Round 3"
local date "2016-11"
local CCRX "NER3"
recode wealthtertile 1=1 2=3 3=5 
rename level1 region
*/

/*NGR1 -- KADUNA
use "`datadir'/Nigeria/Round1/NGR1_HHQFQ_AnalysisData_Kaduna.dta", clear
*Set macros for country and round
local country "Nigeria_Kaduna"
local round "Round 1"
local date "2014-10"
local CCRX "NGR1_Kaduna"
*Generate variables neccessary for analysis
rename wealthquintile_Kaduna wealth 
tostring wealth, replace force
gen region=1
*/

/*NGR1 -- LAGOS
use "`datadir'/Nigeria/Round1/NGR1_HHQFQ_AnalysisData_Lagos.dta", clear
*Set macros for country and round
local country "Nigeria_Lagos"
local round "Round 1"
local date "2014-10"
local CCRX "NGR1_Lagos"
*Generate variables neccessary for analysis
rename wealthquintile_Lagos wealth 
tostring wealth, replace force
gen region=1
*/

/*NGR2 -- KADUNA
use "`datadir'/Nigeria/Round2/NGR2_HHQFQ_AnalysisData_Kaduna.dta", clear
*Set macros for country and round
local country "Nigeria_Kaduna"
local round "Round 2"
local date "2015-09"
local CCRX "NGR2_Kaduna"
gen region=1
*/

/*NGR2 -- LAGOS
use "`datadir'/Nigeria/Round2/NGR2_HHQFQ_AnalysisData_Lagos.dta", clear
*Set macros for country and round
local country "Nigeria_Lagos"
local round "Round 2"
local date "2015-09"
local CCRX "NGR2_Lagos"
gen region=1
*/

/*NGR3_states
use "`datadir'/Nigeria/Round3/NGR3_HHQFQ_AnalysisData.dta", clear
*1. Kaduna
*2. Lagos
*3. Taraba
*4. Kano
*5. Rivers
*6. Nasarawa
*7. Anambra
local state Kaduna
keep if state==1
*Set macros for COUNTRY and round
local country "Nigeria_`state'"
local round "Round 3"
local date "2016-06"
local CCRX "NGR3_`state'"
gen region=1
drop HHweight FQweight wealthquintile
rename HHweight_`state' HHweight
rename FQweight_`state' FQweight
rename wealthquintile_`state' wealth
*/

/*NGR3_national
use "~/Dropbox (Gates Institute)/SOI_Table_Checking/Nigeria/Round3/NGR3_HHQFQ_AnalysisData_IC.dta"
local country "Nigeria"
local round "Round 3"
local date "2016-05"
local CCRX "NGR3"
rename HHweight_National HHweight
rename FQweight_National FQweight
rename wealthquintile_National wealth
rename state region
*/

/*UGR1
use "`datadir'/Uganda/Round1/UGR1_HHQFQ_AnalysisData.dta", clear
*Set macros for country and round
local country "Uganda"
local round "Round 1"
local date "2014-06"
local CCRX "UGR1"
recode school 2=1 3=2 4=2 5=3 6=4
label define schooll 0 Never 1 Primary 2 Secondary 3 Technical_Vocational 4 University, replace
*/

/*UGR2
use "`datadir'/Uganda/Round2/UGR2_HHQFQ_AnalysisData.dta", clear
*Set macros for country and round
local country "Uganda"
local round "Round 2"
local date "2015-02"
local CCRX "UGR2"
recode school 2=1 3=2 4=2 5=3 6=4
*/

/*UGR3
use "`datadir'/Uganda/Round3/UGR3_HHQFQ_AnalysisData.dta", clear
*Set macros for country and round
local country "Uganda"
local round "Round 3"
local date "2015-11"
local CCRX "UGR3"
recode school 2=1 3=2 4=2 5=3 6=4
*/

/*UGR4
use "`datadir'/Uganda/Round4/UGR4_HHQFQ_AnalysisData.dta", clear
*Set macros for country and round
local country "Uganda"
local round "Round 4"
local date "2016-05"
local CCRX "UGR4"
recode school 2=1 3=2 4=2 5=3 6=4
*/

/*UGR5
use "`datadir'/Uganda/Round5/UGR5_HHQFQ_AnalysisData.dta", clear
*Set macros for country and round
local country "Uganda"
local round "Round 5"
local date "2017-05"
local CCRX "UGR5"
recode school 2=1 3=2 4=2 5=3 6=4
rename DHSregionnum region
*/

******************************************************************************************************************
* Section B. Set up dataset: generate variables needed to analysis
******************************************************************************************************************

*Recode return/ refer
recode return_to_provider -88=0
recode refer_to_relative -88=0

*Save country dataset as temp dataset 
tempfile temp
save `temp', replace

*Create blank dataset
clear
gen Country="`country'"
save "`CCRX'_DataViz.dta", replace

*Go back to temp dataset
use `temp', replace

*Generate county/ round variable
gen CCRX="`CCRX'"

*Generate correct "Category" variables
gen total=1
gen count=1

*Generate groups for all & married analyses
gen all=1 if FRS_result==1
gen mar=1 if FRS_result==1 & married==1

*Rename or generate neccessary variables
capture rename county region

*Generate five-year age group variable
capture egen age5=cut(FQ_age), at(15(5)50)

*For all calculations: 
***ODK update
*keep if HHQ_result==1 & FRS_result==1 & (usual_member==1 | usual_member==3)
keep if HHQ_result==1 & FRS_result==1 & last_night==1
	
save `temp', replace

******************************************************************************************************************
* 1a. ALL women
*	  MARRIED women
****************************************************************************************************************** 

use `temp', replace

*All women | Married women
foreach group in all mar {
*Each Grouping
foreach var in total age5 married umsexactive parity3 ur school wealth region {

preserve
keep if `group'==1

collapse (mean) cp_`group'=cp mcp_`group'=mcp tcp_`group'=tcp ///
unmettot_`group'=unmettot unmetspace_`group'=unmetspace unmetlimit_`group'=unmetlimit ///
totaldemand_`group'=totaldemand demandsatis_`group'=demandsatis ///
visited_by_health_worker_`group'=visited_by_health_worker visited_facility_fp_disc_`group'=visited_facility_fp_disc fp_discussion_`group'=fp_discussion ///
[aw=FQweight], by(`var')

*CP, unmet need, birth by 18 (all women 18-24)
replace cp_`group'=cp_`group'*100
replace mcp_`group'=mcp_`group'*100
replace tcp_`group'=tcp_`group'*100
replace unmettot_`group'=unmettot_`group'*100
replace unmetspace_`group'=unmetspace_`group'*100
replace unmetlimit_`group'=unmetlimit_`group'*100
replace totaldemand_`group'=totaldemand_`group'*100
replace demandsatis_`group'=demandsatis_`group'*100  
replace visited_by_health_worker_`group'=visited_by_health_worker_`group'*100
replace visited_facility_fp_disc_`group'=visited_facility_fp_disc_`group'*100
replace fp_discussion_`group'=fp_discussion_`group'*100

*Drop irrelavent/ unused categories
capture drop if married==0
capture drop if umsexactive==0
capture drop if married==1 & cp_mar!=.

tempfile temp2
save `temp2', replace

use "`CCRX'_DataViz.dta"
append using `temp2'
save "`CCRX'_DataViz.dta", replace
restore

*Generate denominators
foreach indicator in cp mcp tcp unmettot unmetspace unmetlimit totaldemand demandsatis visited_by_health_worker visited_facility_fp_disc fp_discussion {

preserve
keep if `group'==1

bysort `var': egen d_`indicator'_`group'=count(_n) if `indicator'==1

collapse (mean) d_`indicator'_`group' [pw=FQweight], by(`var')

*Drop irrelavent/ unused categories
capture drop if married==0
capture drop if umsexactive==0
capture drop if married==1 & cp_mar!=.

tempfile temp2
save `temp2', replace

use "`CCRX'_DataViz.dta"
append using `temp2'
capture order d_`indicator'_`group', after(`indicator'_`group')
save "`CCRX'_DataViz.dta", replace
restore
}
}
}
*

******************************************************************************************************************
* 1b. ALL current users
*     MARRIED current users
****************************************************************************************************************** 

use `temp', replace

*All women | Married women
foreach group in all mar {
*Each grouping
foreach var in total age5 married umsexactive parity3 ur school wealth region {

preserve
keep if `group'==1
*Updated 4/24/18: add EC and sayana press to method mix (change current_method_recode2 to current_method_recode)
*				  changed injectables_group to dmpa_group and dmpasc_group; added ec_group
keep if current_method_recode!=.

collapse (mean) ster_`group'=m1 ///
             implant_`group'=m2 ///
                 IUD_`group'=m3 ///
                dmpa_`group'=m4 ///
		      dmpasc_`group'=m5 ///
                pill_`group'=m6 ///
		          ec_`group'=m7 ///
              condom_`group'=m8 ///
        other_modern_`group'=m9 /// 
[aw=FQweight], by(`var')

*Methods
replace ster_`group'=ster_`group'*100 
replace implant_`group'=implant_`group'*100 
replace IUD_`group'=IUD_`group'*100 
replace dmpa_`group'=injectables_`group'*100
replace dmpasc_`group'=injectables_`group'*100  
replace pill_`group'=pill_`group'*100
replace ec_`group'=pill_`group'*100 
replace condom_`group'=condom_`group'*100 
replace other_modern_`group'=other_modern_`group'*100 
replace traditional_`group'=traditional_`group'*100  

*Drop irrelavent/ unused categories
capture drop if married==0
capture drop if umsexactive==0
capture drop if married==1 & cp_mar!=.

tempfile temp2
save `temp2', replace

use "`CCRX'_DataViz.dta"
append using `temp2'
save "`CCRX'_DataViz.dta", replace
restore

*Generate Denominators
foreach method in m1 m2 m3 m4 m5 m6 m7 m8 m9 {

preserve
keep if `group'==1
keep if current_method_recode!=.

bysort `var': egen d_`method'_`group'=count(_n) if `method'==1

collapse (mean) d_`method'_`group' [pw=FQweight], by(`var')

capture rename d_m1_`group' d_ster_`group'
capture rename d_m2_`group' d_implant_`group'
capture rename d_m3_`group' d_IUD_`group'
capture rename d_m4_`group' d_dmpa_`group'
capture rename d_m5_`group' d_dmpasc_`group'
capture rename d_m6_`group' d_pill_`group'
capture rename d_m7_`group' d_ec_`group'
capture rename d_m8_`group' d_condom_`group'
capture rename d_m9_`group' d_other_modern_`group'

}
}
}
* 

******************************************************************************************************************
* 1bb. ALL current MODERN users
*      MARRIED current MODERN users
****************************************************************************************************************** 

use `temp', replace
	
*All women | Married women
foreach group in all mar {
*Each grouping
foreach var in total age5 married umsexactive parity3 ur school wealth region {

preserve
keep if `group'==1
keep if mcp==1

collapse (mean) ///
 methodchoice_self_`group'=methodchoice_self /// 
methodchoice_joint_`group'=methodchoice_joint /// 
methodchoice_other_`group'=methodchoice_other ///   
	 fees_12months_`group'=fees_12months ///
	   fp_told_other_methods_`group'=fp_told_other_methods ///
             fp_side_effects_`group'=fp_side_effects ///
fp_side_effects_instructions_`group'=fp_side_effects_instructions ///
return_to_provider_`group'=return_to_provider ///
 refer_to_relative_`group'=refer_to_relative ///
   returnrefer_dir_`group'=returnrefer_dir ///
[aw=FQweight], by(`var')
 
*Methods choice
replace methodchoice_self_`group'=methodchoice_self_`group'*100
replace methodchoice_joint_`group'=methodchoice_joint_`group'*100
replace methodchoice_other_`group'=methodchoice_other_`group'*100
*Paid fees
replace fees_12months_`group'=fees_12months_`group'*100 
*Method info
replace fp_told_other_methods_`group'=fp_told_other_methods_`group'*100
replace fp_side_effects_`group'=fp_side_effects_`group'*100
replace fp_side_effects_instructions_`group'=fp_side_effects_instructions_`group'*100
*Would return and/or refer
replace return_to_provider_`group'=return_to_provider_`group'*100
replace refer_to_relative_`group'=refer_to_relative_`group'*100
replace returnrefer_dir_`group'=returnrefer_dir_`group'*100

*Drop irrelavent/ unused categories
capture drop if married==0
capture drop if umsexactive==0
capture drop if married==1 & cp_mar!=.
*Drop unused variables
capture drop methodchoice_self_mar
capture drop methodchoice_joint_mar
capture drop methodchoice_other_mar
capture drop return_to_provider_mar
capture drop refer_to_relative_mar
capture drop returnrefer_dir_mar

tempfile temp2
save `temp2', replace

use "`CCRX'_DataViz.dta"
append using `temp2'
save "`CCRX'_DataViz.dta", replace
restore
}
}
* 

******************************************************************************************************************
* 1c. ALL women with birth in past 5 years or pregnant
*     MARRIED women with birth in past 5 years or pregnant
******************************************************************************************************************

use `temp', replace

*All women | Married women
foreach group in all mar {
*Each grouping
foreach var in total age5 married umsexactive parity3 ur school wealth region {

preserve
keep if `group'==1
***ODK update
*keep if (birth_events>0 & birth_events!=. & tsinceb<60) | pregnant==1
keep if (children_born>0 & children_born!=. & tsinceb<60) | pregnant==1

collapse (mean) wanted_then_`group'=wanted_then ///
               wanted_later_`group'=wanted_later ///
                 wanted_not_`group'=wanted_not ///
[aw=FQweight], by(`var')

replace wanted_then_`group'=wanted_then_`group'*100 
replace wanted_later_`group'=wanted_later_`group'*100 
replace wanted_not_`group'=wanted_not_`group'*100 

*Drop irrelavent/ unused categories
capture drop if married==0
capture drop if umsexactive==0
capture drop if married==1 & cp_mar!=.

tempfile temp2
save `temp2', replace

use "`CCRX'_DataViz.dta"
append using `temp2'
save "`CCRX'_DataViz.dta", replace
restore
}
}
* 

******************************************************************************************************************
* Section C. Format new dataset
******************************************************************************************************************

clear
use "`CCRX'_DataViz.dta"
*Create columns for Country, Round, Date
replace Country="`country'"
gen Round="`round'"
order Round, after(Country)
gen Date="`date'"
order Date, after(Round)

*Replace numbers with Labels before moving to Category column
foreach var in total age5 married umsexactive parity3 ur school wealth region {
tostring `var', force replace
}

*Same categories for all countries
replace total="All" if total=="1" & (cp_all==. | cp_mar==.)
replace age5="15-19" if age5=="3"
replace age5="20-24" if age5=="4"
replace age5="25-29" if age5=="5"
replace age5="30-34" if age5=="6"
replace age5="35-39" if age5=="7"
replace age5="40-44" if age5=="8"
replace age5="45-49" if age5=="9"
replace married="Married, or in union" if married=="1"
*drop if married=="0"
replace umsexactive="Unmarried, sexually active" if umsexactive=="1"
*drop if umsexactive=="0"
replace parity="0-1 children" if parity=="0"
replace parity="2-3 children" if parity=="1"
replace parity="4+ children" if parity=="2"
replace ur="Urban" if ur=="1"
replace ur="Rural" if ur=="2"
replace wealth="Lowest" if wealth=="1"
replace wealth="Lower" if wealth=="2"
replace wealth="Middle" if wealth=="3"
replace wealth="High" if wealth=="4"
replace wealth="Highest" if wealth=="5"

*Country-specific categories
*school
                  replace school="Never" if school=="0" & Country=="Burkina"
		        replace school="Primary" if school=="1" & Country=="Burkina"
      replace school="Secondary 1 Cycle" if school=="2" & Country=="Burkina"
     replace school="Secondary 2 Cycles" if school=="3" & Country=="Burkina"
               replace school="Tertiary" if school=="4" & Country=="Burkina"
			   
			      replace school="Never" if school=="0" & (Country=="DRC_Kinshasa" | Country=="DRC_KongoCentral")
			    replace school="Primary" if school=="1" & (Country=="DRC_Kinshasa" | Country=="DRC_KongoCentral")
		      replace school="Secondary" if school=="2" & (Country=="DRC_Kinshasa" | Country=="DRC_KongoCentral")
		  	   replace school="Tertiary" if school=="3" & (Country=="DRC_Kinshasa" | Country=="DRC_KongoCentral")
			   
                  replace school="Never" if school=="0" & Country=="Ethiopia"
                replace school="Primary" if school=="1" & Country=="Ethiopia"
              replace school="Secondary" if school=="2" & Country=="Ethiopia"
 replace school="Technical & vocational" if school=="3" & Country=="Ethiopia"
                 replace school="Higher" if school=="4" & Country=="Ethiopia"
				 
				  replace school="Never" if school=="0" & Country=="Ghana"
                replace school="Primary" if school=="1" & Country=="Ghana"
          replace school="Middle School" if school=="2" & Country=="Ghana"
              replace school="Secondary" if school=="3" & Country=="Ghana"
                 replace school="Higher" if school=="4" & Country=="Ghana"

 		          replace school="Never" if school=="0" & Country=="Indonesia"
		        replace school="Primary" if school=="1" & Country=="Indonesia"
            replace school="Secondary_1" if school=="2" & Country=="Indonesia"
            replace school="Secondary_2" if school=="3" & Country=="Indonesia"
             replace school="University" if school=="4" & Country=="Indonesia"

 		          replace school="Never" if school=="0" & Country=="India_Rajasthan"
		        replace school="Primary" if school=="1" & Country=="India_Rajasthan"
              replace school="Secondary" if school=="2" & Country=="India_Rajasthan"
                 replace school="Higher" if school=="3" & Country=="India_Rajasthan"
               replace school="Postgrad" if school=="4" & Country=="India_Rajasthan"			 
			 
                  replace school="Never" if school=="0" & Country=="Kenya"
                replace school="Primary" if school=="1" & Country=="Kenya"
replace school="Post Primary Vocational" if school=="2" & Country=="Kenya"
              replace school="Secondary" if school=="3" & Country=="Kenya"
                replace school="College" if school=="4" & Country=="Kenya"
             replace school="University" if school=="5" & Country=="Kenya"
			 
                  replace school="Never" if school=="0" & (Country=="Niger_Niamey" | Country=="Niger_National")
		        replace school="Primary" if school=="1" & (Country=="Niger_Niamey" | Country=="Niger_National")
              replace school="Secondary" if school=="2" & (Country=="Niger_Niamey" | Country=="Niger_National")
               replace school="Tertiary" if school=="3" & (Country=="Niger_Niamey" | Country=="Niger_National")

			      replace school="Never" if school=="0" & (Country=="Nigeria_Kaduna" | Country=="Nigeria_Lagos" | Country=="Nigeria_`state'" | Country=="Nigeria") 
		        replace school="Primary" if school=="1" & (Country=="Nigeria_Kaduna" | Country=="Nigeria_Lagos" | Country=="Nigeria_`state'" | Country=="Nigeria") 
              replace school="Secondary" if school=="2" & (Country=="Nigeria_Kaduna" | Country=="Nigeria_Lagos" | Country=="Nigeria_`state'" | Country=="Nigeria") 
                 replace school="Higher" if school=="3" & (Country=="Nigeria_Kaduna" | Country=="Nigeria_Lagos" | Country=="Nigeria_`state'" | Country=="Nigeria") 
			
			      replace school="Never" if school=="0" & Country=="Uganda"
                replace school="Primary" if school=="1" & Country=="Uganda"
              replace school="Secondary" if school=="2" & Country=="Uganda"
 replace school="Technical & vocational" if school=="3" & Country=="Uganda"
             replace school="University" if school=="4" & Country=="Uganda"
		
*region
replace region="Boucle_du_mouhoun" if region=="1" & Country=="Burkina"
         replace region="Cascades" if region=="2" & Country=="Burkina"
           replace region="Centre" if region=="3" & Country=="Burkina"
       replace region="Centre_Est" if region=="4" & Country=="Burkina"
      replace region="Centre_Nord" if region=="5" & Country=="Burkina"
     replace region="Centre_Ouest" if region=="6" & Country=="Burkina"
       replace region="Centre_Sud" if region=="7" & Country=="Burkina"
              replace region="Est" if region=="8" & Country=="Burkina"
    replace region="Hauts_Bassins" if region=="9" & Country=="Burkina"
            replace region="Nord" if region=="10" & Country=="Burkina"
 replace region="Plateau_Central" if region=="11" & Country=="Burkina"
           replace region="Sahel" if region=="12" & Country=="Burkina"
       replace region="Sud_Ouest" if region=="13" & Country=="Burkina"

         replace region="Kinshasa" if region=="1" & Country=="DRC_Kinshasa"
	replace region="Kongo Central" if region=="2" & Country=="DRC_Kongo_Central"
				 
            replace region="Addis" if region=="1" & Country=="Ethiopia"
           replace region="Amhara" if region=="2" & Country=="Ethiopia"
          replace region="Oromiya" if region=="3" & Country=="Ethiopia"
             replace region="SNNP" if region=="4" & Country=="Ethiopia"
           replace region="Tigray" if region=="5" & Country=="Ethiopia"
            replace region="Other" if region=="6" & Country=="Ethiopia"

          replace region="Ashanti" if region=="1" & Country=="Ghana"
      replace region="Brong Ahafo" if region=="2" & Country=="Ghana"
          replace region="Central" if region=="3" & Country=="Ghana"
          replace region="Eastern" if region=="4" & Country=="Ghana"
    replace region="Greater Accra" if region=="5" & Country=="Ghana"
         replace region="Northern" if region=="6" & Country=="Ghana"
       replace region="Upper East" if region=="7" & Country=="Ghana"
       replace region="Upper West" if region=="8" & Country=="Ghana"
            replace region="Volta" if region=="9" & Country=="Ghana"
         replace region="Western" if region=="10" & Country=="Ghana"

        replace region="Java-Bali" if region=="1" & Country=="Indonesia"
            replace region="Other" if region=="2" & Country=="Indonesia"

        replace region="Rajasthan" if region=="1" & Country=="India_Rajasthan"			
			
		  replace region="Bungoma" if region=="1" & Country=="Kenya"
          replace region="Kericho" if region=="2" & Country=="Kenya"
           replace region="Kiambu" if region=="3" & Country=="Kenya"
		   replace region="Kilifi" if region=="4" & Country=="Kenya"
            replace region="Kitui" if region=="5" & Country=="Kenya"
          replace region="Nairobi" if region=="6" & Country=="Kenya"
			replace region="Nandi" if region=="7" & Country=="Kenya"
          replace region="Nyamira" if region=="8" & Country=="Kenya"
            replace region="Siaya" if region=="9" & Country=="Kenya"
         replace region="Kakamega" if region=="10" & Country=="Kenya"
       replace region="West_Pokot" if region=="11" & Country=="Kenya"
			
           replace region="Niamey" if region=="1" & (Country=="Niger_National" | Country=="Niger_Niamey")
      replace region="Other urban" if region=="2" & Country=="Niger_National"
      replace region="Rural areas" if region=="3" & Country=="Niger_National"
		   
          replace region="Nigeria" if region=="1" & Country=="Nigeria_`state'"
		  
		  replace region="Kaduna" if region=="1" & Country=="Nigeria"
		   replace region="Lagos" if region=="2" & Country=="Nigeria"
		  replace region="Taraba" if region=="3" & Country=="Nigeria"
		    replace region="Kano" if region=="4" & Country=="Nigeria"
		  replace region="Rivers" if region=="5" & Country=="Nigeria"
		replace region="Nasarawa" if region=="6" & Country=="Nigeria"
		 replace region="Anambra" if region=="7" & Country=="Nigeria"
		  
  replace region="Central" if (region=="r1" | region=="1") & Country=="Uganda"
 replace region="Eastern" if (region=="r2" | region=="2")  & Country=="Uganda"
replace region="Northern" if (region=="r3" | region=="3")  & Country=="Uganda"
 replace region="Western" if (region=="r4" | region=="4")  & Country=="Uganda"

*Drop incorrect calculations for CDR1
foreach wanted in wanted_then_all wanted_later_all wanted_not_all wanted_then_mar wanted_later_mar wanted_not_mar{
replace `wanted'=. if Country=="DRC_Kinshasa" & Round=="Round 1"
}
*

*Create "Category" column
rename total Category
foreach x in age5 married umsexactive parity3 ur school wealth region {
replace `x'="" if `x'=="."
replace Category=`x' if `x'!=""
}
*
replace Category="" if Category=="."
drop if Category=="-99" | Category=="99" | Category==""

*Groupings: None (all), Age, Marital status, Parity, Residence, Education, Wealth quintile, Region
*Create "Grouping" column
gen Grouping="none" if Category!=""
replace Grouping="age" if age5!=""
replace Grouping="marital status" if married!=""
replace Grouping="marital status" if umsexactive!=""
replace Grouping="parity" if parity!=""
replace Grouping="residence" if ur!=""
replace Grouping="education" if school!=""
replace Grouping="wealth quintile or tertile" if wealth!=""
replace Grouping="region" if region!=""
order Grouping, after(Date)
foreach x in age5 married umsexactive parity ur school wealth region {
drop `x'
}
*

save "`CCRX'_DataViz.dta", replace

******************************************************************************************************************
* Section D. Split _all, _mar, & WASH datasets, and merge back together
******************************************************************************************************************

gen all=1 if cp_all!=. 
gen user=1 if ster_all!=.
gen user_modern=1 if methodchoice_self!=.
gen preg=1 if wanted_then_all!=.

gen mar=1 if cp_mar!=. 
gen m_user=1 if ster_mar!=.
gen m_user_modern=1 if fees_12months_mar!=.
gen m_preg=1 if wanted_then_mar!=.

*1a. ALL women
preserve
keep if all==1
keep Country Round Date Grouping Category ///
cp_all mcp_all tcp_all ///
unmettot_all unmetspace_all unmetlimit_all ///
totaldemand_all demandsatis_all ///
visited_by_health_worker_all visited_facility_fp_disc_all fp_discussion_all
gen id=_n
tempfile temp_all
save `temp_all.dta', replace 
restore 

*1b. ALL current users 
*SAS: removed injectables, added dmpa_all dmpasc_all ec_all
preserve
keep if user==1
keep Category ///
ster_all implant_all IUD_all dmpa_all dmpasc_all pill_all ec_all condom_all ///
other_modern_all traditional_all
gen id=_n + 100
tempfile temp_user
save `temp_user.dta', replace 
restore  

*1bb. ALL current MODERN users 
preserve
keep if user_modern==1
keep Category ///
methodchoice_self methodchoice_joint methodchoice_other ///
fp_told_other_methods_all fp_side_effects_all fp_side_effects_instructions_all ///
return_to_provider refer_to_relative returnrefer_dir ///
fees_12months_all
gen id=_n + 100
tempfile temp_user_modern
save `temp_user_modern.dta', replace 
restore 

*1c. ALL women with birth in past 5 years or pregnant 
preserve
keep if preg==1
keep Category ///
wanted_then_all wanted_later_all wanted_not_all
tempfile temp_preg
save `temp_preg.dta', replace 
restore 

*2a. MARRIED women 
preserve
keep if mar==1
keep Category ///
cp_mar mcp_mar tcp_mar ///
unmettot_mar unmetspace_mar unmetlimit_mar ///
totaldemand_mar demandsatis_mar ///
visited_by_health_worker_mar visited_facility_fp_disc_mar fp_discussion_mar
tempfile temp_mar
save `temp_mar.dta', replace
restore

*2b. MARRIED current users
*SAS: removed injectables, added dmpa_mar dmpasc_mar ec_mar
preserve
keep if m_user==1
keep Category ///
ster_mar implant_mar IUD_mar dmpa_mar dmpasc_mar pill_mar ec_mar condom_mar ///
other_modern_mar traditional_mar 
tempfile temp_m_user
save `temp_m_user.dta', replace 
restore 

*2bb. MARRIED current users
preserve
keep if m_user_modern==1
keep Category ///
fp_told_other_methods_mar fp_side_effects_mar fp_side_effects_instructions_mar ///
fees_12months_mar
tempfile temp_m_user_modern
save `temp_m_user_modern.dta', replace 
restore

*2c. MARRIED women with birth in past 5 years or pregnant 
preserve
keep if m_preg==1
keep Category ///
wanted_then_mar wanted_later_mar wanted_not_mar
tempfile temp_m_preg
save `temp_m_preg.dta', replace 
*restore 

                     use `temp_all.dta'
merge 1:1 Category using `temp_user.dta', gen(merge_user)
merge 1:1 Category using `temp_user_modern.dta', gen(merge_user_modern)
merge 1:1 Category using `temp_preg.dta', gen(merge_preg)

merge 1:1 Category using `temp_mar.dta', gen(merge_mar)
merge 1:1 Category using `temp_m_user.dta', gen(merge_m_user)
merge 1:1 Category using `temp_m_user_modern.dta', gen(merge_m_user_modern)
merge 1:1 Category using `temp_m_preg.dta', gen(merge_m_preg)
sort id
drop id merge_user merge_user_modern merge_preg merge_mar merge_m_user merge_m_user_modern merge_m_preg

foreach var in cp mcp tcp ///
visited_by_health_worker visited_facility_fp_disc fp_discussion ///
fp_told_other_methods fp_side_effects fp_side_effects_instructions ///
visited_by_health_worker visited_facility_fp_disc fp_discussion {
order `var'_mar, after(`var'_all)
}
order ster_all-traditional_all, after(tcp_mar)
order ster_mar-traditional_mar, after(traditional_all)
order unmettot_all, after(unmetlimit_all)
order unmettot_mar-unmetlimit_mar, after(unmettot_all)
order unmettot_mar, after(unmetlimit_mar)
order totaldemand_mar-demandsatis_mar, after(demandsatis_all)
order wanted_then_all-wanted_not_mar, after(demandsatis_mar)
order methodchoice_self-methodchoice_other, after(wanted_not_mar)
order fees_12months_all, after(methodchoice_other)
order fees_12months_mar, after(fees_12months_all)
order fp_told_other_methods_all-fp_side_effects_instructions_mar, after(fees_12months_mar)
order return_to_provider-returnrefer_dir, after(fp_side_effects_instructions_mar)

save "`CCRX'_DataViz.dta", replace
exit


