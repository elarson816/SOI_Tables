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
clear all
set more off

*Directory
local analysisdata "/Users/ealarson/Dropbox (Gates Institute)/9 Data Management - Non-Francophone/Ghana/PMAGH_Datasets/Round5/Analysis"
global datadir "/Users/ealarson/Documents/Ghana/Data_NotShared/Round5/SOI/HHQFQ"
local dofiles "/Users/ealarson/Documents/RandomCoding/SOI_Tables"
global csv_results "$datadir/csv_results"
cd "$datadir"

*Macros for .do files subsequent .do files
local othertables "`dofiles'/SOITables_OtherTables.do"
local vargen "`dofiles'/SOITables_VarGen.do"
local countryspecific "`dofiles'/SOITables_CountrySpecific.do"
local formatting "`dofiles'/SOITables_Formatting.do"

*Date Macro
local today=c(current_date)
local c_today= "`today'"
global today=subinstr("`c_today'", " ", "",.)

/*BFR1
use "`analysisdata'/BFR1_HHQFQ_AnalysisData.dta", clear
global country "Burkina"
global round "Round 1"
global date "2014-12"
global CCRX "BFR1"
recode wealth 2=3 3=5
*/

/*BFR2
use "`analysisdata'/BFR2_HHQFQ_AnalysisData.dta", clear
global country "Burkina"
global round "Round 2"
global date "2015-05"
global CCRX "BFR2"
recode wealth 2=3 3=5
*/

/*BFR3
use "`analysisdata'/BFR3_HHQFQ_AnalysisData.dta", clear
global country "Burkina"
global round "Round 3"
global date "2016-05"
global CCRX "BFR3"
recode wealth 2=3 3=5
*/

/*BFR4
use "`analysisdata'/BFR4_HHQFQ_AnalysisData.dta", clear
global country "Burkina"
global round "Round 4"
global date "2016-12"
global CCRX "BFR4"
recode wealth 2=3 3=5
*/

/*CDR1
*use "`analysisdata'/CDR1_HHQFQ_AnalysisData.dta", clear
use "~/Dropbox (Gates Institute)/Gates/CDR1_HHQFQ_AnalysisData.dta"
*Set macros for country and round
global country "DRC_Kinshasa"
global round "Round 1"
global date "2014-01"
global CCRX "CDR1"
gen ur=1
gen region=1
gen tsinceb=70
*/

/*CDR2
use "`analysisdata'/CDR2_HHQFQ_AnalysisData.dta", clear
*Set macros for country and round
global country "DRC_Kinshasa"
global round "Round 2"
global date "2014-09"
global CCRX "CDR2"
gen ur=1
gen region=1
*Recode school
*recode school 0=0 1=1 2 4=2 3 5 6=3 -99=-99
*label define schoolcdr11 0 "Never attended" 1 "Primary" 2 "Secondary" 3 "Superior" -99 "-99", replace
*/

/*CDR3
use "`analysisdata'/CDR3_HHQFQ_AnalysisData.dta", clear
*Set macros for country and round
global country "DRC_Kinshasa"
global round "Round 3"
global date "2015-06"
global CCRX "CDR3"
*gen ur=1
gen region=1
*/

/*CDR4 -- Kinshasa
use "`analysisdata'/CDR4_HHQFQ_AnalysisData_kin.dta", clear
*Set macros for country and round
global country "DRC_Kinshasa"
global round "Round 4"
global date "2015-12"
global CCRX "CDR4_Kinshasa"
gen region=1
label def region_list 1 "Kinshasa"
label val region region_list
*/

/*CDR4 -- Kongo Central
use "`analysisdata'/CDR4_HHQFQ_AnalysisData_KC.dta", clear
*Set macros for country and round
global country "DRC_Kongo_Central"
global round "Round 4"
global date "2015-12"
global CCRX "CDR4_KC"
gen region=2
label def region_list 2 "Kongo Central"
label val region region_list
*/

/*CDR5 -- Kinshasa
use "`analysisdata'/CDR5_Kinshasa_HHQFQ_AnalysisData.dta", clear
*Set macros for country and round
global country "DRC_Kinshasa"
global round "Round 5"
global date "2016-09"
global CCRX "CDR5_Kinshasa"
gen region=1
label def region_list 1 "Kinshasa"
label val region region_list
*/

/*CDR5 -- Kongo Central
use "`analysisdata'/CDR5_KongoCentral_HHQFQ_AnalysisData.dta", clear
*Set macros for country and round
global country "DRC_KongoCentral"
global round "Round 5"
global date "2016-09"
global CCRX "CDR5_KC"
gen region=2
label def region_list 2 "Kongo Central"
label val region region_list
*/

