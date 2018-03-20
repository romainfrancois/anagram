#' tibble of points and frequencies of letters (a.k.a. tiles) as they appear in English-language edition of the Scrabble game
#'
#' @source [Scrabble Tile Distribution and Point Values](https://www.thespruce.com/scrabble-tile-distribution-and-point-values-412402)
#'
#' @format tibble with columns
#' - letter: letters from A to Z plus Blank/Wild tiles
#' - points: points (or values) of each letter in the game, from 0 to 10
#' - freq: frequency of each letter in the game, total of 100
"scrabble_points_and_frequencies"
