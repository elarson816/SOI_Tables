/******************************************************************************************************************
SOI TABLES ORDERING AND FORMATING

Format Data into wide version and order variables
******************************************************************************************************************/

clear
cd "$datadir"

*Country Code
local CCRX $CCRX
local country $country
local round $round
local today $today
local date $date
use "`CCRX'_SOIPrep_SDP_countryspecific.dta", clear

*Generate one variable per dataset
gen feespub=1 if fees_public!=.
	gen d_feespub=1 if d_fees_public!=.
gen feespriv=1 if fees_priv!=. 
	gen d_feespriv=1 if d_fees_priv!=.
gen threshold3pub=1 if threshold_3_public!=. | provided_pills_public!=.
	gen d_threshold3pub=1 if d_threshold_3_public!=. | d_provided_pills_public!=.
gen threshold3priv=1 if threshold_3_priv!=. | provided_pills_priv!=.
	gen d_threshold3priv=1 if d_threshold_3_priv!=. | d_provided_pills_priv!=.
gen sterfemale=1 if visits_female_ster!=. 

gen stermale=1 if visits_male_ster!=.
gen dmpatotal=1 if visits_dmpa_total!=. 
gen dmpasctotal=1 if visits_dmpasc_total!=.
gen dmpanew=1 if visits_dmpa_new!=.
gen dmpascnew=1 if visits_dmpasc_new!=.
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

*1a. Public: Fees & Stock (Denominator)
preserve
keep if d_feespub==1
keep Country Round Date Grouping Category ///
d_fees_public-d_stockout_3mo_now_ec_public 
tempfile temp_d_feespub
save `temp_d_feespub.dta', replace 
restore 

*1b. Private: Fees & Stock Fees
preserve
keep if feespriv==1
keep Country Round Date Grouping Category ///
fees_priv-stockout_3mo_now_ec_priv 
tempfile temp_feespriv
save `temp_feespriv.dta', replace 
restore 

*1b. Private: Fees & Stock Fees (Denominator)
preserve
keep if d_feespriv==1
keep Country Round Date Grouping Category ///
d_fees_priv-d_stockout_3mo_now_ec_priv 
tempfile temp_d_feespriv
save `temp_d_feespriv.dta', replace 
restore 

*2a. Public: 3+/5+ & Provision
preserve
keep if threshold3pub==1
keep Country Round Date Grouping Category ///
threshold_3_public-provided_ec_public
tempfile temp_threshold3pub
save `temp_threshold3pub.dta', replace 
restore 

*2a. Public: 3+/5+ & Provision (Denominator)
preserve
keep if d_threshold3pub==1
keep Country Round Date Grouping Category ///
d_threshold_3_public-d_provided_ec_public
tempfile temp_d_threshold3pub
save `temp_d_threshold3pub.dta', replace 
restore 

*2b. Private: Public: 3+/5+ & Provision
preserve
keep if threshold3priv==1
keep Country Round Date Grouping Category ///
threshold_3_priv-provided_ec_priv
tempfile temp_threshold3priv
save `temp_threshold3priv.dta', replace 
restore 

*2b. Private: Public: 3+/5+ & Provision (Denominator)
preserve
keep if d_threshold3priv==1
keep Country Round Date Grouping Category ///
d_threshold_3_priv-d_provided_ec_priv
tempfile temp_d_threshold3priv
save `temp_d_threshold3priv.dta', replace 
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
keep if dmpatotal==1
keep Category ///
visits_dmpa_total
tempfile temp_dmpatotal
save `temp_dmpatotal.dta', replace 
restore 

*3a_3. Public & Private: Visits
preserve
keep if dmpasctotal==1
keep Category ///
visits_dmpasc_total
tempfile temp_dmpasctotal
save `temp_dmpasctotal.dta', replace 
restore 

*3a_4. Public & Private: Visits
preserve
keep if dmpanew==1
keep Category ///
visits_dmpa_new
tempfile temp_dmpanew
save `temp_dmpanew.dta', replace 
restore 

*3a_4. Public & Private: Visits
preserve
keep if dmpascnew==1
keep Category ///
visits_dmpasc_new
tempfile temp_dmpascnew
save `temp_dmpascnew.dta', replace 
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
		merge 1:1 Category using `temp_d_feespub.dta', gen(merge_d_feespub)
	merge 1:1 Category using `temp_feespriv.dta', gen(merge_feespriv)
		merge 1:1 Category using `temp_d_feespriv.dta', gen(merge_d_feespriv)
	merge 1:1 Category using `temp_threshold3pub.dta', gen(merge_threshold3pub)
		merge 1:1 Category using `temp_d_threshold3pub.dta', gen(merge_d_threshold3pub)
	merge 1:1 Category using `temp_threshold3priv.dta', gen(merge_threshold3priv)
		merge 1:1 Category using `temp_d_threshold3priv.dta', gen(merge_d_threshold3priv)
	
	merge 1:m Category using `temp_sterfemale.dta', gen(merge_sterfemale)
	merge 1:1 Category using `temp_stermale.dta', gen(merge_stermale)
	merge 1:m Category using `temp_dmpatotal.dta', gen(merge_dmpatotal)
	merge 1:m Category using `temp_dmpasctotal.dta', gen(merge_dmpasctotal)
	merge 1:m Category using `temp_dmpanew.dta', gen(merge_dmpanew)
	merge 1:m Category using `temp_dmpascnew.dta', gen(merge_dmpascnew)
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
	merge m:m Category using `temp_facilitiesperc.dta', gen(merge_facilitiesperc) // *note -- with: merge 1:m received this error: "variable Category does not uniquely identify observations in the master data"

sort id
drop id merge_feespriv merge_threshold3pub merge_threshold3priv ///
merge_sterfemale merge_stermale ///
merge_dmpatotal merge_dmpanew merge_dmpasctotal merge_dmpascnew merge_iudtotal merge_iudnew ///
merge_implantstotal merge_implantsnew merge_malecondomstotal merge_malecondomsnew ///
merge_pillstotal merge_pillsnew merge_ectotal merge_ecnew ///
merge_facilitiesnumb merge_facilitiesperc ///
merge_d_feespub merge_d_feespriv merge_d_threshold3pub merge_d_threshold3priv

foreach var in fees threshold_3 threshold_5 ///
{
order `var'_priv, after(`var'_public)
}
foreach var in visits_dmpa visits_dmpasc visits_iud visits_implants ///
visits_male_condoms visits_pills visits_ec ///
{
order `var'_new, after(`var'_total)
}
order threshold_3_public-threshold_3_priv, after(fees_priv)
order threshold_5_public-threshold_5_priv, after(threshold_3_priv)
order provided_pills_public-provided_ec_public, after(threshold_5_priv)
order provided_pills_priv-provided_ec_priv, after(provided_ec_public)
order stockout_3mo_now_pills_public-stockout_3mo_now_ec_public, after(provided_ec_priv)
order stockout_3mo_now_pills_priv-stockout_3mo_now_ec_priv, after(stockout_3mo_now_ec_public)
order visits_male_ster, after(visits_female_ster)
order visits_dmpa_total, after(visits_male_ster)
order visits_dmpasc_total, after(visits_dmpa_total)
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

save "`CCRX'_SDP_SOITable_$today.dta", replace
exit
