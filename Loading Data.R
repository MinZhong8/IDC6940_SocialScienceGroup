library(haven)
library(here)
library(tidyverse)

allGSSdata <- read_sas(here::here("GSS_sas", "gss7224_r3.sas7bdat"))

variables <- c(
  ## Demographics
  'EDUC', #level of education
  'CLASS', #self-assessed class standing
  'WRKSTAT', #employment status
  'MARITAL', #marital status
  'AGE', #age
  'CHILDS', #number of children
  'SEX',
  #'RACE',
  #'INCOME16',
  'RELIG', #religion
  
  ## General Attitudes
  #'TRUST', # Trust in most people
  #'FAIR', #Belief that others will take advantage of them
  
  
  ## Computer usage in core questions
  #'COMPUSE',
  #'WEBMOB',
  #'BROADBAND',
  #'MOBILEDATA',
  
  #Social interaction
  'SOCREL', #frequency of social interaction with relatives
  'SOCOMMUN', #frequency of social interaction with neighbors
  'SOCFREND', #frequency of social interaction with friends
  'SOCBAR', #frequency of going to bar
  
  ## ISSP Digital Societies
  'INTRNETUSE', #frequency of internet use in past 12 months
  'INTPRFSSNL',
  'UNPLUG',
  'INTSKILL', #skill at using internet
  'INTSURF', #skill at online searches
  'INTLITERACY', #knowledge of online information discretion
  'INTAPPS', #skill at learning new software
  'INTCOMM', #frequency of online communication
  'INTSHARE', #frequency of sharing photos and videos
  'INTSEARCH', #frequency of search
  'INTGAME', #uses internet for video games
  'INTSTREAM', #uses internet for streaming music or video
  'INTFNCL', #uses internet for financial transactions
  'INTMEET', #more comfortable meeting people online
  'INTLNLY', #feel lonely without internet
  'INTRUST', #Trust for people only met online
  'TRPPL' #Trust in others
)


data <- allGSSdata %>% select(variables) %>% na.omit()

#data <- data %>% filter(INTRNETUSE != F)

summary(data)

data %>% write.csv('data.csv')
