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
  'RACECEN1', # Race
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
  'RELACTIV', #Frequency of attending religious activites other than service

  
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


#Recoding RACECEN1 to have fewer categories
data <- data |> mutate(RACECEN1.mod = RACECEN1 |> recode_values(
  1 ~ 1,
  2 ~ 2,
  3 ~ 3,
  c(4,5,6,7,8,9,10) ~ 4,
  c(14,15) ~ 5,
  16 ~ 6
)) |> select(!RACECEN1)




#exporting dataframe to csv file
data %>% write.csv('data.csv')


#Exporting variable names and descriptions to CSV file
n <- ncol(data)
labels_list <- map(1:n, function(x) attr(data[[x]], "label") )

# if a vector of character strings is preferable
labels_vector <- map_chr(1:n, function(x) attr(data[[x]], "label") )

# to make a simple codebook
variable_name <- names(data)
tibble(variable_name, description = labels_vector) %>% write_csv('VariableDescriptions.csv')


