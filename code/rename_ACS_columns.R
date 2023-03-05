library(readr)
library(tidyverse)
setwd("C:/Users/PRhat/OneDrive/School_Work/thesis/data/")

merge_2010 <- read_csv("ACS_MA_censustract/joint/merge_2010.csv", TRUE, skip = 1)

rename_col_df <- function(df, year) {
  cnames <- colnames(df)
  cnames <- cnames %>% str_replace_all("Estimate", "Est_") %>%
    str_replace_all("Margin of Error", "MOE_") %>%
    str_replace_all("Percent", "P_") %>%
    str_replace_all("Annotation of", "Ann_of_") %>%
    str_replace_all("!!HOUSING OCCUPANCY!!", " ") %>%
    str_replace_all("!!YEAR STRUCTURE BUILT!!", " ") %>%
    str_replace_all("!!ROOMS!!", " ") %>%
    str_replace_all("!!BEDROOMS!!", " ") %>%
    str_replace_all("!!HOUSING TENURE!!", " ") %>%
    str_replace_all("!!YEAR HOUSEHOLDER MOVED INTO UNIT!!", " ") %>%
    str_replace_all("!!MORTGAGE STATUS!!", " ") %>%
    str_replace_all("!!VEHICLES AVAILABLE!!", " ") %>%
    str_replace_all("!!SELECTED CHARACTERISTICS!!", " ") %>%
    str_replace_all("!!VALUE!!", "value_") %>%
    str_replace_all("!!SELECTED MONTHLY OWNER COSTS (SMOC)!!", "SMOC_") %>%
    str_replace_all("!!SELECTED MONTHLY OWNER COSTS AS A PERCENT OF INCOME (SMOCAPI)!!", "SMOCAPI_") %>%
    str_replace_all("!!GROSS RENT!!", "gross rent_") %>%
    str_replace_all("!!GROSS RENT AS A PERCENT OF INCOME!!", "GARPI_")

  colnames(df) <- cnames
  write_csv(df, paste0("R_exp/merge_", year, ".csv"))
}
rename_col_df(merge_2010, "2010")

merge_2011 <- read_csv("ACS_MA_censustract/joint/merge_2011.csv", TRUE, skip = 1)
rename_col_df(merge_2011, "2011")

merge_2012 <- read_csv("ACS_MA_censustract/joint/merge_2012.csv", TRUE, skip = 1)
rename_col_df(merge_2012, "2012")

merge_2013 <- read_csv("ACS_MA_censustract/joint/merge_2013.csv", TRUE, skip = 1)
rename_col_df(merge_2013, "2013")

merge_2014 <- read_csv("ACS_MA_censustract/joint/merge_2014.csv", TRUE, skip = 1)
rename_col_df(merge_2014, "2014")

merge_2015 <- read_csv("ACS_MA_censustract/joint/merge_2015.csv", TRUE, skip = 1)
rename_col_df(merge_2015, "2015")

merge_2016 <- read_csv("ACS_MA_censustract/joint/merge_2016.csv", TRUE, skip = 1)
rename_col_df(merge_2016, "2016")

merge_2017 <- read_csv("ACS_MA_censustract/joint/merge_2017.csv", TRUE, skip = 1)
rename_col_df(merge_2017, "2017")

merge_2018 <- read_csv("ACS_MA_censustract/joint/merge_2018.csv", TRUE, skip = 1)
rename_col_df(merge_2018, "2018")

merge_2019 <- read_csv("ACS_MA_censustract/joint/merge_2019.csv", TRUE, skip = 1)
rename_col_df(merge_2019, "2019")

merge_2021 <- read_csv("ACS_MA_censustract/joint/merge_2021.csv", TRUE, skip = 1)
rename_col_df(merge_2021, "2021")
