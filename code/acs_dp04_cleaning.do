// 			***Data import and cleaning for ACS DP04 datasets:***
clear all

// Directory Setup
local root_dir "~/OneDrive/School_Work/thesis"
// contains data and code folders with necessary files
cd "`root_dir'/data"

import delimited "R_exp/merge_2011.csv", varnames(1) clear 
save "temp/merge_2011.dta", replace 

import delimited "R_exp/merge_2010.csv", varnames(1) clear 
save "temp/merge_2010.dta", replace 

append using "temp/merge_2011.dta", generate(year)


