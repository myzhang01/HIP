library(tidyverse)
library(readxl)
library(ggplot2)
library(Factoshiny)
library(FactoMineR)
library(matrixStats)

data = read_excel('data/weekdayend_all2.xlsx')

#### AT (Evening) ####

# Question regarding AT11 AT12language variable(s)

AT = c('tipi1',
       'tipi2',
       'tipi3',
       'tipi4',
       'tipi5',
       'tipi6',
       'tipi7',
       'tipi8',
       'tipi9',
       'tipi10')

data_AT = data %>%
  select(all_of(AT)) %>%
  mutate(across(AT[c(1:10)], as.factor)) %>%
  mutate(across(AT[c(1:10)], ~recode(.,
                                     `0` = 'Completely Agree',
                                     `1` = 'Somewhat Agree',
                                     `2` = 'Neither agree nor disagree',
                                     `3` = 'Somewhat Disagree',
                                     `4` = 'Completely Disagree')))



#### WM (Evening) ####

data$tot_score_WM1 = data$series11_yesno + data$series12_yesno + data$series13_yesno + data$series14_yesno + data$series15_yesno +
  data$series16_yesno + data$series17_yesno

WM1 = c('series11_yesno',
        'series12_yesno',
        'series13_yesno',
        'series14_yesno',
        'series15_yesno',
        'series16_yesno',
        'series17_yesno',
        'tot_score_WM1')

data_WM1 = data %>%
  select(all_of(WM1)) %>%
  mutate(across(WM1[c(1:7)], as.factor)) %>%
  mutate(across(WM1[c(8)], as.integer)) %>%
  mutate(across(WM1[c(1:7)], ~recode(.,
                                     `0` = 'Incorrect',
                                     `1` = 'Correct')))

summary(data_WM1)


data$tot_score_WM2 = data$series21_yesno + data$series22_yesno + data$series23_yesno + data$series24_yesno + data$series25_yesno +
  data$series26_yesno + data$series27_yesno

WM2 = c('series21_yesno',
        'series22_yesno',
        'series23_yesno',
        'series24_yesno',
        'series25_yesno',
        'series26_yesno',
        'series27_yesno',
        'tot_score_WM2')

data_WM2 = data %>%
  select(all_of(WM2)) %>%
  mutate(across(WM2[c(1:7)], as.factor)) %>%
  mutate(across(WM2[c(1:7)], ~recode(.,
                                     `0` = 'Incorrect',
                                     `1` = 'Correct')))

summary(data_WM2)


data$tot_score_WM3 = data$series31_yesno + data$series32_yesno + data$series33_yesno + data$series34_yesno + data$series35_yesno +
  data$series36_yesno + data$series37_yesno

WM3 = c('series31_yesno',
        'series32_yesno',
        'series33_yesno',
        'series34_yesno',
        'series35_yesno',
        'series36_yesno',
        'series37_yesno',
        'tot_score_WM3')

data_WM3 = data %>%
  select(all_of(WM3)) %>%
  mutate(across(WM3[c(1:7)], as.factor)) %>%
  mutate(across(WM3[c(1:7)], ~recode(.,
                                     `0` = 'Incorrect',
                                     `1` = 'Correct')))

summary(data_WM3)

TS_WM = c('tot_score_WM1',
          'tot_score_WM2',
          'tot_score_WM3')

data_TS_WM = data %>%
  select(all_of(TS_WM)) %>%
  mutate(across(TS_WM[c(1:3)], as.numeric))

data_TS_WM$row_min_WM = rowMins(as.matrix(data_TS_WM[,c(1,2,3)]), na.rm = TRUE)

summary(data_TS_WM)

data$normalize_WM1 = (data$tot_score_WM1 - mean(data$tot_score_WM1, na.rm = TRUE)) / sd(data$tot_score_WM1, na.rm = TRUE)
data$normalize_WM2 = (data$tot_score_WM2 - mean(data$tot_score_WM2, na.rm = TRUE)) / sd(data$tot_score_WM2, na.rm = TRUE)
data$normalize_WM3 = (data$tot_score_WM3 - mean(data$tot_score_WM3, na.rm = TRUE)) / sd(data$tot_score_WM3, na.rm = TRUE)

data_TS_WM$normalize_WM  = (data_TS_WM$row_min_WM- mean(data_TS_WM$row_min_WM, na.rm = TRUE)) / sd(data_TS_WM$row_min_WM, na.rm = TRUE)

data$normalize_WM = data_TS_WM$normalize_WM