/*ETR1
use "`analysisdata'/ETR1_HHQFQ_AnalysisData.dta", clear
global country "Ethiopia"
global round "Round 1"
global date "2014-03"
global CCRX "ETR1"
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
use "`analysisdata'/ETR2_HHQFQ_AnalysisData.dta", clear
global country "Ethiopia"
global round "Round 2"
global date "2014-10"
global CCRX "ETR2"
recode school -88=-99
gen region_soi=region
recode region_soi 10=1 3=2 4=3 7=4 1=5 2=6 5=6 6=6 8=6 9=6 11=6
label define region_soi_list 1 addis 2 amhara 3 oromiya 4 snnp 5 tigray 6 other
labe val region_soi region_soi_list
drop region
rename region_soi region
*/

/*ETR3
use "`analysisdata'/ETR3_HHQFQ_AnalysisData.dta", clear
global country "Ethiopia"
global round "Round 3"
global date "2015-05"
global CCRX "ETR3"
recode school -88=-99
gen region_soi=region
recode region_soi 10=1 3=2 4=3 7=4 1=5 2=6 5=6 6=6 8=6 9=6 11=6
label define region_soi_list 1 addis 2 amhara 3 oromiya 4 snnp 5 tigray 6 other
labe val region_soi region_soi_list
drop region
rename region_soi region
*/

/*ETR4
use "`analysisdata'/ETR4_HHQFQ_AnalysisData.dta", clear
global country "Ethiopia"
global round "Round 4"
global date "2016-04"
global CCRX "ETR4"
recode school -88=-99
gen region_soi=region
recode region_soi 10=1 3=2 4=3 7=4 1=5 2=6 5=6 6=6 8=6 9=6 11=6
label define region_soi_list 1 addis 2 amhara 3 oromiya 4 snnp 5 tigray 6 other
labe val region_soi region_soi_list
drop region
rename region_soi region
*/

/*GHR1
use "`analysisdata'/GHR1_HHQFQ_AnalysisData.dta", clear
global country "Ghana"
global round "Round 1"
global date "2013-10"
global CCRX "GHR1"
*/

/*GHR2
use "`analysisdata'/GHR2_HHQFQ_AnalysisData.dta", clear
global country "Ghana"
global round "Round 2"
global date "2014-05"
global CCRX "GHR2"
rename fees_6months fees_12months
*/

/*GHR3
use "`analysisdata'/GHR3_HHQFQ_AnalysisData.dta", clear
global country "Ghana"
global round "Round 3"
global date "2014-12"
global CCRX "GHR3"
*/

/*GHR4
use "`analysisdata'/GHR4_HHQFQ_AnalysisData.dta", clear
global country "Ghana"
global round "Round 4"
global date "2015-06"
global CCRX "GHR4"
*/

*GHR5
use "`analysisdata'/GHR5_HHQFQ_AnalysisData.dta", clear
global country "Ghana"
global round "Round 5"
global date "2016-08"
global CCRX "GHR5"
recode current_method_recode 11=9 32=10
*/

/*IDR1
use "`analysisdata'/IDR1_HHQFQ_AnalysisData.dta", clear
*Set macros for country and round
global country "Indonesia"
global round "Round 1"
global date "2015-08"
global CCRX "IDR1"
drop wealthquintile_SS wealthquintile_MK
recode school 5=4
*/

/*INR1_Rajasthan
use "`analysisdata'/RJR1_HHQFQ_AnalysisData.dta", clear
*Set macros for country and round
global country "India_Rajasthan"
global round "Round 1"
global date "2016-05"
global CCRX "INR1_Rajasthan"
gen region=1
*/

/*INR2_Rajasthan
use "`analysisdata'/RJR2_HHQFQ_AnalysisData.dta", clear
*Set macros for country and round
global country "India_Rajasthan"
global round "Round 2"
global date "2017-04"
global CCRX "INR2_Rajasthan"
gen region=1
*/

/*KER1
use "`analysisdata'/KER1_HHQFQ_AnalysisData.dta", clear
global country "Kenya"
global round "Round 1"
global date "2014-07"
global CCRX "KER1"
*/

/*KER2
use "`analysisdata'/KER2_HHQFQ_AnalysisData.dta", clear
global country "Kenya"
global round "Round 2"
global date "2014-12"
global CCRX "KER2"
*/

/*KER3
use "`analysisdata'/KER3_HHQFQ_AnalysisData.dta", clear
global country "Kenya"
global round "Round 3"
global date "2015-07"
global CCRX "KER3"
*/

/*KER4
use "`analysisdata'/KER4_HHQFQ_AnalysisData.dta", clear
global country "Kenya"
global round "Round 4"
global date "2015-11"
global CCRX "KER4"
*/

/*KER5
use "`analysisdata'/KER5_HHQFQ_AnalysisData.dta"
global country "Kenya"
global round "Round 5"
global date "2016-11"
global CCRX "KER5"
*/

/*NER1
use "`analysisdata'/NER1_HHQFQ_AnalysisData.dta", clear
*Set macros for country and round
global country "Niger_Niamey"
global round "Round 1"
global date "2015-08"
global CCRX "NER1"
recode wealthtertile 1=1 2=3 3=5 
*/

