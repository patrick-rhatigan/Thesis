// 			***Data import and cleaning for SHI dataset:***
clear all

// Directory Setup
local root_dir "~/OneDrive/School_Work/thesis" 
// contains data and code folders with all necessary files
cd "`root_dir'" 

import delimited "data/SHI_totals_overtime.csv", varnames(1) clear


rename *community community // fixes community varname which imports incorrectly

//convert strings to numeric
destring dev* shi* census*, ignore(",") replace 
replace percent_shi_1003 = "." if community == "Middlefield" //missing data point
destring percent*, ignore("%") replace

drop if dev_units_1220 == . // drops last observation which is empty
rename *_0* *_* //remove 0 from begining of dates (necessary for reshape)

//reshape data:
reshape long dev_units_ shi_units_ percent_shi_, i(community) j(survey_date)

//dealing with dates:
tostring survey_date, replace 
replace survey_date = "0" + survey_date if length(survey_date) == 3 
gen survey_date_1 = date(survey_date, "MY", 2022)
drop survey_date
rename survey_date_1 survey_date
format survey_date %tdNN-YY 

gen year = year(survey_date)

collapse (mean) dev* shi* percent* census*, by(year community)



save "data/shi.dta", replace
