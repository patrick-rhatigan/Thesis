// 			***** Summary Statistics *****
clear all

// Directory Setup
local root_dir "~/OneDrive/School_Work/thesis" 
// contains data and code folders with all necessary files
cd "`root_dir'" 

set scheme gg_tableau


//			***** SHI dataset *****
{

use "data/shi.dta", clear 


	// generate a dummy for being above the threshold ("untreated")
	gen above_threshold = (percent_shi > 10)
	//finding relevant census data. (most recent census given survey year)

	gen relevant_census = census_units_2010
	replace relevant_census = census_units_2000 if year < 2010
	replace relevant_census = census_units_1990 if year == 1997
	drop census*

	//labeling variables:
	lab var percent_shi "Percent SHI"
	lab var relevant_census "Relevant Census"
	lab var dev_units "Development Units"
	lab var shi_units "SHI Units"
	lab var year "Year"

	estpost summ shi_units percent_shi dev_units above_threshold relevant_census

	
	esttab using "figures+tables/b.tex", replace ////
	cells("mean(fmt(%6.2fc)) sd(fmt(%6.2fc)) count") nonumber ///
	nomtitle nonote noobs label booktabs ///
	collabels("Mean" "SD" "N")
	
	preserve
	{
	keep if year == 1997 | year == 2006 | year == 2011 ///
		| year == 2016 | year == 2020
	hist percent_shi, by(year)
	graph export "figures+tables/hist_percent_shi.png", replace as(png)
	}
	restore
	preserve 
	{
		collapse (mean) above_threshold percent_shi, by(year)
		
		lab var percent_shi "Avg Percent SHI"
		lab var above_threshold "Percent of Communities Above 10%"
		
		scatter above_threshold year, xline(10)
		graph export "figures+tables/percent_comm_above_10.png", replace as(png)
		
		scatter percent_shi year
		graph export "figures+tables/avg_percent_shi.png", replace as(png)
	}
	restore

	preserve 
		collapse (mean) above_threshold, by(community)
		count if above_threshold < 1 & above_threshold > 0
	restore 

	gen move = 1 // no movement above or below threshold
	sort community year

	replace move = 2 if above_threshold > above_threshold[_n-1] // moved above
	replace move = 0 if above_threshold < above_threshold[_n-1] // moved below

	replace move = 1 if year == 1997
	replace move = 1 if year == 2020
	count if move == 2
	count if move == 0

	//create histogram showing years in which communities moved above
	preserve
	{
		keep if move == 2 
		histogram year, frequency ytitle("") ///
			title("Number of Communities That Moved Above Threshold Over Time")
		graph export "figures+tables/hist_moved_above.png", replace as(png)
		}
	restore


}

//			***** ZORI *****
{

	use "data/zillow_zori_ma.dta", clear

	summ zori 
	preserve 
	{
		collapse (median) med_zori = zori ///
			(p95) zori_95 = zori ///
			(p5) zori_5 = zori, by(date)
		
		lab var med_zori "Median ZORI Index"
		lab var date "Date"
		
		twoway rarea zori_95 zori_5 date, color("174 199 232") ///
			|| line med_zori date, color("31 119 180")
		graph export "figures+tables/zori_timeseries_ma.png", replace as(png)

	}
	restore

}

//			***** ACS dataset *****
{
	
	use "data/acs_dp04_MA_censustracts.dta", clear
	
	estpost tabstat est_grossrent_mediandollars, by(year) s(mean sd n)
	
	esttab using "figures+tables/a.tex", replace ////
	cells("mean(fmt(%6.2fc)) sd(fmt(%6.2fc)) count") nonumber ///
	nomtitle nonote noobs label booktabs ///
	collabels("Mean" "SD" "N")
	
	hist est_grossrent_mediandollars, by(year, cols(2))
	
	use "data/acs_dp03_MA_censustracts.dta"
	lab var median_annual_income_nom "Nominal Income"
	lab var median_annual_income_mcpi "Income 2006 Dollars - Median CPI"
	lab var median_annual_income_scpi "Income 2006 Dollars - Sticky Prices CPI"


	estpost tabstat median_annual_income_nom median_annual_income_mcpi ///
	 median_annual_income_scpi, by(year) c(stat) s(mean sd n)
	 
	esttab using "figures+tables/d.tex", replace ////
		main(mean %8.2fc) aux(sd  %8.2fc) nostar nonumber unstack ///
	   nonote noobs label ///
		collabels(none) eqlabels("2011" "2016" "2021")
}
