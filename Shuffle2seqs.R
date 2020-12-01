library(dplyr)
p1 <- 0.2
N1 <- 10
count1 <- 0

p2 <- 0.7
N2 <- 10
count2 <- 0

sequences1 <- vector()
methy1 <- vector()
unmethy1 <- vector()

sequences2 <- vector()
methy2 <- vector()
unmethy2 <- vector()

for (j in 1:N1){
  seq1 <- vector()
  countm1 <- 0
  for (i in 1:10){
    r1 <- runif(1,0,1)
    if(r1<p1){
      seq1 <- paste(seq1,'m')
      count1 <- count1+1
      countm1 <- countm1 + 1
    }
    else{
      seq1 <- paste(seq1,'u')
    }
  }
  sequences1 <- c(sequences1,seq1)
  methy1 <- c(methy1,countm1)
  unmethy1 <- c(unmethy1,10-countm1)
}

for (j in 1:N2){
  seq2 <- vector()
  countm2 <- 0
  for (i in 1:10){
    r2 <- runif(1,0,1)
    if(r2<p2){
      seq2 <- paste(seq2,'m')
      count2 <- count2+1
      countm2 <- countm2 + 1
    }
    else{
      seq2 <- paste(seq2,'u')
    }
  }
  sequences2 <- c(sequences2,seq2)
  methy2 <- c(methy2,countm2)
  unmethy2 <- c(unmethy2,10-countm2)
}

CpGmethylation1 <- data.frame(sequences1,methy1,unmethy1)
CpGmethylation1
print(paste("Avg. methylation1 =",count1/N1))

CpGmethylation2 <- data.frame(sequences2,methy2,unmethy2)
CpGmethylation2
print(paste("Avg. methylation2 =",count2/N2))

set.seed(102)
mix <- sample(c(methy1,methy2))
mix
hist(mix)

