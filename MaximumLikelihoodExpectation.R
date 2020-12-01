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

sims <- 100
percent_list <- vector()
for (i in 1:100){
  percent_list <- c(percent_list, i/100)
}

# Create a sample of 50 numbers which are incremented by 1.
x <- seq(0,10,by = 1)

# Create the binomial distribution.
y <- dbinom(x,10,p)

# Plot the graph for this sample.
plot(x,y)