/*NER2
*use "`analysisdata'/NER2_National_HHQFQ_AnalysisData.dta"
use "/Users/Sally/Downloads/NER2_National_HHQFQ_AnalysisData.dta"
*Set macros for country and round
global country "Niger_National"
global round "Round 2"
global date "2016-04"
global CCRX "NER2"
*/
/*Set macros for country and round
global country "Niger_Niamey"
global round "Round 2"
global date "2016-04"
global CCRX "NER2_Niamey"
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
use "`analysisdata'/NER3_Niamey_HHQFQ_AnalysisData.dta", clear
global country "Niger_Niamey"
global round "Round 3"
global date "2016-11"
global CCRX "NER3"
recode wealthtertile 1=1 2=3 3=5 
rename level1 region
*/

/*NGR1 -- KADUNA
use "`analysisdata'/NGR1_HHQFQ_AnalysisData_Kaduna.dta", clear
*Set macros for country and round
global country "Nigeria_Kaduna"
global round "Round 1"
global date "2014-10"
global CCRX "NGR1_Kaduna"
*Generate variables neccessary for analysis
rename wealthquintile_Kaduna wealth 
tostring wealth, replace force
gen region=1
*/

/*NGR1 -- LAGOS
use "`analysisdata'/NGR1_HHQFQ_AnalysisData_Lagos.dta", clear
*Set macros for country and round
global country "Nigeria_Lagos"
global round "Round 1"
global date "2014-10"
global CCRX "NGR1_Lagos"
*Generate variables neccessary for analysis
rename wealthquintile_Lagos wealth 
tostring wealth, replace force
gen region=1
*/

/*NGR2 -- KADUNA
use "`analysisdata'/NGR2_HHQFQ_AnalysisData_Kaduna.dta", clear
*Set macros for country and round
global country "Nigeria_Kaduna"
global round "Round 2"
global date "2015-09"
global CCRX "NGR2_Kaduna"
gen region=1
*/

/*NGR2 -- LAGOS
use "`analysisdata'/NGR2_HHQFQ_AnalysisData_Lagos.dta", clear
*Set macros for country and round
global country "Nigeria_Lagos"
global round "Round 2"
global date "2015-09"
global CCRX "NGR2_Lagos"
gen region=1
*/

/*NGR3_states
use "`analysisdata'/NGR3_HHQFQ_AnalysisData.dta", clear
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
global country "Nigeria_`state'"
global round "Round 3"
global date "2016-06"
global CCRX "NGR3_`state'"
gen region=1
drop HHweight FQweight wealthquintile
rename HHweight_`state' HHweight
rename FQweight_`state' FQweight
rename wealthquintile_`state' wealth
*/

/*NGR3_national
use "`analysisdata'/NGR3_HHQFQ_AnalysisData_IC.dta"
global country "Nigeria"
global round "Round 3"
global date "2016-05"
global CCRX "NGR3"
rename HHweight_National HHweight
rename FQweight_National FQweight
rename wealthquintile_National wealth
rename state region
*/

/*UGR1
use "`analysisdata'/UGR1_HHQFQ_AnalysisData.dta", clear
*Set macros for country and round
global country "Uganda"
global round "Round 1"
global date "2014-06"
global CCRX "UGR1"
recode school 2=1 3=2 4=2 5=3 6=4
label define schooll 0 Never 1 Primary 2 Secondary 3 Technical_Vocational 4 University, replace
*/

/*UGR2
use "`analysisdata'/UGR2_HHQFQ_AnalysisData.dta", clear
*Set macros for country and round
global country "Uganda"
global round "Round 2"
global date "2015-02"
global CCRX "UGR2"
recode school 2=1 3=2 4=2 5=3 6=4
*/

/*UGR3
use "`analysisdata'/UGR3_HHQFQ_AnalysisData.dta", clear
*Set macros for country and round
global country "Uganda"
global round "Round 3"
global date "2015-11"
global CCRX "UGR3"
recode school 2=1 3=2 4=2 5=3 6=4
*/

/*UGR4
use "`analysisdata'/UGR4_HHQFQ_AnalysisData.dta", clear
*Set macros for country and round
global country "Uganda"
global round "Round 4"
global date "2016-05"
global CCRX "UGR4"
recode school 2=1 3=2 4=2 5=3 6=4
*/

/*UGR5
use "`analysisdata'/UGR5_HHQFQ_AnalysisData.dta", clear
*Set macros for country and round
global country "Uganda"
global round "Round 5"
global date "2017-05"
global CCRX "UGR5"
recode school 2=1 3=2 4=2 5=3 6=4
rename DHSregionnum region
*/


/******************************************************************************************************************
Run .do files
******************************************************************************************************************/
include `othertables'
include `vargen'
include `countryspecific'
include `formatting'
use "$datadir/`CCRX'_SOITable_DataViz.dta", clear
export delimited using "$csv_results/`CCRX'_HHQFQ_SOITable_$today", replace

