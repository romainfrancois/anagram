library(tidyverse)
library(anagram)

english <- read_lines("https://raw.githubusercontent.com/dwyl/english-words/master/words_alpha.txt")
use_data(english, overwrite = TRUE)

data_english <- anagram:::make_anagram_data(english)
use_data(data_english, overwrite = TRUE)
