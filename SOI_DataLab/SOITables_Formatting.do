/******************************************************************************************************************
SOI TABLES ORDERING AND FORMATING

Format Data into wide version and order variables
******************************************************************************************************************/

clear
cd "$datadir"

*Country Code
local CCRX $CCRX
use "$datadir/`CCRX'_SOIPrep_countryspecific.dta", clear



gen percent=1 if percent_of_total!=.
gen unweighted=1 if unweighted_count!=.

capture drop all
gen all=1 if cp_all!=. 
gen user=1 if ster_all!=.
gen user_modern=1 if methodchoice_self!=.
gen preg=1 if wanted_then_all!=.

gen d_all=1 if d_cp_all!=.
gen d_user=1 if d_ster_all!=.
gen d_user_modern=1 if d_methodchoice_self!=.
gen d_preg=1 if d_wanted_then_all!=.

gen mar=1 if cp_mar!=. 
gen m_user=1 if ster_mar!=.
gen m_user_modern=1 if fees_12months_mar!=.
gen m_preg=1 if wanted_then_mar!=.

gen d_mar=1 if d_cp_mar!=.
gen d_m_user=1 if d_ster_mar!=.
gen d_m_user_modern=1 if d_fp_told_other_methods_mar!=.
gen d_m_preg=1 if d_wanted_then_mar!=.

*A. Background Characteristics
preserve
	keep if percent==1
	keep Category percent_of_total weighted_count
	gen id=_n
	tempfile temp_percent
	save `temp_percent.dta', replace
restore

preserve
	keep if unweighted==1
	keep Category unweighted_count
	gen id=_n
	tempfile temp_unweighted
	save `temp_unweighted.dta', replace
restore

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

*Denominators
preserve
	keep if d_all==1
	keep Country Round Date Grouping Category ///
		d_cp_all d_mcp_all d_tcp_all ///
		d_unmettot_all d_unmetspace_all d_unmetlimit_all ///
		d_totaldemand_all d_demandsatis_all ///
		d_visited_by_health_worker_all d_visited_facility_fp_disc_all d_fp_discussion_all
	gen id=_n
	tempfile temp_all_denom
	save `temp_all_denom.dta', replace 
restore 

*1b. ALL current users 
*SAS: removed injectables, added dmpa_all dmpasc_all ec_all
preserve
	keep if user==1
	keep Category ///
		ster_all implant_all IUD_all dmpa_all dmpasc_all pill_all ///
		ec_all condom_all other_modern_all traditional_all
	gen id=_n + 100
	tempfile temp_user
	save `temp_user.dta', replace 
restore  

*Denominators
preserve
	keep if d_user==1
	keep Category ///
		d_ster_all d_implant_all d_IUD_all d_dmpa_all d_dmpasc_all d_pill_all ///
		d_ec_all d_condom_all d_other_modern_all d_traditional_all
	gen id=_n + 100
	tempfile temp_user_denom
	save `temp_user_denom.dta', replace 
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

*Denominators
preserve
	keep if d_user_modern==1
	keep Category ///
		d_methodchoice_self d_methodchoice_joint d_methodchoice_other ///
		d_fp_told_other_methods_all d_fp_side_effects_all d_fp_sideeffects_instruct_all ///
		d_return_to_provider d_refer_to_relative d_returnrefer_dir ///
		d_fees_12months_all
	gen id=_n + 100
	tempfile temp_user_modern_denom
	save `temp_user_modern_denom.dta', replace 
restore 

*1c. ALL women with birth in past 5 years or pregnant 
preserve
	keep if preg==1
	keep Category ///
		wanted_then_all wanted_later_all wanted_not_all
	tempfile temp_preg
	save `temp_preg.dta', replace 
restore 

*Denominators
preserve
	keep if d_preg==1
	keep Category ///
		d_wanted_then_all d_wanted_later_all d_wanted_not_all
	tempfile temp_preg_denom
	save `temp_preg_denom.dta', replace 
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

*Denominators
preserve
	keep if d_mar==1
	keep Category ///
		d_cp_mar d_mcp_mar d_tcp_mar ///
		d_unmettot_mar d_unmetspace_mar d_unmetlimit_mar ///
		d_totaldemand_mar d_demandsatis_mar ///
		d_visited_by_health_worker_mar d_visited_facility_fp_disc_mar d_fp_discussion_mar
	tempfile temp_mar_denom
	save `temp_mar_denom.dta', replace
restore

*2b. MARRIED current users
*SAS: removed injectables, added dmpa_mar dmpasc_mar ec_mar
preserve
	keep if m_user==1
	keep Category ///
		ster_mar implant_mar IUD_mar dmpa_mar dmpasc_mar pill_mar ///
		ec_mar condom_mar other_modern_mar traditional_mar
	tempfile temp_m_user
	save `temp_m_user.dta', replace 
restore 

