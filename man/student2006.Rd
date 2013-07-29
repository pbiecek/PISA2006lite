\name{student2006}
\alias{student2006}
\alias{student2006dict}
\docType{data}
\title{Data from student questionnaire PISA 2006}
\description{
  The english version of student questionnaire PISA 2006 is avaliable here \code{http://pisa2006.acer.edu.au/downloads/StQ_Questionnaire2006.pdf}.

  There is 398750 rows/pupils and 490 columns/variables.

  The \code{student2006} dataset is imported from this file \code{http://pisa2006.acer.edu.au/downloads/INT_stui_2006_v2.zip}.

  The codebook for this dataset is avaliable here \code{http://pisa2006.acer.edu.au/downloads/StQ_CodeBook_2006.pdf}.
  
  The variable names are avaliable in the named vector \code{student2006dict}.
}
\usage{data(student2006)}
\references{
  http://pisa2006.acer.edu.au/downloads.php
}
\author{
 Dataset created by OECD, transformed by Przemyslaw Biecek
}
\seealso{\code{\link{school2006}}, \code{\link{item2006}}}
\examples{
library(PISA2006lite)

# first few rows
student2006[1:5,1:10]
head(student2006dict)

# averages in MATH, based on PV1MATH
means <- unclass(by(
    student2006[,c("PV1MATH","W_FSTUWT")], 
    student2006[,"CNT"], 
    function(x) weighted.mean(x[,1], x[,2])))
means <- sort(means)
dotchart(means, pch=19)

}
\keyword{datasets}
