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

school2003 <- read.spss("schi.sav", to.data.frame=TRUE)
prepare(school2003, "school2003")

#
# Not all students tak all areas
# this is why there are three datasets
#

item2003 <- read.spss("intcogn.sav", to.data.frame=TRUE)
prepare(item2003, "item2003")

student2003 <- read.spss("stud.sav", to.data.frame=TRUE)
prepare(student2003, "student2003")

