data {
  int<lower=0> N;
  int<lower=0> y[N];
}

parameters {
  real beta;
  real r[N];
  real<lower=0> sigma;
}

transformed parameters {
  real q[N];

  for (i in 1:N) {
    q[i] = inv_logit(beta + r[i]); 
  }
}

model {
  for (i in 1:N) {
		y[i] ~ binomial(8, q[i]); 
  }
  beta ~ normal(0, 100);  
  r ~ normal(0, sigma);    
  sigma ~ uniform(0, 1.0e+4); 
}
