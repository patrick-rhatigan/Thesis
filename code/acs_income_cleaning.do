// 			***Data import and cleaning for ACS DP03 datasets:***
clear all

// Directory Setup
local root_dir "~/OneDrive/School_Work/thesis"
// contains data and code folders with necessary files
cd "`root_dir'/data/ACS_5Y_Financial_2021-11"

import delimited "2011-Data.csv", varnames(2) clear 
drop v*
drop ann*
save "../temp/income_data_2011.dta", replace 

import delimited "2016-Data.csv", varnames(2) clear 
drop v*
drop ann*
save "../temp/income_data_2016.dta", replace

import delimited "2021-Data.csv", varnames(2) clear 
drop v*
drop ann*
save "../temp/income_data_2021.dta", replace

use "../temp/income_data_2011.dta", clear
append using "../temp/income_data_2016.dta" "../temp/income_data_2021.dta", force generate(y)

gen year = 2011
replace year = 2016 if y == 1
replace year = 2021 if y == 2
destring est* moe* owner* renter*, replace force

// split tract, state and county into their own varnames
split geographicareaname, p(",") g(g_)
rename g_1 tract
rename g_2 county
rename g_3 state

replace tract = substr(tract, 13, .)
replace county = substr(county, 1, strrpos(county, "County")-2)

merge m:1 year using "../cpi.dta"
drop if _merge ==2

// Use CPI to get Real Income:
rename est_12_month_incomemed median_annual_income_nom
gen median_annual_income_mcpi = median_annual_income_nom/med_cpi*100
gen median_annual_income_scpi = median_annual_income_nom/sticky_cpi*100

save "../acs_dp03_MA_censustracts.dta", replace