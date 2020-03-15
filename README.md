# kobor

<!-- badges: start -->
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

Kobor allows access to Kobo Toolbox from R

## Installation

You can install the released version of kobor from GitHub with:

``` r
install.packages("remotes")
remotes::install_github("ianhandel/kobor")
```

## Example

``` r
library(kobor)

# Download a list of assets/forms

forms <- kobor_assets(username = "fred", password = "mypassword")
forms

# Download data from a form
# Locate the form in the list of assets and copy its uid

mydata <- kobor_read(asset = "uid you noted", username = "fred", password = "mypassword")


```

