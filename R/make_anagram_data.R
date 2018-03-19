#' @importFrom stringr str_detect
#' @importFrom assertthat assert_that
#' @importFrom tibble tibble
#' @importFrom dplyr mutate row_number group_by summarise bind_rows anti_join select
#' @importFrom tidyr nest
#' @importFrom purrr map
#' @importFrom magrittr %>%
make_anagram_data <- function( words ){
  # only deal with letters from a to z
  assert_that(!any(str_detect(words, "[^a-z]")))

  # basic data
  data <- tibble(
    word = words,
    size = nchar(word),
    first = substr(word, 1, 1)
  ) %>%
    mutate( index = row_number() - 1L )

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

  results <- get_all_anagrams(grouped, nrow(data))

  mutate( data, anagrams = results[[1]], n_anagrams = results[[2]] ) %>%
    select(-index)

}
