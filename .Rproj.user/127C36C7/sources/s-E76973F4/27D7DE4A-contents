library(tidyverse)

d <- read_csv('https://kuboweb.github.io/-kubo/stat/2008/c/fig/data3a.csv')

# データのプロット
d %>% ggplot(aes(x=x, y=y, color=f)) + geom_point(alpha=0.6)
d %>% ggplot(aes(x=f, y=y)) + geom_boxplot()


# モデル y~x
fit <- glm(y~x, data=d, family=poisson(link='log'))
summary(fit)

x_pred <- d$x
y_pred <- exp(fit$coefficients[1] + fit$coefficients[2] * x)
predict <- bind_cols(x_pred=x_pred, y_pred=y_pred)

d %>% ggplot(aes(x=x, y=y)) + 
  geom_point(alpha=0.6) + 
  geom_line(data=predict, aes(x=x_pred, y=y_pred))


# モデル y~f
fit <- glm(y~f, data=d, family=poisson(link='log'))
summary(fit)


# モデル y~x + f
fit <- glm(y~x + f, data=d, family=poisson(link='log'))
summary(fit)


rm(list=ls(all.names=TRUE))
