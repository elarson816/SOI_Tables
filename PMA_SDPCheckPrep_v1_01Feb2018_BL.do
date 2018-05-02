**SDP Check Prep**

clear
clear matrix
clear mata
capture log close
set maxvar 15000
set more off
numlabel, add

* Set local/global macros for current date
local today=c(current_date)
local c_today= "`today'"
global date=subinstr("`c_today'", " ", "",.)

* Country/Round/Abbreviations
local CCRX BFR5

* Data
local data_Round4 "/Users/ealarson/Documents/Burkina Faso/Data_NotShared/Round4/SDP/BFR4_SDP_7Feb2017.dta"
local data_Round5 "/Users/ealarson/Documents/Burkina Faso/Data_NotShared/Round5/SDP/BFR5_SDP_"
local datadir "/Users/ealarson/Documents/Burkina Faso/Data_NotShared/Round5/SDP/SDP_Checks"


*********1st Round***********
cd "`datadir'"
	
foreach round in Round4 Round5 {
	use "`data_`round''.dta"
	preserve
	keep round level1 level2 level3 EA locationlatitude locationlongitude facility_name ///
		facility_name_other facility_type managing_authority metainstanceID
	export delimited using "`datadir'/`CCRX'_`round'_$date.csv", replace
	restore
	}
