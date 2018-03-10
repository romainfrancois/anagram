library(tidyverse)

words_alpha <- read_lines("https://raw.githubusercontent.com/dwyl/english-words/master/words_alpha.txt")

alpha_words <- tibble(
  word = words_alpha,
  size = nchar(word),
  first = substr(word, 1, 1)
)

use_data(alpha_words, overwrite = TRUE)

empties <- tibble(
  first = letters,
  words = map(letters, ~character(0))
)

words_internal <- alpha_words %>%
  group_by(size, first) %>%
  summarise( words = list(word) ) %>%
  nest() %>%
  mutate(
    data = map( data, ~ {
      anti_join( empties, .x, by = "first") %>%
        bind_rows(.x) %>%
        arrange(first)
    })
  )

use_data( words_internal, internal = TRUE, overwrite = TRUE)
