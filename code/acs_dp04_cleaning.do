// 			***Data import and cleaning for ACS DP04 datasets:***
clear all

// Directory Setup
local root_dir "~/OneDrive/School_Work/thesis"
// contains data and code folders with necessary files
cd "`root_dir'/data"

import delimited "R_exp/merge_2021.csv", varnames(1) clear 
save "temp/merge_2021.dta", replace 

import delimited "R_exp/merge_2019.csv", varnames(1) clear 
save "temp/merge_2019.dta", replace 

import delimited "R_exp/merge_2018.csv", varnames(1) clear 
save "temp/merge_2018.dta", replace 

import delimited "R_exp/merge_2017.csv", varnames(1) clear 
save "temp/merge_2017.dta", replace 

import delimited "R_exp/merge_2016.csv", varnames(1) clear 
save "temp/merge_2016.dta", replace 

import delimited "R_exp/merge_2015.csv", varnames(1) clear 
save "temp/merge_2015.dta", replace 

import delimited "R_exp/merge_2014.csv", varnames(1) clear 
save "temp/merge_2014.dta", replace 

import delimited "R_exp/merge_2013.csv", varnames(1) clear 
save "temp/merge_2013.dta", replace 

import delimited "R_exp/merge_2012.csv", varnames(1) clear 
save "temp/merge_2012.dta", replace 

import delimited "R_exp/merge_2011.csv", varnames(1) clear 
save "temp/merge_2011.dta", replace 

import delimited "R_exp/merge_2010.csv", varnames(1)  clear 
save "temp/merge_2010.dta", replace 

rename est_moe* moe*

append using "temp/merge_2011.dta" "temp/merge_2012.dta" ///
	"temp/merge_2013.dta" "temp/merge_2014.dta" "temp/merge_2015.dta" ///
	"temp/merge_2016.dta" "temp/merge_2017.dta" "temp/merge_2018.dta" ///
	"temp/merge_2019.dta" "temp/merge_2021.dta", generate(year)
	
drop if (geography == "GEO_ID" || geography == "Geography")