*Denominators
preserve
	keep if d_m_user==1
	keep Category ///
		d_ster_mar d_implant_mar d_IUD_mar d_dmpa_mar d_dmpasc_mar d_pill_mar ///
		d_ec_mar d_condom_mar d_other_modern_mar d_traditional_mar
	tempfile temp_m_user_denom
	save `temp_m_user_denom.dta', replace 
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

*Denominators
preserve
	keep if d_m_user_modern==1
	keep Category ///
		d_fp_told_other_methods_mar d_fp_side_effects_mar d_fp_sideeffects_instruct_mar ///
		d_fees_12months_mar
	tempfile temp_m_user_modern_denom
	save `temp_m_user_modern_denom.dta', replace 
restore

*2c. MARRIED women with birth in past 5 years or pregnant 
preserve
	keep if m_preg==1
	keep Category ///
		wanted_then_mar wanted_later_mar wanted_not_mar
	tempfile temp_m_preg
	save `temp_m_preg.dta', replace 
restore 

*Denominators
preserve
	keep if d_m_preg==1
	keep Category ///
		d_wanted_then_mar d_wanted_later_mar d_wanted_not_mar
	tempfile temp_m_preg_denom
	save `temp_m_preg_denom.dta', replace 
restore

*3. Merging
                     use `temp_all.dta', clear
merge 1:1 Category using `temp_percent.dta', gen(merge_percent)
merge 1:1 Category using `temp_unweighted.dta', gen(merge_unweighted)

merge 1:1 Category using `temp_user.dta', gen(merge_user)
merge 1:1 Category using `temp_user_modern.dta', gen(merge_user_modern)
merge 1:1 Category using `temp_preg.dta', gen(merge_preg)

merge 1:1 Category using `temp_mar.dta', gen(merge_mar)
merge 1:1 Category using `temp_m_user.dta', gen(merge_m_user)
merge 1:1 Category using `temp_m_user_modern.dta', gen(merge_m_user_modern)
merge 1:1 Category using `temp_m_preg.dta', gen(merge_m_preg)

merge 1:1 Category using `temp_all_denom.dta', gen(merge_all_denom)
merge 1:1 Category using `temp_user_denom.dta', gen(merge_user_denom)
merge 1:1 Category using `temp_user_modern_denom.dta', gen(merge_user_modern_denom)
merge 1:1 Category using `temp_preg_denom.dta', gen(merge_preg_denom)

merge 1:1 Category using `temp_mar_denom.dta', gen(merge_mar_denom)
merge 1:1 Category using `temp_m_user_denom.dta', gen(merge_m_user_denom)
merge 1:1 Category using `temp_m_user_modern_denom.dta', gen(merge_m_user_modern_denom)
merge 1:1 Category using `temp_m_preg_denom.dta', gen(merge_m_preg_denom)
sort id

save "$datadir/`CCRX'_SOITable_DataViz.dta", replace
use "$datadir/`CCRX'_SOITable_DataViz.dta", clear

drop id merge*

save, replace

*4. Ordering
foreach var in cp mcp tcp ///
	unmetspace unmetlimit unmettot ///
	totaldemand demandsatis ///
	visited_by_health_worker visited_facility_fp_disc fp_discussion ///
	visited_by_health_worker visited_facility_fp_disc fp_discussion {
	order `var'_mar, after(`var'_all)
	capture order d_`var'_all, after(`var'_all)
	capture order d_`var'_mar, after(`var'_mar)
	}

foreach method in ster implant IUD dmpa dmpasc pill ec condom other_modern traditional {
	order d_`method'_all, after(`method'_all)
	order d_`method'_mar, after(`method'_mar)
	}		

foreach choice in methodchoice_self methodchoice_joint methodchoice_other ///
	fees_12months ///
	fp_told_other_methods fp_side_effects ///
	return_to_provider refer_to_relative returnrefer_dir {
	order d_`choice'_all, after(`choice'_all)
	capture order d_`choice'_mar, after(`choice'_mar)
	}	
order d_fp_sideeffects_instruct_all, after(fp_side_effects_instructions_all)
order d_fp_sideeffects_instruct_mar, after(fp_side_effects_instructions_mar)

	
foreach var in wanted_then wanted_later wanted_not ///
	{
	order d_`var'_all, after(`var'_all)
	order d_`var'_mar, after(`var'_mar)
	}	


**Background
order percent_of_total-unweighted_count, after(Category)
	
**Current use of contraception by background characteristics
order cp_all-d_cp_all, after(unweighted_count)
order cp_mar-d_cp_mar, after(d_cp_all)
order mcp_all-d_mcp_all, after(d_cp_all)
order mcp_mar-d_mcp_mar, after(d_mcp_all)
order tcp_all-d_tcp_all, after(d_mcp_mar)
order tcp_mar-d_tcp_mar, after(d_tcp_all)

