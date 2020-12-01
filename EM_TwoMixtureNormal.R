EM_TwoMixtureNormal = function(p, mu1, mu2, sd1, sd2, X, maxiter=1000, tol=1e-5)
{
  diff=1
  iter=0
  while (diff>tol & iter<maxiter) {
    ## E-step: compute omega:
    d1=dnorm(X, mean=mu1, sd=sd1) # compute density in two groups
    d2=dnorm(X, mean=mu2, sd=sd2)
    omega=d1*p/(d1*p+d2*(1-p))
    ## M-step: update p, mu and sd
    p.new=mean(omega)
    mu1.new=sum(X*omega) / sum(omega)
    mu2.new=sum(X*(1-omega)) / sum(1-omega)
    resid1=X-mu1
    resid2=X-mu2;
    sd1.new=sqrt(sum(resid1^2*omega) / sum(omega))
    sd2.new=sqrt(sum(resid2^2*(1-omega)) / sum(1-omega))
    ## calculate diff to check convergence
    diff=sqrt(sum((mu1.new-mu1)^2+(mu2.new-mu2)^2
                  +(sd1.new-sd1)^2+(sd2.new-sd2)^2))
    p=p.new;
    mu1=mu1.new;
    mu2=mu2.new;
    sd1=sd1.new;
    sd2=sd2.new;
    iter=iter+1;
    cat("Iter", iter, ": mu1=", mu1.new, ", mu2=",mu2.new, ", sd1=",sd1.new,
        ", sd2=",sd2.new, ", p=", p.new, ", diff=", diff, "\n")
  }
}

EM_TwoMixtureNormal(0.1,4,5,2,2,mix)
