library('FactoMineR')
library('Factoshiny')
library('factoextra')
library('tidyverse')

#import data from csv
data <- read.csv('data.csv') %>% select(!X)

#data columns to exclude from MCA
MCAexclude = c("EDUC","CLASS","WRKSTAT","MARITAL","AGE","CHILDS","SEX","RELIG", "INTRUST","TRPPL")

#create dataset for MCA
MCAdata1 <- data %>% select(!all_of(MCAexclude)) %>% lapply(factor) %>% data.frame()

mca1 <- MCA(MCAdata1)

#This will open a web browser interface
#Factoshiny(MCAdata1)

#Going to try encoding the variable differently - instead of creating a boolean variable for each level of each variable, this will
##create a boolean that signifies if the variable is greater than the median value.

#I think this works? idk my brain kind of hurts with this code
MCAdata2 <- data %>% select(!all_of(MCAexclude)) %>% mutate(across(everything(),function(x){
  as.integer(x>median(data[[cur_column()]]))
    }
    )
  ) %>% lapply(factor) %>% data.frame()


mca2 <- MCA(MCAdata2)