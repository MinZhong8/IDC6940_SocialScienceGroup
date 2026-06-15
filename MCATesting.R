library('FactoMineR')
library('Factoshiny')
library('factoextra')
library('tidyverse')

#import data from csv
data <- read.csv('data.csv') %>% select(!X)

#data columns to exclude from MCA
MCAexclude = c("EDUC","CLASS","HISPANIC","WRKSTAT","MARITAL","AGE","CHILDS","SEX","RELTRAD","ATTEND","RELPERSN", "INTRUST","TRPPL")

#data columns for supplementary variables
suppVarNames = c("EDUC","CLASS","HISPANIC","WRKSTAT","MARITAL","AGE","CHILDS","SEX","RELTRAD","ATTEND","RELPERSN")

suppVars = data %>% select(all_of(suppVarNames)) %>% mutate(across(!all_of(c("EDUC","AGE","CHILDS")),factor))

#create dataset for MCA
MCAdata1 <- data %>% select(!all_of(MCAexclude)) %>% lapply(factor) %>% data.frame()

mca1 <- MCA(MCAdata1)

#This will open a web browser interface
#Factoshiny(MCAdata1)

#Going to try encoding the variable differently - instead of creating a boolean variable for each level of each variable, this will
##create a boolean that signifies if the variable is greater than the median value.

#I think this works? idk my brain kind of hurts with this code
MCAdata2 <- data %>% select(!all_of(MCAexclude) | c("INTRUST","TRPPL") ) %>% mutate(across(everything(),function(x){
  as.integer(x>median(data[[cur_column()]]))
    }
    )
  ) %>% lapply(factor) %>% data.frame()

## add suplementary vars
MCAdata2supps <- cbind(MCAdata2,suppVars)


#Some interpretation of the variables appearing on the plot: Variable_1 corresponds to the people who responded at a higher response level than the median
# generally indicating less internet usage or ability. 

mca2 <- MCA(MCAdata2)
