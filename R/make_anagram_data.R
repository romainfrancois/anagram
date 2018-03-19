
make_anagram_data <- function( words ){
  # only deal with letters from a to z
  assert_that(!any(str_detect(words, "[^a-z]")))

  # basic data
  data <- tibble(
    word = words,
    size = nchar(word),
    first = substr(word, 1, 1)
  ) %>%
    mutate( index = row_number() )

  # structure the data differently
  # so that we can quickly access words of a goven size
  # that start with a given letter
  # and easily get back to the indices in the original data
  empties <- tibble(
    first = letters,
    data  = map(letters, ~tibble( words = character(), indices = integer() ) )
  )

  grouped <- data %>%
    group_by(size, first) %>%
    summarise( data = list( tibble(words = word, indices = index ) ) ) %>%
    nest() %>%
    mutate( data = map( data, ~{
      anti_join( empties, .x, by = "first") %>%
        bind_rows(.x) %>%
        arrange(first)
    }))

  anagrams <- get_all_anagrams(grouped, nrow(data))

}
