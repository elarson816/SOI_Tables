
*Instructions:
	*To add a country:
		*Section 1. Add survey_code. Ensure year is correct & spelling matches string in CCRX dataset
		*Section 3. Do any neccessary cleaning
		*Section 4. Add _cc to the end of char1_codes for edu, region, and facility_type
		*In Excel API, add edu, region, and facility_type to char and char_group tabs. Add survey to survey and country tab.

********************************************************************************
* Section A. Order method resuts/denominators
********************************************************************************
		
foreach method in ster implant IUD dmpa dmpasc pill ec condom other_modern traditional {
	order d_`method'_all, after(`method'_all)
	order d_`method'_mar, after(`method'_mar)
	}	
	
foreach var in cp mcp tcp ///
	visited_by_health_worker visited_facility_fp_disc fp_discussion ///
	fp_told_other_methods fp_side_effects fp_side_effects_instructions ///
	visited_by_health_worker visited_facility_fp_disc fp_discussion {
	order `var'_mar, after(`var'_all)
	capture order d_`var'_all, after(`var'_all)
	capture order d_`var'_mar, after(`var'_mar)
	}

order d_fp_sideeffects_instruct_all, after(fp_side_effects_instructions_all)
order d_fp_sideeffects_instruct_mar, after(fp_side_effects_instructions_mar)

foreach var in unmetspace unmetlimit unmettot ///
	totaldemand demandsatis ///
	wanted_then wanted_later wanted_not ///
	fees_12months {
	order d_`var'_all, after(`var'_all)
	order d_`var'_mar, after(`var'_mar)
	}
order d_unmetlimit_all, after(unmetlimit_all)

foreach choice in methodchoice_self methodchoice_joint methodchoice_other ///
	return_to_provider refer_to_relative returnrefer_dir {
	order d_`choice'_all, after(`choice'_all)
	capture order d_`choice'_mar, after(`choice'_mar)
	}	

order ster_all-d_traditional_mar, after(d_tcp_mar)
order unmetspace_all-d_unmetspace_all, after(d_traditional_mar)
order unmettot_all-d_unmettot_all, after(d_unmetlimit_all)
order unmetspace_mar-d_unmetspace_mar, after(d_unmettot_all)
order unmetlimit_mar-d_unmetlimit_mar, after(d_unmetspace_mar)
order unmettot_mar-d_unmettot_mar, after(d_unmetlimit_mar)
order totaldemand_mar-d_demandsatis_mar, after(d_demandsatis_all)
order wanted_then_all-d_wanted_not_all, after(d_demandsatis_mar)
order wanted_then_mar-d_wanted_not_mar, after(d_wanted_not_all)
order methodchoice_self_all-d_methodchoice_other_all, after(d_wanted_not_mar)
order fees_12months_all-d_fees_12months_all, after(d_methodchoice_other_all)
order fees_12months_mar-d_fees_12months_mar, after(d_fees_12months_all)
order fp_told_other_methods_all-d_fp_sideeffects_instruct_all, after(d_fees_12months_mar)
order return_to_provider_all-d_returnrefer_dir_all, after(d_fp_sideeffects_instruct_mar)
order visited_by_health_worker_all-d_visited_by_health_worker_all, after(d_returnrefer_dir_all)
order visited_by_health_worker_mar-d_visited_by_health_worker_mar, after(d_visited_by_health_worker_all)
order fp_discussion_all-d_fp_discussion_all, after(d_visited_by_health_worker_mar)
order fp_discussion_mar-d_fp_discussion_mar, after(d_fp_discussion_all)
order visited_facility_fp_disc_all-d_visited_facility_fp_disc_mar, after(d_fp_discussion_mar)
assert 0

order ster_all-d_traditional_all, after(d_tcp_mar)
order ster_mar-d_traditional_mar, after(d_traditional_all)
order unmettot_all, after(d_unmetlimit_all)
	order d_unmettot_all, after(unmettot_all)
