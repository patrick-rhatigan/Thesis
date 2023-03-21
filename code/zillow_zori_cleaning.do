*Zillow ZORI data import & cleaning:
clear 

// Directory Setup
local root_dir "~/OneDrive/School_Work/thesis" 
// contains data and code folders with all necessary files

cd "`root_dir'" 

//import data
import delimited "data/zillow_zori_cp.csv", varnames(1) clear 


//renaming zori values for reshape
rename *1* zori_*1*
rename *2* zori_*2*
rename zori_zori_* zori_*

// reshape:
reshape long zori_, i(regionname) j(date) string
rename zori_ zori

gen date_1 = date(date, "MY", 2025)
format date_1 %tdmon-YY
drop date
rename date_1 date

drop if zori == .

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


