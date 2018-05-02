import excel "/Users/ealarson/Desktop/datasets.xlsx", sheet("datasets") firstrow clear
keep CountryofResidence DatasetRequested Date

*Total number of requests by year
drop if Date=="chez"
gen date_2=clock(Date, "MDY")
format date_2 %tc
gen date=dofc(date_2)
gen year=year(date)
tab year
gen month=month(date)
tab month
gen day=day(date)
tab day

* Only keep between the following dates: April 15, 2017 and April 15, 2018

keep if year==2017 | year==2018
	drop if year==2017 & month<=3
	drop if year==2018 & month>4
	drop if year==2017 & month==4 & day<=14
	drop if year==2018 & mont==4 & day>=16


*Total number of requests by year and type (HHQ vs SDP)
gen hhqfq=1 if regexm(DatasetRequested, "Household and Individual Female")
gen sdp=1 if regexm(DatasetRequested, "Service Delivery Point")
gen dataset=1 if hhqfq==1
	replace dataset=2 if sdp==1
label define dataset 1 "HHQFQ" 2 "SDP"
	label val dataset dataset
tab dataset year

*Total number of requests by year from developing countries
gen lmic=1 if CountryofResidence=="Albania" | CountryofResidence=="Armenia" | CountryofResidence=="Bahamas" | CountryofResidence=="Burkina Faso" ///
	| CountryofResidence=="China" | CountryofResidence=="C√¥te d'Ivoire" | CountryofResidence=="Democratic Republic of the Congo" | CountryofResidence=="Ethiopia" ///
	| CountryofResidence=="Ghana" | CountryofResidence=="India" | CountryofResidence=="Indonesia" | CountryofResidence=="Iran" ///
	| CountryofResidence=="Kazkhstan" | CountryofResidence=="Kenya" | CountryofResidence=="Malaysia" | CountryofResidence=="Niger" ///
	| CountryofResidence=="Nigeria" | CountryofResidence=="Republic of Korea (South Korea)" | CountryofResidence=="South Africa" ///
	| CountryofResidence=="Uganda" | CountryofResidence=="United Republic of Tanzania"
replace lmic=0 if CountryofResidence=="Australia" | CountryofResidence=="Belgium" | CountryofResidence=="Canada" | CountryofResidence=="Finland" ///
	| CountryofResidence=="Italy" | CountryofResidence=="Japan" | CountryofResidence=="Netherlands" ///
	| CountryofResidence=="United Kingdom of Great Britain and Northern Ireland" | CountryofResidence=="United States of America"
label define lmic 0 "HIC" 1 "LMIC"
	label val lmic lmic
tab lmic year

*Dataset Country Requested
gen country=1 if regexm(DatasetRequested, "Burkina Faso")
	replace country=2 if regexm(DatasetRequested, "DRC")
	replace country=3 if regexm(DatasetRequested, "Ethiopia")
	replace country=4 if regexm(DatasetRequested, "Ghana")
	replace country=5 if regexm(DatasetRequested, "Indonesia")
	replace country=6 if regexm(DatasetRequested, "Kenya")
	replace country=7 if regexm(DatasetRequested, "Niger")
	replace country=8 if regexm(DatasetRequested, "Nigeria")
	replace country=9 if regexm(DatasetRequested, "India")
	replace country=10 if regexm(DatasetRequested, "Uganda")
label define country 1 "Burkina Faso" 2 "DRC" 3 "Ethiopia" 4 "Ghana" 5 "Indonesia" ///
	6 "Kenya" 7 "Niger" 8 "Nigeria" 9 "Rajasthan" 10 "Uganda"
	label val country country
tab	country

*tabs
tab year
tab dataset year, co
tab lmic year, co
tab Date lmic, co
tab dataset
tab country

