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
reshape long dev_units_ shi_units_ percent_shi_, i(community) j(date)

save "data/shi.dta", replace
