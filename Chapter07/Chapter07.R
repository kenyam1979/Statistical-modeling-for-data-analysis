library(tidyverse)
library(glmmML)

d <- read_csv('https://kuboweb.github.io/-kubo/stat/iwanamibook/fig/glmm/data.csv')

d %>% ggplot(aes(x=x, y=y)) + geom_point(alpha=0.6)
d %>% filter(x==4) %>% ggplot() + geom_histogram(aes(x=y))

fit <- glmmML(cbind(y, N-y) ~ x, data=d, family=binomial, cluster=id)
summary(fit)

x_pred <- seq(2, 6, by=0.1)
y_pred <- fit$coefficients[1] + fit$coefficients[2] * x_pred
n_pred <- 8*1/(1+exp(-y_pred))
pred <- bind_cols(x_pred=x_pred, n_pred=n_pred)

d %>%
  ggplot() + 
  geom_point(aes(x=x, y=y), alpha=0.6) +
  geom_line(data=pred, aes(x=x_pred, y=n_pred))
