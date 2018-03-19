library(tidyverse)

english <- read_lines("https://raw.githubusercontent.com/dwyl/english-words/master/words_alpha.txt")
use_data(english, overwrite = TRUE)
