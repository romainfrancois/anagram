#' tibble of points and frequencies of letters (a.k.a. tiles) as they appear in English-language edition of the Scrabble game
#'
#' @source [Scrabble Tile Distribution and Point Value](https://www.thespruce.com/scrabble-tile-distribution-and-point-values-412402)
#'
#' @format tibble with columns
#' - letter: letter A to Z plus Blank/Wild tiles
#' - points: points  letter of the word
#' - freq: frequency of the letter in the Scrabble game
"scrabble_points_and_frequencies"
devtools::document()
