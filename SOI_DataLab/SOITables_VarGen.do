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
local date $date

*Recode return/ refer
recode return_to_provider -88=0
recode refer_to_relative -88=0

*Save country dataset as temp dataset 
tempfile temp
save `temp', replace

*Create blank dataset
clear
gen Country="`country'"
save "`CCRX'_SOIPrep_vargen.dta", replace

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
* Section 2. Background Characteristics
******************************************************************************************************************
foreach var in age5 married umsexactive parity3 ur school wealth region {
	preserve
	
	collapse (count) one [pw=FQweight], by(`var')
	egen total=sum(one) 
	gen percent_`var'=(one/total)*100
	gen count_weighted_`var'=one
	drop one
	drop total
	
	tempfile temp2
	save `temp2', replace

	use "`CCRX'_SOIPrep_vargen.dta"
	append using `temp2'
	save "`CCRX'_SOIPrep_vargen.dta", replace
	restore
	
	preserve
	
	collapse (count) one, by(`var')
	gen count_unweighted_`var'=one
	drop one
	
	tempfile temp2
	save `temp2', replace

	use "`CCRX'_SOIPrep_vargen.dta"
	append using `temp2'
	save "`CCRX'_SOIPrep_vargen.dta", replace
	restore
	}
		
****************************************************************************************************************** 
* Section 3. ALL women
*	  	     MARRIED women
****************************************************************************************************************** 

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

		use "`CCRX'_SOIPrep_vargen.dta"
		append using `temp2'
		save "`CCRX'_SOIPrep_vargen.dta", replace
		restore
		
		*Generate denominators
		preserve
		keep if `group'==1
		
		collapse (count) d_cp_`group'=cp ///
						 d_mcp_`group'=mcp ///
						 d_tcp_`group'=tcp ///
						 d_unmettot_`group'=unmettot ///
						 d_unmetspace_`group'=unmetspace ///
						 d_unmetlimit_`group'=unmetlimit ///
						 d_totaldemand_`group'=totaldemand ///
						 d_demandsatis_`group'=demandsatis ///
						 d_visited_by_health_worker_`group'=visited_by_health_worker ///
						 d_visited_facility_fp_disc_`group'=visited_facility_fp_disc ///
						 d_fp_discussion_`group'=fp_discussion, ///
						 by(`var')
		
		*Drop irrelavent/ unused categories
		capture drop if married==0
		capture drop if umsexactive==0
		capture drop if married==1 & cp_mar!=.

		tempfile temp2
		save `temp2', replace

		use "`CCRX'_SOIPrep_vargen.dta"
		append using `temp2'
		foreach indicator in cp mcp tcp ///
			unmettot unmetspace unmetlimit totaldemand demandsatis ///
			visited_by_health_worker visited_facility_fp_disc fp_discussion {
			capture order d_`indicator'_`group', after(`indicator'_`group')
			}
		save "`CCRX'_SOIPrep_vargen.dta", replace
		restore
			 
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
				 traditional_`group'=m10 ///
				[aw=FQweight], by(`var')

		*Methods
		replace ster_`group'=ster_`group'*100 
		replace implant_`group'=implant_`group'*100 
		replace IUD_`group'=IUD_`group'*100 
		replace dmpa_`group'=dmpa_`group'*100
		replace dmpasc_`group'=dmpasc_`group'*100  
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

		use "`CCRX'_SOIPrep_vargen.dta"
		append using `temp2'
		save "`CCRX'_SOIPrep_vargen.dta", replace
		restore

		*Generate Denominators
		preserve
		keep if `group'==1
		keep if current_method_recode!=.
		
		collapse (count) d_ster_`group'=m1 ///
						d_implant_`group'=m2 ///
						d_IUD_`group'=m3 ///
						d_dmpa_`group'=m4 ///
						d_dmpasc_`group'=m5 ///
						d_pill_`group'=m6 ///
						d_ec_`group'=m7 ///
						d_condom_`group'=m8 ///
						d_other_modern_`group'=m9 ///
						d_traditional_`group'=m10, ///
						by(`var')

		*Drop irrelavent/ unused categories
		capture drop if married==0
		capture drop if umsexactive==0
		capture drop if married==1 & cp_mar!=.

		tempfile temp2	
		save `temp2', replace

		use "`CCRX'_SOIPrep_vargen.dta"
		append using `temp2'
		foreach method in ster implant IUD dmpa dmpasc pill ec condom other_modern traditional {
			capture order d_`method'_`group', after(`method'_`group')
			}
		save "`CCRX'_SOIPrep_vargen.dta", replace
		restore
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

		use "`CCRX'_SOIPrep_vargen.dta"
		append using `temp2'
		save "`CCRX'_SOIPrep_vargen.dta", replace
		restore
		
		*Generate Denominators
		preserve
		keep if `group'==1
		keep if mcp==1
		
		collapse (count) ///
			d_methodchoice_self_`group'=methodchoice_self /// 
			d_methodchoice_joint_`group'=methodchoice_joint /// 
			d_methodchoice_other_`group'=methodchoice_other ///   
			d_fees_12months_`group'=fees_12months ///
			d_fp_told_other_methods_`group'=fp_told_other_methods ///
			d_fp_side_effects_`group'=fp_side_effects ///
			d_fp_sideeffects_instruct_`group'=fp_side_effects_instructions ///
			d_return_to_provider_`group'=return_to_provider ///
			d_refer_to_relative_`group'=refer_to_relative ///
			d_returnrefer_dir_`group'=returnrefer_dir, ///
			by(`var')
			
		*Drop irrelavent/ unused categories
		capture drop if married==0
		capture drop if umsexactive==0
		capture drop if married==1 & cp_mar!=.
		
		*Drop unused variables
		capture drop d_methodchoice_self_mar
		capture drop d_methodchoice_joint_mar
		capture drop d_methodchoice_other_mar
		capture drop d_return_to_provider_mar
		capture drop d_refer_to_relative_mar
		capture drop d_returnrefer_dir_mar
			
		tempfile temp2
		save `temp2', replace

		use "`CCRX'_SOIPrep_vargen.dta"
		append using `temp2'
		foreach option in methodchoice_self methodchoice_joint methodchoice_other ///
			fees_12months fp_told_other_methods fp_side_effects ///
			return_to_provider refer_to_relative returnrefer_dir {
			capture order d_`option'_`group', after(`option'_`group')
			}
		capture order d_fp_sideffects_instruct_`group', after(fp_side_effects_instructions_`group')
		save "`CCRX'_SOIPrep_vargen.dta", replace
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

		use "`CCRX'_SOIPrep_vargen.dta"
		append using `temp2'
		save "`CCRX'_SOIPrep_vargen.dta", replace
		restore
		
		*Generate Denominators
		preserve
		keep if `group'==1
		***ODK update
		*keep if (birth_events>0 & birth_events!=. & tsinceb<60) | pregnant==1
		keep if (children_born>0 & children_born!=. & tsinceb<60) | pregnant==1		
		
		collapse (count) ///
			d_wanted_then_`group'=wanted_then ///
			d_wanted_later_`group'=wanted_later ///
			d_wanted_not_`group'=wanted_not, ///
			by(`var')
			
		*Drop irrelavent/ unused categories
		capture drop if married==0
		capture drop if umsexactive==0
		capture drop if married==1 & cp_mar!=.	
			
		tempfile temp2	
		save `temp2', replace

		use "`CCRX'_SOIPrep_vargen.dta"
		append using `temp2'
		foreach intention in wanted_then wanted_later wanted_not {
			capture order d_`intention'_`group', after(`intention'_`group')
			}
		save "`CCRX'_SOIPrep_vargen.dta", replace
		restore
		}
	}
* 
