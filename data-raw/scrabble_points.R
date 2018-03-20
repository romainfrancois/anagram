library(tidyverse)

# scrabble letter points distributions copied from https://www.thespruce.com/scrabble-tile-distribution-and-point-values-412402
tibble::tribble( # first time using datapasta
    ~Scrabble.Tile.Distribution.and.Point.Value,
                "Blank/Wild: 2 tiles, 0 points",
                          "A: 9 tiles, 1 point",
                         "B: 2 tiles, 3 points",
                         "C: 2 tiles, 3 points",
                         "D: 4 tiles, 2 points",
                         "E: 12 tiles, 1 point",
                         "F: 2 tiles, 4 points",
                         "G: 3 tiles, 2 points",
                         "H: 2 tiles, 4 points",
                          "I: 9 tiles, 1 point",
                          "J: 1 tile, 8 points",
                          "K: 1 tile, 5 points",
                          "L: 4 tiles, 1 point",
                         "M: 2 tiles, 3 points",
                          "N: 6 tiles, 1 point",
                          "O: 8 tiles, 1 point",
                         "P: 2 tiles, 3 points",
                         "Q: 1 tile, 10 points",
                          "R: 6 tiles, 1 point",
                          "S: 4 tiles, 1 point",
                          "T: 6 tiles, 1 point",
                          "U: 4 tiles, 1 point",
                         "V: 2 tiles, 4 points",
                         "W: 2 tiles, 4 points",
                          "X: 1 tile, 8 points",
                         "Y: 2 tiles, 4 points",
                         "Z: 1 tile, 10 points"
    ) %>%


separate( col =1, into = c("letter", "freq"), sep = ":") %>%
  separate( col = 2, sep = ",", into = c("freq", "points")) %>%
  mutate( freq= str_extract(freq, pattern = "\\d+")) %>%
  mutate(points= str_extract(points, pattern = "\\d+")) %>%
  mutate(freq=as.integer(freq), points=as.integer(points) ) %>%
  select(letter, points, freq )-> scrabble_points_and_frequencies

usethis::use_data(scrabble_points_and_frequencies, overwrite = TRUE)
