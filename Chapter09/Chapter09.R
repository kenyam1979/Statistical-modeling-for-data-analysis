library(tidyverse)
library(rstan)

rm(list=ls(all.names=TRUE))

download.file('https://kuboweb.github.io/-kubo/stat/iwanamibook/fig/gibbs/d.RData', './Chapter09/d.RData')
load('./Chapter09/d.RData')

d %>% ggplot(aes(x=x, y=y)) + geom_point()

fit.glm <- glm(y~x, data=d, family=poisson(link=log))
summary(fit.glm)

d.list <- list(
  N = nrow(d),
  x = d$x,
  y = d$y
)

fit.stan <- stan(
  file = './Chapter09/model1.stan',
  data = d.list)

print(fit.stan)
plot(fit.stan)
pairs(fit.stan, pars=c('beta1', 'beta2'))

## Reference
## https://fisproject.jp/2015/06/glm-stan/
