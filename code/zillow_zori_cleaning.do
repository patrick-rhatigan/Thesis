*Zillow ZORI data import & cleaning:
clear 

// Directory Setup
local root_dir "~/OneDrive/School_Work/thesis" 
// contains data and code folders with all necessary files

cd "`root_dir'" 

//import data
import delimited "data/zillow_zori.csv", varnames(1) clear 

// analyze MA:
preserve
{
	keep if state == "MA"
 	
	by city, sort: gen unique_city = _n ==1
	count if unique_city

	count if city == "Boston"
	
	save "data/zillow_zori_ma.dta", replace 
	
  }
restore

  save "data/zillow_zori_usa.dta", replace


