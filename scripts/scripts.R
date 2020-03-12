
#install.packages("foreign")

library(foreign)
dataset <- read.spss("./data/sleep.sav", to.data.frame = T)

dataset.labels <- as.data.frame(attr(dataset, "variable.labels")) 
names(dataset.labels)

colnames(dataset.labels)[1] <- "labels"
labels <- dataset.labels$labels
labels <-as.character(labels)
labels

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

question_codes <- as.character(colnames(dataset))

questions <- swap_qn_l(question_codes,labels)


colnames(dataset) <- questions

View(dataset)
write.csv(dataset, file="/path/sleep_corr.csv", row.names = F)



