#set initial conditions, key- mai=initial mean of distribution a
#va= initial variance of distribution a,
#priora = prior probability of a
D
meana <- matrix(, nrow=100, ncol=1); meanb <- matrix(, nrow=100, ncol=1)
vara <- matrix(, nrow=100, ncol=1); varb <- matrix(, nrow=100, ncol=1)
mai <- 10; vai <- 1; mbi <- 2; vbi <- 0.5; meana[1,] <- mai; meanb <- mbi
vara[1,] <- vai; varb[1,] <- vbi
priora <- 0.5; priorb <- 0.5
for (i in 1:100) {
#posta= P(x|a)
posta <- (exp(-((D-mai)^2)/(2*vai)))/(sqrt(2*pi*vai))
postb <- (exp(-((D-mbi)^2)/(2*vbi)))/(sqrt(2*pi*vbi))

#a= P(a|x)
a <- (posta*priora)/(postb*priorb + posta*priora)
b <- (postb*priorb)/(postb*priorb + posta*priora)

maf <- (sum(D*a))/sum(a)
mbf <- (sum(D*b))/sum(b)

vaf <- (sum(a*(D-maf)^2))/sum(a)
vbf <- (sum(b*(D-mbf)^2))/sum(b)
maf
vaf
mbf
vbf
meana[i+1] <- maf; meanb[i+1] <- mbf; vara[i+1] <- vaf; varb[i+1] <- vbf
mai <- maf; mbi <- mbf; vai <- vaf; vbi <- vbf; priora <- mean(a); priorb <- mean(b)
}
maf; vaf; mbf; vbf