order unmetlimit_mar-d_unmetlimit_mar, after(d_unmetlimit_all)
order unmettot_mar, after(unmetlimit_mar)
	order d_unmettot_mar, after(unmettot_mar)
order wanted_then_all-d_wanted_not_mar, after(d_demandsatis_mar)
order methodchoice_self-d_methodchoice_other, after(d_wanted_not_mar)
order fees_12months_all, after(methodchoice_other)
	order d_fees_12months_all, after(fees_12months_all)
order fees_12months_mar, after(fees_12months_all)
	order d_fees_12months_mar, after(fees_12months_mar)
order fp_told_other_methods_all-d_fp_sideeffects_instruct_mar, after(d_fees_12months_mar)
order return_to_provider-d_returnrefer_dir, after(d_fp_sideeffects_instruct_mar)
		
********************************************************************************
* Section 1. Create survey_code to apply to both HHQFQ & SDP data
********************************************************************************

gen survey_code=""	
	
*Burkina
replace survey_code="PMA2014_BFR1" if Country=="Burkina" & Round=="Round 1"
replace survey_code="PMA2015_BFR2" if Country=="Burkina" & Round=="Round 2"
replace survey_code="PMA2016_BFR3" if Country=="Burkina" & Round=="Round 3"
replace survey_code="PMA2016_BFR4" if Country=="Burkina" & Round=="Round 4"

*DRC
replace Country="DRC_KongoCentral" if Country=="DRC_Kongo_Central"
replace survey_code="PMA2013_CDR1_Kinshasa" if Country=="DRC_Kinshasa" & Round=="Round 1"
replace survey_code="PMA2014_CDR2_Kinshasa" if Country=="DRC_Kinshasa" & Round=="Round 2"
replace survey_code="PMA2015_CDR3_Kinshasa" if Country=="DRC_Kinshasa" & Round=="Round 3"
replace survey_code="PMA2015_CDR4_Kinshasa" if Country=="DRC_Kinshasa" & Round=="Round 4"
replace survey_code="PMA2015_CDR4_KongoCentral" if Country=="DRC_KongoCentral" & Round=="Round 4"
replace survey_code="PMA2016_CDR5_Kinshasa" if Country=="DRC_Kinshasa" & Round=="Round 5"
replace survey_code="PMA2016_CDR5_KongoCentral" if Country=="DRC_KongoCentral" & Round=="Round 5"

*Ethiopia
replace survey_code="PMA2014_ETR1" if Country=="Ethiopia" & Round=="Round 1"
replace survey_code="PMA2014_ETR2" if Country=="Ethiopia" & Round=="Round 2"
replace survey_code="PMA2015_ETR3" if Country=="Ethiopia" & Round=="Round 3"
replace survey_code="PMA2016_ETR4" if Country=="Ethiopia" & Round=="Round 4"

*Ghana
replace survey_code="PMA2013_GHR1" if Country=="Ghana" & Round=="Round 1"
replace survey_code="PMA2014_GHR2" if Country=="Ghana" & Round=="Round 2"
replace survey_code="PMA2014_GHR3" if Country=="Ghana" & Round=="Round 3"
replace survey_code="PMA2015_GHR4" if Country=="Ghana" & Round=="Round 4"
replace survey_code="PMA2016_GHR5" if Country=="Ghana" & Round=="Round 5"

*India
replace survey_code="PMA2016_INR1_Rajasthan" if Country=="India_Rajasthan" & Round=="Round 1"
replace survey_code="PMA2017_INR2_Rajasthan" if Country=="India_Rajasthan" & Round=="Round 2"

*Indonesia
replace survey_code="PMA2015_IDR1" if Country=="Indonesia" & Round=="Round 1"

