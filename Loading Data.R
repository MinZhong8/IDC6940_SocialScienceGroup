library(haven)
library(here)
library(tidyverse)

#Import entire GSS SAS file
allGSSdata <- read_sas(here::here("..","GSS_sas", "gss7224_r3.sas7bdat"))

#selecting variables to use
variables <- c(
  ## Demographics
  'EDUC', #level of education
  'CLASS', #self-assessed class standing
  'HISPANIC', #id as hispanic
  'WRKSTAT', #employment status
  'MARITAL', #marital status
  'AGE', #age
  'CHILDS', #number of children
  'SEX',
  #'RACE',
  #'INCOME16',
  #'RELIG', #religion
  'RELTRAD', #This is also religion, but a newer, more inclusive. the RELIG variable is a holdeover from earlier surveys
  'ATTEND', #frequency of attending religious services
  'RELPERSN', #strength of religious self-id

  
  ## General Attitudes
  #'TRUST', # Trust in most people
  #'FAIR', #Belief that others will take advantage of them
  
  
  ## Computer usage in core questions - including these results in a lot of missing values
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
  'INTHOME', #frequency of internet access at home
  'INTPUB', #frewuency of internet access in public
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
  'INTVIEWS', #frequency of discussing politics online
  'INTRUST', #Trust for people only met online
  'TRPPL' #Trust in others
)


#creating a subset of data including just the selected variables and removing all observations that contain NA values
data <- allGSSdata %>% select(variables) %>% na.omit()

summary(data)

#exporting dataframe to csv file
data %>% write.csv('data.csv')
