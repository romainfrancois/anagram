
<!-- README.md is generated from README.Rmd. Please edit that file -->

# anagram

The goal of anagram is to retrieve anagrams of a word from a [list of
english words](https://github.com/dwyl/english-words).

## Installation

You can install development version from [GitHub](https://github.com/)
with:

``` r
# install.packages("devtools")
devtools::install_github("romainfrancois/anagram")
```

## Example

The main function is `anagrams`

``` r
library(anagram)
anagrams("taste")
#> [1] "state" "taste" "tates" "teats" "testa"
```

The 📦 also has the list of english words as a vector

``` r
sample( english, 10 )  
#>  [1] "sigfiles"       "coalholes"      "junior"         "puli"          
#>  [5] "monophysitical" "superseptal"    "irrevocably"    "eclegm"        
#>  [9] "relaxing"       "justles"
```

and a tibble of anagram data

``` r
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
data_english %>% 
  filter( n_anagrams == 4) %>% 
  sample_n(10)
#> # A tibble: 10 x 6
#>    word         size first  index anagrams  n_anagrams
#>    <chr>       <int> <chr>  <int> <list>         <int>
#>  1 archer          6 a      18848 <chr [4]>          4
#>  2 petara          6 p     232347 <chr [4]>          4
#>  3 eelgrass        8 e      95899 <chr [4]>          4
#>  4 rosety          6 r     274504 <chr [4]>          4
#>  5 chemiatrist    11 c      53646 <chr [4]>          4
#>  6 uracil          6 u     355246 <chr [4]>          4
#>  7 cerusites       9 c      51625 <chr [4]>          4
#>  8 namatio         7 n     196678 <chr [4]>          4
#>  9 therein         7 t     321242 <chr [4]>          4
#> 10 proto           5 p     253576 <chr [4]>          4
```
