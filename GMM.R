library(dplyr)
p1 <- 0.2; p2 <- 0.7;
N1 <- 1000; N2 <- 1000
count1 <- 0; count2 <- 0

sequences1 <- vector(); sequences2 <- vector();
methy1 <- vector(); methy2 <- vector();
unmethy1 <- vector(); unmethy2 <- vector();

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
#CpGmethylation1
print(paste("Avg. methylation1 =",count1/N1))

CpGmethylation2 <- data.frame(sequences2,methy2,unmethy2)
#CpGmethylation2
print(paste("Avg. methylation2 =",count2/N2))

set.seed(102)
mix <- sample(c(methy1,methy2))
#mix
hist(mix, xlim=c(0,10))

hist(methy1, col=rgb(0.1,0.1,0.1,0.5),xlim=c(0,10), main='Initial',xlab='2 probabilities mixed')
hist(methy2, col=rgb(0.8,0.8,0.8,0.5), add=T)

EM_TwoMixtureNormal = function(p, mua, mub, sda, sdb, D, maxiter=10000, tol=1e-5)
{
  result <- vector()
  diff=1
  iter=0
  while (diff>tol & iter<maxiter) {
    
    ## E-step:
    
    d1=dnorm(D, mean=mua, sd=sda) # compute density in two groups
    d2=dnorm(D, mean=mub, sd=sdb)
    omega=d1*p/(d1*p+d2*(1-p))
    
    ## M-step: update p, mu and sd
    
    p.new=mean(omega)
    mua.new=sum(D*omega) / sum(omega)
    mub.new=sum(D*(1-omega)) / sum(1-omega)
    resid1=D-mua;
    resid2=D-mub;
    sda.new=sqrt(sum(resid1^2*omega) / sum(omega))
    sdb.new=sqrt(sum(resid2^2*(1-omega)) / sum(1-omega))
    
    ## calculate diff to check convergence
    
    diff=sqrt(sum((mua.new-mua)^2+(mub.new-mub)^2 + (sda.new-sda)^2+(sdb.new-sdb)^2))
    p=p.new;
    mua=mua.new;    mub=mub.new;
    sda=sda.new;    sdb=sdb.new;
    iter=iter+1;
    
    ## Print means and standard deviations for respective iterations
    
    cat("Iter", iter, ": mua=", mua.new,  " , mub=",mub.new, ", sda=",sda.new,
        ", sdb=",sdb.new, ", p=", p.new, ", diff=", diff, "\n")
    
    result <- c(mua, mub, sda, sdb)
  }
  return (result)
}

result = EM_TwoMixtureNormal(0.5,1,2,2,2,mix)

cat("meana=", result[1], " meanb=", result[2]," sda=", result[3], " sdb=", result[4], "\n")

h1 <- rnorm(100, mean = result[2], sd =result[4])
h2 <- rnorm(100, mean = result[1], sd =result[3])

hist(h1, col=rgb(0.1,0.1,0.1,0.5),xlim=c(0,10), main='GMM',xlab='2 Gaussians a and b')
hist(h2, col=rgb(0.8,0.8,0.8,0.5), add=T)

hist(methy2, col=rgb(0.1,0.1,0.1,0.5),xlim=c(0,10), main='Initial',xlab='2 probabilities mixed')
hist(methy1, col=rgb(0.8,0.8,0.8,0.5), add=T)

