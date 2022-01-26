library(ggplot2)
library(visreg)
#library(equatiomatic)

## get data
dat <- mtcars

## visualize mpg vs. weight
ggplot(dat, aes(x = wt, y = mpg)) +
  geom_point() +
  labs(
    y = "Miles per gallon",
    x = "Car's weight (1000 lbs)"
  ) +
  theme_minimal()

## Fit a linear regression model
model <- lm(mpg ~ wt, data = dat)

## Fit a multiple linear regression model
#model <- lm(mpg ~ wt + hp + disp, data = dat)

## output model r-squared to a txt file 
model_stats <- summary(model)
model_eq <- extract_eq(model)

fileConn<-file("model_metrics.txt","w")
writeLines(c("model: ", as.character(model_stats$call)[2],"\n"), fileConn)
writeLines(c("r-squared: ", model_stats$r.squared), fileConn)
close(fileConn)

## Visualize model fit
visreg(model, ask = F)

png("Residuals.png")
## plot predicted vs. actual values
plot(x=predict(model), y=dat$mpg,
     xlab='Predicted Values',
     ylab='Actual Values',
     main='Predicted vs. Actual Values', cex = 1.5, pch = 19)

#add diagonal line for estimated regression line
abline(a=0, b=1, lwd = 2)
dev.off()