*Kenya
replace survey_code="PMA2014_KER1" if Country=="Kenya" & Round=="Round 1"
replace survey_code="PMA2014_KER2" if Country=="Kenya" & Round=="Round 2"
replace survey_code="PMA2015_KER3" if Country=="Kenya" & Round=="Round 3"
replace survey_code="PMA2015_KER4" if Country=="Kenya" & Round=="Round 4"
replace survey_code="PMA2016_KER5" if Country=="Kenya" & Round=="Round 5"

*Niger
replace survey_code="PMA2015_NER1_Niamey" if Country=="Niger_Niamey" & Round=="Round 1"
replace survey_code="PMA2016_NER2" if (Country=="Niger_National" | Country=="Niger") & Round=="Round 2"
replace survey_code="PMA2016_NER2_Niamey" if Country=="Niger_Niamey" & Round=="Round 2"
replace survey_code="PMA2016_NER3_Niamey" if Country=="Niger_Niamey" & Round=="Round 3"

*Nigeria
replace survey_code="PMA2014_NGR1_Kaduna" 	if Country=="Nigeria_Kaduna" & Round=="Round 1"
replace survey_code="PMA2014_NGR1_Lagos" 	if Country=="Nigeria_Lagos" & Round=="Round 1"
replace survey_code="PMA2015_NGR2_Kaduna" 	if Country=="Nigeria_Kaduna" & Round=="Round 2"
replace survey_code="PMA2015_NGR2_Lagos" 	if Country=="Nigeria_Lagos" & Round=="Round 2"
replace survey_code="PMA2016_NGR3_Kaduna" 	if Country=="Nigeria_Kaduna" & Round=="Round 3"
replace survey_code="PMA2016_NGR3_Lagos" 	if Country=="Nigeria_Lagos" & Round=="Round 3"
replace survey_code="PMA2016_NGR3_Anambra"  if Country=="Nigeria_Anambra" & Round=="Round 3"
replace survey_code="PMA2016_NGR3_Kano" 	if Country=="Nigeria_Kano" & Round=="Round 3"
replace survey_code="PMA2016_NGR3_Nasarawa" if Country=="Nigeria_Nasarawa" & Round=="Round 3"
replace survey_code="PMA2016_NGR3_Rivers" 	if Country=="Nigeria_Rivers" & Round=="Round 3"
replace survey_code="PMA2016_NGR3_Taraba" 	if Country=="Nigeria_Taraba" & Round=="Round 3"
replace survey_code="PMA2016_NGR3" 			if (Country=="Nigeria" | Country=="Nigeria_National") & Round=="Round 3"

*Uganda
replace survey_code="PMA2014_UGR1" if Country=="Uganda" & Round=="Round 1"
replace survey_code="PMA2015_UGR2" if Country=="Uganda" & Round=="Round 2"
replace survey_code="PMA2015_UGR3" if Country=="Uganda" & Round=="Round 3"
replace survey_code="PMA2016_UGR4" if Country=="Uganda" & Round=="Round 4"

********************************************************************************
* Section 2. General cleaning
********************************************************************************

*Drop TFR from HHQFQ
capture drop tfr

*Drop old indicators from SDP
capture drop one_number one_percentage

*Drop urban/ rural breakdown from SDP
drop if Grouping=="Location"

