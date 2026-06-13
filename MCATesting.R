library('FactoMineR')
library('Factoshiny')
library('factoextra')
library('tidyverse')

#import data from csv
data <- read.csv('data.csv') %>% select(!X)

#data columns to exclude from MCA
MCAexclude = c("EDUC","CLASS","WRKSTAT","MARITAL","AGE","CHILDS","SEX","RELIG", "INTRUST","TRPPL")

#create dataset for MCA
MCAdata <- data %>% select(!all_of(MCAexclude)) %>% lapply(factor) %>% data.frame()

mca1 <- MCA(MCAdata)

#This will open a web browser interface
Factoshiny(MCAdata)
