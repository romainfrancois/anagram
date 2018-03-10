library(tidyverse)

words_alpha <- read_lines("https://raw.githubusercontent.com/dwyl/english-words/master/words_alpha.txt")

words <- tibble(
  word = words_alpha,
  size = nchar(word),
  first = substr(word, 1, 1)
) %>% group_by(size, first)

use_data(words, overwrite = TRUE)

words_internal <- words %>%
  summarise( words = list(word) ) %>%
  nest()

use_data( words_internal, internal = TRUE, overwrite = TRUE)