* Drop levels we don't want to report, by country
* Burkina
drop if Country=="Burkina" & Grouping=="region"
* DRC: drop ur and region, residence, other SDP type
drop if (Country=="DRC_Kinshasa" | Country=="DRC_KongoCentral") & (Grouping=="region" | Grouping=="Region" | Grouping=="residence")
drop if Category=="facility_type_soi_96"
replace Category="Higher" if Category=="Tertiary" & Country=="DRC_KongoCentral" & Round=="Round 5"
* Ghana: fix middle school
replace Category="middle school" if Category=="Middle School" & Country=="Ghana"
* India_Rajasthan: drop region & ur/rural
drop if Country=="India_Rajasthan" & (Grouping=="Region" | Grouping=="region" | Grouping=="Location")
* Niger: drop ur/rural, drop region (Nimaey only)
drop if (Country=="Niger_Niamey" | Country=="Niger" | Country=="Niger_National") & (Grouping=="residence")
drop if Country=="Niger_Niamey" & (Grouping=="region" | Grouping=="Region")
* Nigeria: drop region, number of beds
drop if (Country=="Nigeria_Kaduna" | Country=="Nigeria_Lagos" | Country=="Nigeria_Taraba" | Country=="Nigeria_Kano" | Country=="Nigeria_Rivers" | Country=="Nigeria_Nasarawa" | Country=="Nigeria_Anambra") ///
	& (Grouping=="region" | Grouping=="Region" | Grouping=="Number of beds") 

* Format "Category" so there is overlap/ fix typos
* Faciilty type
replace Category="Health center" if Category=="Health Center" | Category=="health_center"
replace Category="Hospital" if Category=="hospital"
replace Category="Pharmacy" if Category=="pharmacy"
replace Category="Health center/Health clinic" if Category=="Health center/clinic"
replace Category="Pharmacy/ other" if Category=="pharmacy_other"
replace Category="Surgical center" if Category=="surgical_center"
replace Grouping="Facility type" if Grouping=="Facility Type"
* Education level
replace Category="Technical & vocational" if Category=="Technical/ Vocational"
 
/*Burkina: make regions the same across HHQFQ & SDP (unneccessary -- region dropped)
replace Category="Boucle_du_mouhoun" if Category=="Boucle de Mouhon" & Country=="Burkina"
replace Category="Cascades" 		 if Category=="Cascades" & Country=="Burkina"
replace Category="Centre" 			 if Category=="Centre" & Country=="Burkina"
replace Category="Centre_Est" 		 if Category=="Centre-Est" & Country=="Burkina"
replace Category="Centre_Nord" 		 if Category=="Centre-Nord" & Country=="Burkina"
replace Category="Centre_Ouest" 	 if Category=="Centre-Ouest" & Country=="Burkina"
replace Category="Centre_Sud" 		 if Category=="Centre-Sud" & Country=="Burkina"
replace Category="Est" 				 if Category=="Est" & Country=="Burkina"
replace Category="Hauts_Bassins" 	 if Category=="Hauts-Bassins" & Country=="Burkina"
replace Category="Nord" 			 if Category=="Nord" & Country=="Burkina"
replace Category="Plateau_Central" 	 if Category=="Plateau-Central" & Country=="Burkina"
replace Category="Sahel" 			 if Category=="Sahel" & Country=="Burkina"
replace Category="Sud_Ouest" 		 if Category=="Sud-Ouest" & Country=="Burkina"
*/

********************************************************************************
* Section 3. Make values in Category unique for each Grouping
********************************************************************************

*Wealth tertile
if Country=="Burkina" | Country=="Niger_Niamey" | Country=="Niger" | Country=="Niger_National" {
replace Grouping="wealth tertile" if Grouping=="wealth quintile or tertile"
replace Category="lowest_3" if Category=="Lowest" & Grouping=="wealth tertile"
replace Category="middle_3" if Category=="Middle" & Grouping=="wealth tertile"
replace Category="highest_3" if Category=="Highest" & Grouping=="wealth tertile"
}
else {
replace Grouping="wealth quintile" if Grouping=="wealth quintile or tertile"
replace Category="lowest_5" if Category=="Lowest" & Grouping=="wealth quintile"
replace Category="lower_5" if Category=="Lower" & Grouping=="wealth quintile"
replace Category="middle_5" if Category=="Middle" & Grouping=="wealth quintile"
replace Category="higher_5" if (Category=="Higher" | Category=="High") & Grouping=="wealth quintile"
replace Category="highest_5" if Category=="Highest" & Grouping=="wealth quintile"
}

