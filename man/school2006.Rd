\name{school2006}
\alias{school2006}
\alias{item2006}
\alias{school2006dict}
\docType{data}
\title{Data from school questionnaire PISA 2006}
\description{
  The english version of school questionnaire PISA 2006 is avaliable here \code{http://pisa2006.acer.edu.au/downloads/ScQ_Questionnaire2006.pdf}.

  There is 10274 rows/schools and 192 columns/variables.

  The \code{school2006} dataset is imported from this file \code{http://pisa2006.acer.edu.au/downloads/INT_schi_2006.zip}.

  The codebook for this dataset is avaliable here \code{http://pisa2006.acer.edu.au/downloads/ScQ_CodeBook_2006.pdf}.
  
  The variable names are avaliable in the named vector \code{school2006dict}.
}
\usage{data(school2006)}
\references{
  http://pisa2006.acer.edu.au/downloads.php
}
\author{
 Dataset created by OECD, transformed by Przemyslaw Biecek
}
\seealso{\code{\link{student2006}}, \code{\link{item2006}}}
\examples{
library(PISA2006lite)

# first few rows
school2006[1:5,1:5]
head(school2006dict)

# merge of school and student data
means <- unclass(by(
    student2006[,c("PV1MATH","W_FSTUWT")], 
    list(student2006[,"CNT"],student2006[,"SCHOOLID"]), 
    function(x) weighted.mean(x[,1], x[,2])))

country.school.means <- na.omit(as.data.frame(as.table(means)))
boxplot(Freq~Var1, data=country.school.means, 
    horizontal=T, las=1, at=rank(tapply(country.school.means$Freq, country.school.means$Var1, mean)), pch='.')

}
\keyword{datasets}
