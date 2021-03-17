data {
  int<lower=0> N;
  int<lower=0> N_pot;
  int<lower=0> y[N];
  int<lower=0> f[N];
  int<lower=0> pot[N];
}

parameters {
  real beta1;
  real beta2;
  real r[N];
  real rp[N_pot];
  real<lower=0> sigma[2];
}

model {
  for (i in 1:N) {
		y[i] ~ poisson_log(beta1 + beta2 * f[i] + r[i] + rp[pot[i]]);
  }
  beta1 ~ normal(0, 100);  
  beta2 ~ normal(0, 100);  
  r ~ normal(0, sigma[1]);    
  rp ~ normal(0, sigma[2]);    
  sigma[1] ~ uniform(0, 1.0e+4); 
  sigma[2] ~ uniform(0, 1.0e+4); 
}
