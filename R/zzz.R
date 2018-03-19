#' @useDynLib anagram, .registration = TRUE
#' @importFrom Rcpp sourceCpp
NULL

#' @importFrom utils globalVariables
globalVariables(c("word", "size", "first", "index"))
