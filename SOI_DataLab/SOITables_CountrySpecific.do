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
local date $date

use "`CCRX'_SOIPrep_vargen.dta"

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

*Drop if married=="0"
replace umsexactive="Unmarried, sexually active" if umsexactive=="1"

*Drop if umsexactive=="0"
replace parity3="0-1 children" if parity3=="0"
replace parity3="2-3 children" if parity3=="1"
replace parity3="4+ children" if parity3=="2"
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

foreach wanted in wanted_then_all wanted_later_all wanted_not_all wanted_then_mar wanted_later_mar wanted_not_mar ///
	d_wanted_then_all d_wanted_later_all d_wanted_not_all d_wanted_then_mar d_wanted_later_mar d_wanted_not_mar {
	replace `wanted'=. if Country=="DRC_Kinshasa" & Round=="Round 1"
	}


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
replace Grouping="parity" if parity3!=""
replace Grouping="residence" if ur!=""
replace Grouping="education" if school!=""
replace Grouping="wealth quintile or tertile" if wealth!=""
replace Grouping="region" if region!=""
order Grouping, after(Date)
foreach x in age5 married umsexactive parity3 ur school wealth region {
	drop `x'
	}
*

save "$datadir/`CCRX'_SOIPrep_countryspecific.dta", replace
