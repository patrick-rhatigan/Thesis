//  ACS Merge:
clear all

// Directory Setup
local root_dir "~/OneDrive/School_Work/thesis"
// contains data and code folders with necessary files
cd "`root_dir'/data"

use "acs_dp04_MA_censustracts.dta"

merge 1:1 tract county state year using "acs_dp03_MA_censustracts.dta"



*scatter est_12_month_incomemedianhouseho est_grossrent_mediandollars, by(year)
