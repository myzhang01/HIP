library(tidyverse)
library(readxl)
library(ggplot2)
library(Factoshiny)
library(FactoMineR)
library(matrixStats)

data = read_excel('data/weekdayend_all2.xlsx')

#### DM_m (Morning) ####
## Description, keep age and school fee as.numeric,  make married, educ, school_yesno, and school_diploma as factor,
## and school_name & school_diploma_other as character. In addition, change the values (recode) for those that are factors.

data$high_educ = ifelse(data$educ > 2, "Higher than 10th grade education", "10th grade education or lower")

data$new_age = 2013 - data$year_birth

DM_m = c('age',
         'year_birth',
         'new_age',
         'month_birth',
         'married',
         'educ',
         'high_educ',
         'school_yesno',
         'school_name',
         'school_diploma',
         'school_diploma_other',
         'school_fee')

data_DMm = data %>%
  select(all_of(DM_m)) %>%
  mutate(across(DM_m[c(1, 2, 3)], as.integer)) %>%
  mutate(across(DM_m[c(4, 5, 6, 7, 8)], as.factor)) %>%
  mutate(school_name = as.character(school_name)) %>%
  mutate(married = recode(married,
                          `0` = 'Single',
                          `1` = 'Married',
                          `100` = 'Others'
  )) %>%
  mutate(educ = recode(educ,
                       `0` = 'Did not finish elementary school(below 8th grade)',
                       `1` = 'Graduated from elementary school (8th grade)',
                       `2` = 'graduated from junior secondary school (10th grade)',
                       `3` = 'Graduated from vocational education (TVET)',
                       `4` = 'Graduated from senior secondary school (12th grade)',
                       `5` = 'Attended or completed college'
  )) %>%
  mutate(school_yesno = recode(school_yesno,
                               `0` = 'No',
                               `1` = 'Yes'
  )) %>%
  mutate(school_name = as.character(school_name)) %>%
  mutate(school_diploma = recode(school_diploma,
                                 `0` = 'TVET diploma',
                                 `1` = 'Diploma from a college or university',
                                 `2` = 'Degree from a college or university',
                                 `3` = 'Others'
  )) %>%
  mutate(school_diploma_other = as.character(school_diploma_other))

data$high_educ = ifelse(data$educ > 2, "Higher than 10th grade education", "10th grade education or lower")


#### JA_m (morning) ####

JA_m = c('reason_salary',
         'reason_interest',
         'reason_tiring',
         'reason_learn',
         'reason_style',
         'reason_quickjob',
         'reason_family',
         'reason_school',
         'plan_year',
         'plan_month',
         'plan_school_year',
         'plan_school_month',
         'plan_marry',
         'plan_startown',
         'plan_migrate',
         'plan_migrate_des',
         'plan_migrate_home',
         'plan_open',
         'income_target',
         'expend_target')

data_JA = data %>%
  select(all_of(JA_m)) %>%
  mutate(across(JA_m[c(1:8, 13, 14, 15, 17)], as.factor)) %>%
  mutate(across(JA_m[c(9:12)], as.integer)) %>%
  mutate(across(JA_m[c(16, 18)], as.character)) %>%
  mutate(across(JA_m[c(1:8, 14, 15)], ~recode(.,
                                              `0` = 'No',
                                              `1` = 'Yes',
                                              `100` = 'Not Sure'))) %>%
  mutate(plan_marry = recode(plan_marry,
                             `0` = 'No',
                             `1` = 'Yes',
                             `-7` = 'I do not know',
                             `-8` = 'Not sure',
                             `-9` = 'Not applicable')) %>%
  mutate(plan_migrate_home = recode(plan_migrate_home,
                                    `0` = 'No',
                                    `1` = 'Yes',
                                    `7` = 'I do not know',
                                    `-8` = 'Not Sure',
                                    `-9` = 'Not applicable')) %>%
  mutate(plan_migrate_des = replace(plan_migrate_des, plan_migrate_des == 'Addis Abeba', 'Addis Ababa')) %>%
  mutate(plan_migrate_des = replace(plan_migrate_des, plan_migrate_des == 'Adis abeba', 'Addis Ababa')) %>%
  mutate(plan_migrate_des = replace(plan_migrate_des, plan_migrate_des == 'A.A', 'Addis Ababa')) %>%
  mutate(plan_migrate_des = replace(plan_migrate_des, plan_migrate_des == 'Adisabeba', 'Addis Ababa')) %>%
  mutate(plan_migrate_des = replace(plan_migrate_des, plan_migrate_des == 'Adiss Ababa', 'Addis Ababa')) %>%
  mutate(plan_migrate_des = replace(plan_migrate_des, plan_migrate_des == 'Addis  abeba', 'Addis Ababa')) %>%
  mutate(plan_migrate_des = replace(plan_migrate_des, plan_migrate_des == 'Addis abeba', 'Addis Ababa')) %>%
  mutate(plan_migrate_des = replace(plan_migrate_des, plan_migrate_des == 'Adis Abebe', 'Addis Ababa')) %>%
  mutate(plan_migrate_des = replace(plan_migrate_des, plan_migrate_des == 'A.a', 'Addis Ababa')) %>%
  mutate(plan_migrate_des = replace(plan_migrate_des, plan_migrate_des == 'Adis  Ababa', 'Addis Ababa')) %>%
  mutate(plan_migrate_des = replace(plan_migrate_des, plan_migrate_des == 'Adiss Ababa', 'Addis Ababa')) %>%
  mutate(plan_migrate_des = replace(plan_migrate_des, plan_migrate_des == 'Adis Ababa', 'Addis Ababa'))


#### TR_m (morning) ####

TR_m = c('trust_anoctr',
         'trust_samelang',
         'trust_difflang',
         'trust_govt',
         'trust_ethres',
         'trust_ancres')

data_TR = data %>%
  select(all_of(TR_m)) %>%
  mutate(across(TR_m[c(1, 2, 3, 4, 5, 6)], as.factor)) %>%
  mutate(across(TR_m[c(1, 2, 3, 4, 5, 6)], ~recode(.,
                                                   `0` = 'Strongly agree',
                                                   `1` = 'Somewhat agree',
                                                   `2` = 'Neither agree nor disagree',
                                                   `3` = 'Somewhat disagre',
                                                   `4` = 'Strongly Disagree')))

