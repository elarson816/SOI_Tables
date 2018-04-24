***code for time elapsed between 

gen december=12
gen thirtyfirst=31
gen year_date=2017
gen dec31SIF=mdy(december,thirtyfirst,year_date)
format dec31SIF %td
gen elapsed_time=dec31SIF-begin_usingSIF
gen elapsed_time_year=elapsed_time/365
gen method_elapsed_time=0 if elapsed_time_year<1
replace method_elapsed_time=1 if elapsed_time_year>=1 & elapsed_time_year<2
replace method_elapsed_time=2 if elapsed_time_year>=2
replace method_elapsed_time=. if current_methodnumEC!=3
label define time_elapsed 0 "<1 year" 1 "1-2 years" 2 "2+ years" 
label val method_elapsed_time time_elapsed
tab method_elapsed_time 
tab current_methodnumEC
