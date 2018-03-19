
#' vector of english words
#'
#' @format character vector of english words in lexicographic order
#' @source [dwyl/english-words](https://github.com/dwyl/english-words) on github
#'
#' @examples
#' sample(english, 10)
"english"

#' tibble of anagrams in english
#'
#' @format tibble with columns
#' - word: word
#' - size: number of letters in the word
#' - first: first letter of the word
#' - anagrams: list of anagrams of the word (list column)
#' - n_anagrams: number of anagrams
"data_english"
