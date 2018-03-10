#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
CharacterVector anagram_get( String word, DataFrame words_internal ){
  return CharacterVector::create( word ) ;
}
