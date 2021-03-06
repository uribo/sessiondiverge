
<!-- README.md is generated from README.Rmd. Please edit that file -->

# sessiondiverge

[![CRAN
status](https://www.r-pkg.org/badges/version/sessiondiverge)](https://cran.r-project.org/package=sessiondiverge)
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![Travis build
status](https://travis-ci.org/uribo/sessiondiverge.svg?branch=master)](https://travis-ci.org/uribo/sessiondiverge)
[![Coverage
status](https://codecov.io/gh/uribo/sessiondiverge/branch/master/graph/badge.svg)](https://codecov.io/github/uribo/sessiondiverge?branch=master)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/uribo/sessiondiverge?branch=master&svg=true)](https://ci.appveyor.com/project/uribo/sessiondiverge)

## One day, My R journey

``` r
library(ggplot2)

p <- 
  ggplot(iris, aes(Sepal.Length, Petal.Width)) +
  geom_point()
save.image("my_session.Rdata")
```

Finishing work. Then restart on the next day using `load()`.

``` r
load("my_session.Rdata")

p # OK. 

p + theme_bw()
# Error in theme_bw() : could not find function "theme_bw"
```

*R* Objects can be reproduced by `load()`, but we need to read the
package again. It takes labor and effort.

``` r
library(ggplot2)

p + theme_bw() # OK
```

The goal of **sessiondiverge** is to I/O session including package load
state.

``` r
library(sessiondiverge)
library(ggplot2)

p <- 
  ggplot(iris, aes(Sepal.Length, Petal.Width)) +
  geom_point()

write_session("my_session.Rdata")
```

Restart *R*.

``` r
sessiondiverge::read_session("my_session.Rdata")

p + theme_bw() # OK
```

Please note that this project is released with a [Contributor Code of
Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree
to abide by its terms.
