/******************************************************************************************************************
RESPONSE RATES/SAMPLE ERROR GENERATION FILE

Generates tables for response rates and sample error estimates
******************************************************************************************************************/

*Set up tempfile
cd "$datadir"
tempfile temp
save `temp', replace
use `temp'

	
*Country Code
local CCRX $CCRX
local country $country
local round $round
local today $today
local date $date

*Generate groups for all & married analyses 
gen all=1 if FRS_result==1
gen mar=1 if FRS_result==1 & married==1

save `temp', replace

/******************************************************************************************************************
Generate Response Rates
******************************************************************************************************************/

* Household Response Rates
preserve
keep if metatag==1
keep HHQ_result ur

recode HHQ_result (nonmiss=1), gen(HHQ_selected)
recode HHQ_result (1 2 3 4 5=1) (nonmiss=.), gen(HHQ_occupied)
recode HHQ_result (1=1) (nonmiss=.), gen(HHQ_completed)

collapse (count) HHQ_selected HHQ_occupied HHQ_completed, by(ur)

set obs 3
replace ur=3 if ur==.
	label define ur_tot 1 "1. urban" 2 "2. rural" 3 "3. total"
	label val ur ur_tot

foreach v in HHQ_selected HHQ_occupied HHQ_completed {
	egen `v'_total=sum(`v')
	replace `v'=`v'_total if ur==3
	drop `v'_total
	}
	
gen HHQ_response=(HHQ_completed/HHQ_occupied)

save "`CCRX'_SOITable_ResponseRates.dta", replace
restore

* Female Response Rates
preserve
capture confirm last_night
if _rc==0 {
	gen last_night=1 if usual_member==1 | usual_member==3
	}

keep eligible HHQ_result last_night FRS_result ur
	
recode eligible (1=1) (nonmiss=.) if HHQ_result==1 & last_night==1, gen(FQeligible_total) 
recode eligible (1=1) (nonmiss=1) if HHQ_result==1 & FRS_result==1 & last_night==1, gen(FQeligible_interviewed)
gen FQresponse_0=1 if eligible==1 & HHQ_result==1 & last_night==1
gen FQresponse_1=1 if FRS_result==1 & eligible==1 & HHQ_result==1 & last_night==1

collapse (count) FQeligible_total FQeligible_interviewed FQresponse_1 FQresponse_0, by(ur)

set obs 3
replace ur=3 if ur==.
	label val ur ur_tot
	
