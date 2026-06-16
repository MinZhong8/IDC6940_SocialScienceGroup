library('FactoMineR')
library('Factoshiny')
library('factoextra')
library('tidyverse')

#import data from csv
data <- read.csv('data.csv') %>% select(!X)

#data columns to exclude from MCA
MCAexclude = c("EDUC","CLASS","HISPANIC","WRKSTAT","MARITAL","AGE","CHILDS","SEX","RELTRAD","ATTEND","RELPERSN")

#data columns for supplementary variables
suppVarNames = c("EDUC","CLASS","HISPANIC","WRKSTAT","MARITAL","AGE","CHILDS","SEX","RELTRAD","ATTEND","RELPERSN")

#creating dataframe that ONLY has supplementary variables
suppVars = data |> select(all_of(suppVarNames)) |>
  mutate(across(!all_of(c("EDUC","AGE","CHILDS")),factor))      # here I'm making all the columns EXCEPT for EDUC, AGE, and CHILDS into factors because these three are numeric

#create dataset for MCA using original ordinal encoding (making sure to change data into factor data type - numeric data type will not work in MCA!)
MCAdata1 <- data |> select(!all_of(MCAexclude)) |>
  select(!all_of(c("INTRUST","TRPPL"))) |>              #I'm also excluding these two variables because they have a very high number of observation levels
  lapply(factor) |> data.frame()                        #Making it into a factor datatype

#creating MCA object using FactoMineR
mca1 <- MCA(MCAdata1)

#Running the below code will open a web app via Factoshiny
#Factoshiny(MCAdata1)

#Going to try encoding the variable differently - instead of creating a boolean variable for each level of each variable, this will
##create a boolean that signifies if the variable is greater than the median value.

#I think this works? idk my brain kind of hurts with this code

likert2Boolean <- function(x){
  (x>median(data[[cur_column()]])) |>         #this will be a boolean that will be true if x is greater than the median of the column
    as.integer() |> as.factor()               #then turning boolean into an integer for ease of reading graph and then into a factor
}

MCAdata2 <- data |>
  select(!all_of(MCAexclude)) |>                        # selecting variables not in the excluded set
  mutate(across(everything(),likert2Boolean))           # applying my likert to boolean function

## add suplementary vars - use this one with Factoshiny
MCAdata2WithSupps <- cbind(MCAdata2,suppVars)


#Some interpretation of the variables appearing on the plot: Variable_1 corresponds to the people who responded at a higher response level than the median
# generally indicating less internet usage or ability. 

mca2 <- MCA(MCAdata2)

MCAdata3 <- data |> select(!all_of(MCAexclude)) |>
  select(!all_of(c("INTRUST","TRPPL","SOCREL","SOCOMMUN","SOCFREND","SOCBAR"))) |>              #I'm also excluding these two variables because they have a very high number of observation levels
  mutate(across(everything(),likert2Boolean)) 

mca3 <-MCA(MCAdata3)

library(homals)
pcadata <- MCAdata2 <- data |>
  select(!all_of(MCAexclude))

res <- homals(pcadata, rank=1,level='ordinal')
plot(res)

pca1 = PCA(pcadata, graph=T)
pcaVar <- get_pca_var(pca1)
print(pcaVar)
