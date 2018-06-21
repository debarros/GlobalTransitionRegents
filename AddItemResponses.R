# AddItemResponses.R
# This is the function that breaks apart the data and adds the desired variables
# path = file.choose()

AddItemResponses = function(path){
  
  x = read.xlsx(path)
  
  # fix date variables
  x$Birthdate = xlDate(x$Birthdate)
  x$Test.Date = xlDate(x$Test.Date)
  
  # set the number of MC questions
  MCQs = 30 
  
  # get the CRQ scores
  Part2 = substr(x$Constructed.Response.Array,1,3)
  Part3B = substr(x$Constructed.Response.Array,40,42)
  y = strsplit(x = substr(x$Constructed.Response.Array,4,39), split = "")
  z = as.data.frame(y)
  z = t(z)
  z = as.data.frame(z, stringsAsFactors = F)
  rownames(z) = NULL
  z = z[,3*(1:12)]
  colnames(z) = c("1", "2", "3A", "3B", "4", "5", "6A", "6B", "7", "8", "9A", "9B")
  CRQs = cbind.data.frame(Part2, z, Part3B)
  
  #create variables for all the MC questions
  for (i in 1:MCQs){
    assign(paste0("Q",i), gsub("D", 4, gsub("C", 3,gsub("B",2,gsub("A",1,substr(x$Multiple.Choice.Response.Array, i, i))))))
  }
  
  # Create the MC answer key
  answerKey = c("A", "C", "B", "A", "C", "B", "D", "B", "B", "D", "A", "C", "A", "A", "B", "D", "A", "A", "C", "A", "D", "D", "B", "D", "A", "C", "D", "C", "C", "D")
  answerKey = gsub("A", "1", answerKey)
  answerKey = gsub("B", "2", answerKey)
  answerKey = gsub("C", "3", answerKey)
  answerKey = gsub("D", "4", answerKey)
  
  # create a single variable for the student name
  LastFirst = paste0(x$Student.Last.Name, ", ", x$Student.First.Name)
  hasMidInit = !is.na(x$Student.Middle.Initial)
  LastFirst[hasMidInit] = paste0(x$Student.Last.Name[hasMidInit], ", ", x$Student.First.Name[hasMidInit], " ", x$Student.Middle.Initial[hasMidInit])
  
  
  
  
  # combine the new variables with the existing data
  z = do.call(cbind, mget(c("LastFirst", "x", paste0("Q", 1:MCQs))))
  z = cbind.data.frame(z, CRQs)
  
  itemsToCheck = setdiff(2:37,1+3*1:12)
  unique(unlist(CRQs[,itemsToCheck]))
  
  
  #fix the variables names
  Varnames = colnames(z)
  Varnames = gsub("x.","", Varnames)
  colnames(z) = Varnames
  
  return(z)
  
}
