#' anagrams
#'
#' @param word single word
#'
#' @return vector of anagrams of word
#'
#' @examples
#' anagrams("taste")
#'
#' @importFrom assertthat assert_that
#' @importFrom stringr str_to_lower str_detect str_split
#' @importFrom dplyr filter pull
#' @importFrom purrr pluck
#' @importFrom magrittr %>%
#' @export
anagrams <- function(word){
  word <- str_to_lower(word)
  assert_that(!str_detect(word, "[^a-z]"))
  assert_that(length(word)==1L)

  anagram::data_english %>%
    filter( word == !!word ) %>%
    pluck("anagrams", 1L)
}
