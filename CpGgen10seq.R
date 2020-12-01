p <- 0.7
N <- 100
count <- 0
for (j in 1:N){
  seq <- ""
  for (i in 1:10){
    r <- runif(1,0,1)
    if(r<p){
      seq = paste(seq,'m')
      count <- count+1
    }
    else{
      seq = paste(seq,'u')
    }
  }
  print(seq)
}
print(paste("Avg. methylation =",count/N))