********************************************************************************
* Section 4. Make values in Category unique across Countries
********************************************************************************

*Burkina
foreach edu in "Never" "Primary" "Secondary 1 Cycle" "Secondary 2 Cycles" "Tertiary" {
replace Category="`edu'_bf" if Category=="`edu'" & Country=="Burkina"
}
foreach region in "Boucle_du_mouhoun" "Cascades" "Centre" "Centre_Est" "Centre_Nord" "Centre_Ouest" ///
	"Centre_Sud" "Est" "Hauts_Bassins" "Nord" "Plateau_Central" "Sahel" "Sud_Ouest" {
replace Category="`region'_bf" if Category=="`region'" & Country=="Burkina"
}
foreach facility_type in "Hospital" "Health center" "Other" "Pharmacy/ other private" {
replace Category="`facility_type'_bf" if Category=="`facility_type'" & Country=="Burkina"
} 

*DRC
foreach edu in "Never" "Primary" "Secondary" "Higher" {
replace Category="`edu'_cd" if Category=="`edu'" & (Country=="DRC_Kinshasa" | Country=="DRC_KongoCentral")
}
foreach facility_type in "Hospital" "Health center" "Health clinic" "Dispensary" "Pharmacy" "Other" {
replace Category="`facility_type'_cd" if Category=="`facility_type'" & (Country=="DRC_Kinshasa" | Country=="DRC_KongoCentral")
} 

*Ethiopia
foreach edu in "Never" "Primary" "Secondary" "Technical & vocational" "Higher" {
replace Category="`edu'_et" if Category=="`edu'" & Country=="Ethiopia"
}
foreach region in "Addis" "Amhara" "Oromiya" "SNNP" "Tigray" "Other" {
replace Category="`region'_et" if Category=="`region'" & Country=="Ethiopia"
}
foreach facility_type in "Hospital" "Health center/Health clinic" "Health post" "Pharmacy/drug shop/other" {
replace Category="`facility_type'_et" if Category=="`facility_type'" & Country=="Ethiopia"
} 

*Ghana
foreach edu in "Never" "Primary" "middle school" "Secondary" "Higher" {
replace Category="`edu'_gh" if Category=="`edu'" & Country=="Ghana"
}
foreach region in "Ashanti" "Brong Ahafo" "Central" "Eastern" "Greater Accra" "Northern" ///
	"Upper East" "Upper West" "Volta" "Western" {
replace Category="`region'_gh" if Category=="`region'" & Country=="Ghana"
}
foreach facility_type in "Hospital/Polyclinic" "Health center/Health clinic" "CHPS" "Pharmacy/Chemist/Retail/Other" {
replace Category="`facility_type'_gh" if Category=="`facility_type'" & Country=="Ghana"
} 

*India
foreach edu in "Never" "Primary" "Secondary" "Higher" "Postgrad" {
replace Category="`edu'_in" if Category=="`edu'" & Country=="India_Rajasthan"
}
foreach facility_type in "Hospital" "PHC" "CHC" "Clinic" "Dispensary" "Pharmacy" "Sub center" "Other" {
replace Category="`facility_type'_in" if Category=="`facility_type'" & Country=="India_Rajasthan"
} 
		  
*Indonesia
foreach edu in "Never" "Primary" "Secondary_1" "Secondary_2" "University" {
replace Category="`edu'_id" if Category=="`edu'" & Country=="Indonesia"
}
foreach region in "Java-Bali" "Other" {
replace Category="`region'_id" if Category=="`region'" & Country=="Indonesia"
}
foreach facility_type in "Hospital" "Clinic" "CHC" "PHC" "Sub center" "Dispensary" "Pharmacy" "Other" {
replace Category="`facility_type'_id" if Category=="`facility_type'" & Country=="Indonesia"
} 

