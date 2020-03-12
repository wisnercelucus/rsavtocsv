#install.packages("foreign")

library(foreign)
dataset <- read.spss("./data/sleep.sav", to.data.frame = T)

#convert the named vector variable.labels to DataFrame
dataset.labels <- as.data.frame(attr(dataset, "variable.labels")) 
names(dataset.labels)

colnames(dataset.labels)[1] <- "labels"
labels <- as.character(dataset.labels$labels)

#the swap function with swap not null labels with the questions code.
swap_qc_l <- function(q_codes, q_labels){
  questions <- character()
  assertthat::are_equal(length(q_codes), length(q_labels))
  for(i in 1:length(q_codes)){
    if(q_labels[i] == ""){
      questions[i] = q_codes[i]
    }else{
      questions[i] = q_labels[i]
    }
  }
  return(questions)
}


#Extract questions' codes
question_codes <- as.character(colnames(dataset))

#Call the swap_qc_l function
questions <- swap_qn_l(question_codes,labels)

#rename the columns names of the initial dataframe (dataset)
colnames(dataset) <- questions

#Verify that everything works perfectly
View(dataset)

#save the file to csv for exchange.
write.csv(dataset, file="/path/sleep_corr.csv", row.names = F)

