// 			***Data import and cleaning for ACS DP04 datasets:***
clear all

// Directory Setup
local root_dir "~/OneDrive/School_Work/thesis"
// contains data and code folders with necessary files
cd "`root_dir'/data"

import delimited "R_exp/merge_2021.csv", varnames(1) clear 
drop v*
drop ann*
save "temp/merge_2021.dta", replace 

import delimited "R_exp/merge_2016.csv", varnames(1) clear
drop v*
drop ann* 
save "temp/merge_2016.dta", replace 


import delimited "R_exp/merge_2011.csv", varnames(1) clear 
drop v*
drop ann*
save "temp/merge_2011.dta", replace 


append using "temp/merge_2016.dta" "temp/merge_2021.dta", ///
	generate(y) keep(geography geographicareaname est* p* moe*)

drop if (geographicareaname == "NAME" | geographicareaname == "Geographic Area Name")

gen year = 2011
replace year = 2016 if y == 1
replace year = 2021 if y == 2
destring est* p* moe*, replace force

split geographicareaname, p(",") g(g_)
rename g_1 tract
rename g_2 county
rename g_3 state

replace tract = substr(tract, 13, .)
replace county = substr(county, 1, strrpos(county, "County")-2)

save "acs_dp04_MA_censustracts.dta", replace
