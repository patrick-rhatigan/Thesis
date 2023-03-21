// **CPI**
clear all

// Directory Setup
local root_dir "~/OneDrive/School_Work/thesis"
// contains data and code folders with necessary files
cd "`root_dir'/data"

import delimited "med_cpi.csv", varnames(1)

rename med* med_cpi
drop date
save "temp/med_cpi.dta", replace

import delimited "sticky_cpi.csv", varnames(1) clear
drop date
rename cor* sticky_cpi

merge 1:1 year using "temp/med_cpi.dta"
drop if _merge != 3
drop _merge
save "cpi.dta"

