pacman::p_load(tidyverse, ggplot2, dplyr, lubridate, readr, readxl, hrbrthemes,
               scales, plotly, gganimate, cobalt, ivpack, stargazer, haven, ggthemes,
               magick, rdrobust)

## Simulate data
set.seed(12345678)
n=1000
rd.dat <- tibble(
  X = runif(n,0,2),
  W = (X>1),
  Y = 0.5 + 2*X + 4*W + -2.5*W*X + rnorm(n,0,.5)
)

## Plot raw data
plot1 <- rd.dat %>% ggplot(aes(x=X,y=Y)) + 
  geom_point() + theme_bw() +
  geom_vline(aes(xintercept=1),linetype='dashed') +
  scale_x_continuous(
    breaks = c(.5, 1.5),
    label = c("Untreated", "Treated")
  ) +
  xlab("Running Variable") + ylab("Outcome")


## Plot binned averages
rd.result <- rdplot(rd.dat$Y, rd.dat$X, 
                    c=1, 
                    title="RD Plot with Binned Average", 
                    x.label="Running Variable", 
                    y.label="Outcome")
bin.avg <- as_tibble(rd.result$vars_bins)

plot.bin <- bin.avg %>% ggplot(aes(x=rdplot_mean_x,y=rdplot_mean_y)) + 
  geom_point() + theme_bw() +
  geom_vline(aes(xintercept=1),linetype='dashed') +
  scale_x_continuous(
    breaks = c(.5, 1.5),
    label = c("Untreated", "Treated")
  ) +
  xlab("Running Variable") + ylab("Outcome")

## real data
final.ma.data <- readRDS('../ma/final_ma_data.rds')