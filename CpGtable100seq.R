library(dplyr)
p <- 0.7
N <- 100
count <- 0

sequences <- vector()
methy <- vector()
unmethy <- vector()

for (j in 1:N){
  seq <- vector()
  countm <- 0
  for (i in 1:10){
    r <- runif(1,0,1)
    if(r<p){
      seq = paste(seq,'m')
      count <- count+1
      countm <- countm + 1
    }
    else{
      seq = paste(seq,'u')
    }
  }
  sequences <- c(sequences,seq)
  methy <- c(methy,countm)
  unmethy <- c(unmethy,10-countm)
}

CpGmethylation <- data.frame(sequences,methy,unmethy)
CpGmethylation
write.csv(CpGmethylation,file='./output.csv')
print(paste("Avg. methylation =",count/N))