**Contraceptive method mix by background characteristics
order ster_all-d_ster_all, after(d_tcp_all)
order implant_all-d_implant_all, after(d_ster_all)
order IUD_all-d_IUD_all, after(d_implant_all)
order dmpa_all-d_dmpa_all, after(d_IUD_all)
order dmpasc_all-d_dmpasc_all, after(d_dmpa_all)
order pill_all-d_pill_all, after(d_dmpasc_all)
order ec_all-d_ec_all, after(d_pill_all)
order condom_all-d_condom_all, after(d_ec_all)
order other_modern_all-d_other_modern_all, after(d_condom_all)
order traditional_all-d_traditional_all, after(d_other_modern_all)

order ster_mar-d_ster_mar, after(d_traditional_all)	
order implant_mar-d_implant_mar, after(d_ster_mar)
order IUD_mar-d_IUD_mar, after(d_implant_mar)
order dmpa_mar-d_dmpa_mar, after(d_IUD_mar)
order dmpasc_mar-d_dmpasc_mar, after(d_dmpa_mar)
order pill_mar-d_pill_mar, after(d_dmpasc_mar)
order ec_mar-d_ec_mar, after(d_pill_mar)
order condom_mar-d_condom_mar, after(d_ec_mar)
order other_modern_mar-d_other_modern_mar, after(d_condom_mar)
order traditional_mar-d_traditional_mar, after(d_other_modern_mar)

**Unmet need for family planning
order unmetspace_all-d_unmetspace_all, after(d_traditional_mar)
order unmetlimit_all-d_unmetlimit_all, after(d_unmetspace_all)
order unmettot_all-d_unmettot_all, after(d_unmetlimit_all)

order unmetspace_mar-d_unmetspace_mar, after(d_unmettot_all)
order unmetlimit_mar-d_unmetlimit_mar, after(d_unmetspace_mar)
order unmettot_mar-d_unmettot_mar, after(d_unmetlimit_mar)

**Need and demand for family planning
order totaldemand_all-d_totaldemand_all, after(d_unmettot_mar)
order demandsatis_all-d_demandsatis_all, after(d_totaldemand_all)

order totaldemand_mar-d_totaldemand_mar, after(d_demandsatis_all)
order demandsatis_mar-d_demandsatis_mar, after(d_totaldemand_mar)

**Pregnancy intentions
order wanted_then_all-d_wanted_then_all, after(d_demandsatis_mar)
order wanted_later_all-d_wanted_later_all, after(d_wanted_then_all)
order wanted_not_all-d_wanted_not_all, after(d_wanted_later_all)

order wanted_then_mar-d_wanted_then_mar, after(d_wanted_not_all)
order wanted_later_mar-d_wanted_later_mar, after(d_wanted_then_mar)
order wanted_not_mar-d_wanted_not_mar, after(d_wanted_later_mar)

**Contraceptive choice
order methodchoice_self_all-d_methodchoice_self_all, after(d_wanted_not_mar)
order methodchoice_joint_all-d_methodchoice_joint_all, after(d_methodchoice_self_all)
order methodchoice_other_all-d_methodchoice_other_all, after(d_methodchoice_joint_all)

**Payment for family planning
order fees_12months_all-d_fees_12months_all, after(d_methodchoice_other_all)
order fees_12months_mar-d_fees_12months_mar, after(d_fees_12months_all)

**Method Information Index
order fp_told_other_methods_all-d_fp_told_other_methods_all, after(d_fees_12months_mar)
order fp_told_other_methods_mar-d_fp_told_other_methods_mar, after(d_fp_told_other_methods_all)
order fp_side_effects_all-d_fp_side_effects_all, after(d_fp_told_other_methods_mar)
order fp_side_effects_mar-d_fp_side_effects_mar, after(d_fp_side_effects_all)
order fp_side_effects_instructions_all-d_fp_sideeffects_instruct_all, after(d_fp_side_effects_mar)
order fp_side_effects_instructions_mar-d_fp_sideeffects_instruct_mar, after(d_fp_sideeffects_instruct_all)

**Perceived quality of care for family planning
order return_to_provider_all-d_return_to_provider_all, after(d_fp_sideeffects_instruct_mar)
order refer_to_relative_all-d_refer_to_relative_all, after(d_return_to_provider_all)
order returnrefer_dir_all-d_returnrefer_dir_all, after(d_refer_to_relative_all)

**Knowledge of family planning
order visited_by_health_worker_all-d_visited_by_health_worker_all, after(d_returnrefer_dir_all)
order visited_by_health_worker_mar-d_visited_by_health_worker_mar, after(d_visited_by_health_worker_all)
order visited_facility_fp_disc_all-d_visited_facility_fp_disc_all, after(d_visited_by_health_worker_mar)
order visited_facility_fp_disc_mar-d_visited_facility_fp_disc_mar, after(d_visited_facility_fp_disc_all)
order fp_discussion_all-d_fp_discussion_all, after(d_visited_facility_fp_disc_mar)
order fp_discussion_mar-d_fp_discussion_mar, after(d_fp_discussion_all)


	
*Remove all double marriage variables	
unab varlist: d_*_mar
foreach v in `varlist' {
	replace `v'=. if Category=="Married, or in union"
	}
	
save, replace
