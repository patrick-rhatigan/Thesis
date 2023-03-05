clear all

global folder "~/OneDrive/School_Work/junior_spring/social_policy/final"

use "C:\Users\PRhat\census.dta"

gen renter = 0 
replace renter = 1 if rent > 1

keep if renter

*categorical variable for MA, RI or Other
gen ma_ri_d = 0 
*MA
replace ma_ri_d = 1 if stateicp == 3
*RI
replace ma_ri_d = 2 if stateicp == 5

*tab year ma_ri_d
summ rent, by(year ma_ri_d

tab 

/*
preserve 
collapse (mean) rent rentgrs, by (year ma_ri_d)

restore
*/