*Kenya
foreach edu in "Never" "Primary" "Post Primary Vocational" "Secondary" "College" "University" {
replace Category="`edu'_ke" if Category=="`edu'" & Country=="Kenya"
}
foreach region in "Bungoma" "Kericho" "Kiambu" "Kilifi" "Kitui" "Nairobi" ///
	"Nandi" "Nyamira" "Siaya" "Kakamega" "West_Pokot" {
replace Category="`region'_ke" if Category=="`region'" & Country=="Kenya"
}
foreach facility_type in "Hospital" "Health center" "Health clinic" "Dispensary" "Pharmacy" {
replace Category="`facility_type'_ke" if Category=="`facility_type'" & Country=="Kenya"
} 

*Niger
foreach edu in "Never" "Primary" "Secondary" "Tertiary" {
replace Category="`edu'_ne" if Category=="`edu'" & (Country=="Niger_Niamey" | Country=="Niger" | Country=="Niger_National") 
}
foreach region in "Niamey" "Other urban" "Rural areas" {
replace Category="`region'_ne" if Category=="`region'" & (Country=="Niger" | Country=="Niger_National")  
}
*foreach region in "Niamey" "Agadez" "Diffa" "Dosso" "Maradi" "Tahoua" "Tillaberi" "Zinder" {
*replace Category="`region'_ne" if Category=="`region'" & (Country=="Niger" | Country=="Niger_National") 
*}
foreach facility_type in "Hospital" "Health center" "Health hut" "Pharmacy or other private" {
replace Category="`facility_type'_ne" if Category=="`facility_type'" & (Country=="Niger_Niamey" | Country=="Niger" | Country=="Niger_National") 
}

*Nigeria
foreach edu in "Never" "Primary" "Secondary" "Higher" {
replace Category="`edu'_ng" if Category=="`edu'" & (Country=="Nigeria_Kaduna" | Country=="Nigeria_Lagos" | Country=="Nigeria_Taraba" | Country=="Nigeria_Kano" | Country=="Nigeria_Rivers" | Country=="Nigeria_Nasarawa" | Country=="Nigeria_Anambra" | Country=="Nigeria") 
}
foreach region in "Kaduna" "Lagos" "Anambra" "Kano" "Nasarawa" "Rivers" "Taraba" {
replace Category="`region'_ng" if Category=="`region'" & (Country=="Nigeria_Kaduna" | Country=="Nigeria_Lagos" | Country=="Nigeria_Taraba" | Country=="Nigeria_Kano" | Country=="Nigeria_Rivers" | Country=="Nigeria_Nasarawa" | Country=="Nigeria_Anambra" | Country=="Nigeria") 
}
foreach facility_type in "Hospital" "Health center" "Pharmacy" "Other" {
replace Category="`facility_type'_ng" if Category=="`facility_type'" & (Country=="Nigeria_Kaduna" | Country=="Nigeria_Lagos" | Country=="Nigeria_Taraba" | Country=="Nigeria_Kano" | Country=="Nigeria_Rivers" | Country=="Nigeria_Nasarawa" | Country=="Nigeria_Anambra" | Country=="Nigeria") 
} 

*Uganda
foreach edu in "Never" "Primary" "Secondary" "Technical & vocational" "University" {
replace Category="`edu'_ug" if Category=="`edu'" & Country=="Uganda"
}
foreach region in "Central" "Eastern" "Northern" "Western" {
replace Category="`region'_ug" if Category=="`region'" & Country=="Uganda"
}
foreach facility_type in "Hospital" "Health center IV" "Health center III" "Health center II" "Health clinic" "Pharmacy/ Chemist/ Other" {
replace Category="`facility_type'_ug" if Category=="`facility_type'" & Country=="Uganda"
} 

*Get rid of spaces/ other weird characters and replace with underscores
replace Category = subinstr(Category, " & ", "_", .)
replace Category = subinstr(Category, ", ", "_", .)
replace Category = subinstr(Category, " ", "_", .)
replace Category = subinstr(Category, "+", "", .)

