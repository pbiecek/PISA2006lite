#
# This function extracts information from sav file and save two rda files with data and colnames
#

library(foreign) 

prepare <- function(dataset, name) {
  name2 <- paste(name, "dict",sep="")
  colnames(dataset) <- toupper(colnames(dataset))
  for (i in 1:ncol(dataset))
    if (class(dataset[,i]) == "factor")
      dataset[,i] <- factor(dataset[,i])
  
  dict <- attributes(dataset)$variable.labels
  names(dict) <- toupper(names(dict))
  assign(x=name2, value=dict)
  assign(x=name, value=dataset)
  
  save(list=name2, file=paste(name2, ".rda", sep=""), compression_level=9, compress="bzip2")
  save(list=name, file=paste(name, ".rda", sep=""), compression_level=9, compress="bzip2")
}

#
# School and School dict
#
school2006 <- read.spss("sch.sav", to.data.frame=TRUE)
prepare(school2006, "school2006")

#
# Not all students tak all areas
# this is why there are three datasets
#

item2006 <- read.spss("cog.sav", to.data.frame=TRUE)
prepare(item2006, "item2006")

student2006 <- read.spss("stud.sav", to.data.frame=TRUE)
prepare(student2006, "student2006")


parent2006 <- read.spss("par.sav", to.data.frame=TRUE)
prepare(parent2006, "parent2006")

scoredItem2006 <- read.spss("cogt.sav", to.data.frame=TRUE)
prepare(scoredItem2006, "scoredItem2006")


install_github('PISA2006lite', 'pbiecek') 
library(PISA2006lite)



school2006 <- PISA2006lite::school2006
for (i in 1:ncol(school2006)) {
  if (length(which(school2006[,i] %in% c("I", "M", "N"))) > 1)
      school2006[which(school2006[,i] %in% c("I", "M", "N")),i] <- NA
  school2006[,i] <- factor(school2006[,i])
  if (sum(is.na(as.numeric(levels(school2006[,i])))) == 0)
    school2006[,i] <- as.numeric(as.character(school2006[,i]))
}
save(school2006, file="school2006.rda")  




student2006 <- PISA2006lite::student2006
for (i in 1:ncol(student2006)) {
  if (length(which(student2006[,i] %in% c("I", "M", "N"))) > 1)
    student2006[which(student2006[,i] %in% c("I", "M", "N")),i] <- NA
  student2006[,i] <- factor(student2006[,i])
  if (sum(is.na(as.numeric(levels(student2006[,i])))) == 0)
    student2006[,i] <- as.numeric(as.character(student2006[,i]))
}
save(student2006, file="student2006.rda")  

