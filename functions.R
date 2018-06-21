# functions.R

library(openxlsx)
xlDate = function(x){  as.Date(x, origin = "1899-12-30") }
source("AddItemResponses.R")
