#set initial conditions, key- mai=initial mean of distribution a
#va= initial variance of distribution a,
#priora = prior probability of a
library(dplyr)
D <- mix
meana <- matrix(methy1, nrow=10, ncol=1); meanb <- matrix(methy2, nrow=10, ncol=1)
vara <- matrix(vector(), nrow=10, ncol=1); varb <- matrix(vector(), nrow=10, ncol=1)
mai <- 5; vai <- 1; mbi <- 5; vbi <- 1; meana[1,] <- mai; meanb[1,] <- mbi
vara[1,] <- vai; varb[1,] <- vbi
priora <- 0.5; priorb <- 0.5
for (i in 1:20) {
  #posta= P(x|a)
  posta <- (exp(-((D[i]-mai)^2)/(2*vai)))/(sqrt(2*pi*vai))
  postb <- (exp(-((D[i]-mbi)^2)/(2*vbi)))/(sqrt(2*pi*vbi))
  
  #a= P(a|x)
  a <- (posta*priora)/(postb*priorb + posta*priora)
  b <- (postb*priorb)/(postb*priorb + posta*priora)
  
  maf <- (sum(D[i]*a))/sum(a)
  mbf <- (sum(D[i]*b))/sum(b)
  
  vaf <- (sum(a*(D[i]-maf)^2))/sum(a)
  vbf <- (sum(b*(D[i]-mbf)^2))/sum(b)
  maf;  vaf;  mbf;  vbf;
  meana[i+1] <- maf; meanb[i+1] <- mbf; vara[i+1] <- vaf; varb[i+1] <- vbf
  mai <- maf; mbi <- mbf; vai <- vaf; vbi <- vbf; priora <- meana[i]; priorb <- meanb[i]
}
maf; vaf; mbf; vbf
