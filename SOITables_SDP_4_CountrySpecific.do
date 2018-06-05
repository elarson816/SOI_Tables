/******************************************************************************************************************
SOI TABLES COUNTRY SPECIFIC CHANGES

Set country-specific Categories for School and Region Groupings -- Regions must be numbers in data (twice)
******************************************************************************************************************/

clear
cd "$datadir"

*Country Code
local CCRX $CCRX
local country $country
local round $round
local today $today
local date $date

use "`CCRX'_SOIPrep_vargen.dta"

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