foreach v in FQeligible_total FQeligible_interviewed FQresponse_1 FQresponse_0 {
	egen `v'_total=sum(`v')
	replace `v'=`v'_total if ur==3
	drop `v'_total
	}

gen FQ_response=(FQresponse_1/FQresponse_0)
	drop FQresponse_1 FQresponse_0
	
tempfile FQ_response
save `FQ_response', replace
restore

*Combine and generate dataset
preserve
use "`CCRX'_SOITable_ResponseRates.dta", clear
merge 1:1 ur using `FQ_response'
drop _merge
save, replace
export delimited using "$csv_results/`CCRX'_HHQFQ_SOITable_ResponseRates_$today", replace
restore

/******************************************************************************************************************
Generate Sample Error Estimates
******************************************************************************************************************/
*Generate Dataset In Which To Enter Values
preserve
clear
set obs 13
gen measure="mcp" in 1
	replace measure="tcp" in 2
	replace measure="cp" in 3
	replace measure="dmpa" in 4
	replace measure="dmpasc" in 5
	replace measure="condom" in 6
	replace measure="implant" in 7
	replace measure="methodchosen" in 8
	replace measure="fees_12months" in 9
	replace measure="fp_told_other_methods" in 10
	replace measure="fp_side_effects" in 11
	replace measure="returnrefer" in 12
	replace measure="visited_by_hw" in 13

foreach group in all mar {	
	gen mean_`group'=.
	gen standard_error_`group'=.
	gen ci_lowerbound_`group'=.
	gen ci_upperbound_`group'=.
	}
	
	save "`CCRX'_SOITable_SampleError_$today.dta", replace
restore

use `temp'

*Rename some variables	
rename m4 dmpa
capture rename m5 dmpasc
rename m8 condom
rename visited_by_health_worker visited_by_hw

save `temp', replace

****All women****
*All women | Married women
foreach group in all mar {
	
	*Generate matrix for mean, standard error, upper and lower bounds of 95% CI
	foreach measure in mcp tcp cp dmpa dmpasc condom implant visited_by_hw  {
		use `temp', clear

		*svy Set
		capture confirm strata
		if _rc!=0 {
			svyset EA_ID [pw=FQweight], singleunit(scaled)
			}
		else { 
			svyset EA_ID [pw=FQweight], strata(strata) singleunit(scaled)
			}		
		
		preserve
		keep if `group'==1
		
		svy: mean `measure'
		matrix `measure'_mean_`group'=e(b)
		matrix `measure'_se_`group'=_se[`measure']
		matrix `measure'_lb_`group'= _b[`measure']-invttail(e(df_r),0.025)*_se[`measure']
		matrix `measure'_ub_`group'= _b[`measure']+invttail(e(df_r),0.025)*_se[`measure']
		
		use "`CCRX'_SOITable_SampleError_$today.dta", clear
		
		replace mean_`group'=`measure'_mean_`group'[1,1] if measure=="`measure'"
		replace standard_error_`group'=`measure'_se_`group'[1,1] if measure=="`measure'"
		replace ci_lowerbound_`group'=`measure'_lb_`group'[1,1] if measure=="`measure'"			
		replace ci_upperbound_`group'=`measure'_ub_`group'[1,1] if measure=="`measure'"

		save, replace
		restore
		}
	}

****Modern Users****

*All women | Married women
foreach group in all mar {
	*Generate matrix for mean, standard error, upper and lower bounds of 95% CI
	foreach measure in methodchosen  {
		use `temp', clear

		*svy Set
		capture confirm strata
		if _rc!=0 {
			svyset EA_ID [pw=FQweight], singleunit(scaled)
			}
		else { 
			svyset EA_ID [pw=FQweight], strata(strata) singleunit(scaled)
			}		
			
		preserve
		keep if `group'==1
		keep if mcp==1
		
		svy: mean `measure'
		matrix `measure'_mean_`group'=e(b)
		matrix `measure'_se_`group'=_se[`measure']
		matrix `measure'_lb_`group'= _b[`measure']-invttail(e(df_r),0.025)*_se[`measure']
		matrix `measure'_ub_`group'= _b[`measure']+invttail(e(df_r),0.025)*_se[`measure']

		use "`CCRX'_SOITable_SampleError_$today.dta", clear
				
		replace mean_`group'=`measure'_mean_`group'[1,1] if measure=="`measure'"
		replace standard_error_`group'=`measure'_se_`group'[1,1] if measure=="`measure'"
		replace ci_lowerbound_`group'=`measure'_lb_`group'[1,1] if measure=="`measure'"
		replace ci_upperbound_`group'=`measure'_ub_`group'[1,1] if measure=="`measure'"

		save, replace		
		restore
		}
	}

****Current Users****
*All women | Married women
foreach group in all mar {
	
	*Generate matrix for mean, standard error, upper and lower bounds of 95% CI
	foreach measure in fees_12months fp_told_other_methods fp_side_effects returnrefer {
		use `temp', clear
	
		*svy Set
		capture confirm strata
		if _rc!=0 {
		svyset EA_ID [pw=FQweight], singleunit(scaled)
			}
		else { 
			svyset EA_ID [pw=FQweight], strata(strata) singleunit(scaled)
			}
		
		preserve
		keep if `group'==1
		keep if cp==1
		

		svy: mean `measure'
		matrix `measure'_mean_`group'=e(b)
		matrix `measure'_se_`group'=_se[`measure']
		matrix `measure'_lb_`group'= _b[`measure']-invttail(e(df_r),0.025)*_se[`measure']
		matrix `measure'_ub_`group'= _b[`measure']+invttail(e(df_r),0.025)*_se[`measure']
		
		use "`CCRX'_SOITable_SampleError_$today.dta", clear

		replace mean_`group'=`measure'_mean_`group'[1,1] if measure=="`measure'"
		replace standard_error_`group'=`measure'_se_`group'[1,1] if measure=="`measure'"
		replace ci_lowerbound_`group'=`measure'_lb_`group'[1,1] if measure=="`measure'"
		replace ci_upperbound_`group'=`measure'_ub_`group'[1,1] if measure=="`measure'"
			
		save, replace
		restore
		}
	}

use "`CCRX'_SOITable_SampleError_$today.dta", clear
export delimited using "$csv_results/`CCRX'_HHQFQ_SOITable_SampleError_$today", replace

use "`analysisdata'/GHR5_HHQFQ_AnalysisData.dta", clear
