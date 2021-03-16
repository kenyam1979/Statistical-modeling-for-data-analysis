library(tidyverse)

# 二項分布
d <- read_csv('https://kuboweb.github.io/-kubo/stat/iwanamibook/fig/binomial/data4a.csv')

d %>% ggplot(aes(x=x, y=y, color=f)) + geom_point(alpha=0.6)

fit <- glm(cbind(y, N-y) ~ x + f, data=d, family=binomial(link='logit'))
summary(fit)

y_pred <- predict(fit)
n_pred <- 8*1/(1+exp(-y_pred))
pred <- bind_cols(x_pred=d$x, n_pred=n_pred)
     
d %>%
  ggplot() + 
  geom_point(aes(x=x, y=y, color=f), alpha=0.6) +
  geom_line(data=pred[d$f=='C',], aes(x=x_pred, y=n_pred), color='red') + 
  geom_line(data=pred[d$f=='T',], aes(x=x_pred, y=n_pred), color='green')


rm(list=ls(all.names=TRUE))






# ガンマ分布
download.file('https://kuboweb.github.io/-kubo/stat/iwanamibook/fig/gamma/d.RData', './Chapter06/d.RData')
load('./Chapter06/d.RData')

d %>% ggplot(aes(x=x, y=y)) + geom_point(alpha=0.6)

fit <- glm(y ~ log(x), data=d, family=Gamma(link='log'))
summary(fit)

y_pred <- predict(fit)
mu_pred <- exp(y_pred)
pred <- bind_cols(x_pred=d$x, mu_pred=mu_pred)

d %>%
  ggplot() + 
  geom_point(aes(x=x, y=y), alpha=0.6) +
  geom_line(data=pred, aes(x=x_pred, y=mu_pred))


rm(list=ls(all.names=TRUE))
