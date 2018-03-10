
<!-- README.md is generated from README.Rmd. Please edit that file -->
anagram
=======

The goal of anagram is to retrieve anagrams of a word from a [list of english words](https://github.com/dwyl/english-words).

Installation
------------

You can install development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("romainfrancois/anagram")
```

Example
-------

The main function is `anagram`

``` r
library(anagram)
anagram("taste")
#> [1] "taste" "tates" "teats" "testa" "state"
```

The 📦 also has the list of words as a grouped tibble.

``` r
withr::with_seed(19820515, 
  dplyr::sample_n( alpha_words, 10 )  
)
#> # A tibble: 10 x 3
#>    word                   size first
#>    <chr>                 <int> <chr>
#>  1 anankastic               10 a    
#>  2 productibility           14 p    
#>  3 hydrarch                  8 h    
#>  4 bazookamen               10 b    
#>  5 bidirectional            13 b    
#>  6 alphabetizing            13 a    
#>  7 flurt                     5 f    
#>  8 riggish                   7 r    
#>  9 cassinoid                 9 c    
#> 10 clinicopathologically    21 c
```
