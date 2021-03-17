library(tidyverse)
library(glmmML)
library(rstan)


## Variance by individual difference 
d <- read_csv('https://kuboweb.github.io/-kubo/stat/iwanamibook/fig/hbm/data7a.csv')

d %>% ggplot(aes(x=y)) + geom_histogram()

##GLM
fit.glm <- glm(cbind(y, 8-y)~1, data=d, family=binomial())
summary(fit.glm)
1/(1+exp(-fit.glm$coefficients[1]))



##GLMM
fit.glmm <- glmmML(cbind(y, 8-y)~1, data=d, family=binomial(), cluster=id)
summary(fit.glmm)
1/(1+exp(-fit.glmm$coefficients[1]))



##Stan
d.list <- list(
  N = nrow(d),
  y = d$y
)

fit.stan <- stan(
  file = './Chapter10/model2.stan',
  data = d.list)

print(fit.stan)
plot(fit.stan)


beta <- summary(fit.stan)$summary['beta','mean']
r <- summary(fit.stan)$summary[2:101,'mean']
sigma <- summary(fit.stan)$summary['sigma','mean']



rm(list=ls(all.names=TRUE))






## Variance by individual difference  and by pot difference
d <- read_csv('https://kuboweb.github.io/-kubo/stat/iwanamibook/fig/hbm/nested/d1.csv')

d$f <- as.numeric(d$f=='T')
d$pot <- as.numeric(factor(d$pot))
##Stan
d.list <- list(
  N = nrow(d),
  N_pot = length(unique(d$pot)),
  y = d$y,
  f = d$f,
  pot = d$pot
)

fit.stan <- stan(
  file = './Chapter10/model3.stan',
  data = d.list)

print(fit.stan)
plot(fit.stan)



## Reference
## https://fisproject.jp/2015/06/glm-stan/
## https://ito-hi.blog.ss-blog.jp/2012-09-03
## https://ito-hi.blog.ss-blog.jp/2012-09-04