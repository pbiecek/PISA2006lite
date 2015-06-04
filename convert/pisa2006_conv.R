# studentNew <- read.fwf("~/Downloads/INT_Stu06_Dec07.txt", len)
# colnames(studentNew) <- colnames(student2006)

lin <- readLines("~/_Archiwizowane_/pisa2006_format.txt")
lin2 <- readLines("~/_Archiwizowane_/pisa2006_format2.txt")
lin3 <- readLines("~/_Archiwizowane_/pisa2006_format3.txt")

po1 <- sapply(strsplit(lin3, split=" +"), `[`, 3)
po2 <- sapply(strsplit(lin3, split=" +"), `[`, 5)
len <- as.numeric(po2)-as.numeric(po1)+1

pos <- c(grep(lin, pattern="[Vv][Aa][Ll][Uu][Ee]"), length(lin)+1)

formaty <- gsub(sapply(strsplit(lin[pos[1:(length(pos)-1)]], split="[eE] "), `[`, 2), pattern="[^A-Za-z0-9]", replacement="")

slownik <- lapply(1:(length(pos)-1), function(i) {
    key=gsub(sapply(strsplit(lin[(pos[i]+1):(pos[i+1]-1)], split="="), `[`, 1), pattern="[^0-9]", replacement="")
    value=sapply(strsplit(sapply(strsplit(lin[(pos[i]+1):(pos[i+1]-1)], split="="), `[`, 2), split='"'), `[`, 2)
    names(value) = key
    na.omit(value)
})
names(slownik) = formaty

tmp <- strsplit(gsub(lin2, pattern=" ", replacement=""), split="\t")
s1 <- sapply(tmp, `[`, 1)
s2 <- gsub(sapply(tmp, `[`, 2),  pattern="[^A-Za-z0-9]", replacement="")

indy <- which(s2 %in% formaty)
for (ind in indy) {
  studentNew[,toupper(s1[ind])] <-   factor(slownik[[s2[ind]]][as.character(studentNew[,toupper(s1[ind])])],
                                             levels=slownik[[s2[ind]]])
}

s1[ind]
as.numeric(factor(student2006[,"ST06Q01"]))
student2006[,"ST07Q01"]

