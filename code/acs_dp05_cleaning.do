//		*** ACS DP05 Import and Cleaning ***  //
clear all

// Directory Setup
local root_dir "~/OneDrive/School_Work/thesis"
// contains data and code folders with necessary files
cd "`root_dir'/data"

cd "`root_dir'/data/ACS_ma_dp05_2021-11"


import delimited "2016-Data.csv", varnames(2) clear 
drop v*
drop ann*
save "../temp/dp05_data_2016.dta", replace

import delimited "2021-Data.csv", varnames(2) clear 
drop v*
drop ann*
save "../temp/dp05_data_2021.dta", replace

import delimited "2011-Data.csv", varnames(2) clear 
drop v*
drop ann*

cd "`root_dir'/data"

append using "temp/dp05_data_2016.dta" "temp/dp05_data_2021.dta", force generate(y)
gen year = 2011
replace year = 2016 if y == 1
replace year = 2021 if y == 2

destring perc* est* mar*, force replace

// split tract, state and county into their own varnames
split geographicareaname, p(",") g(g_)
rename g_1 tract
rename g_2 county
rename g_3 state

replace tract = substr(tract, 13, .)
replace county = substr(county, 1, strrpos(county, "County")-2)

save "acs_dp05_MA_censustracts.dta", replace
