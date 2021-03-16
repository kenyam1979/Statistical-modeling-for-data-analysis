data {
  int N;
  vector[N] x;
  int y[N];
}

parameters {
  real beta1;
  real beta2;
}

model {
  for (i in 1:N)
    y[i] ~ poisson_log(beta1 + beta2 * x[i]);
}
