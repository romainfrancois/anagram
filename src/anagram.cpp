#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
std::vector<std::string> anagram_get( String word, List words ){

  const char* s = word.get_cstring() ;
  int n = LENGTH(word.get_sexp()) ;

  std::vector<std::string> results ;

  for( int i=0; i<n; i++){
    char c = s[i] ;
    int idx = c - 'a' ;

    // words that start with the c character
    CharacterVector all_words = words[idx] ;

    results.push_back(CHAR(all_words[0].get())) ;

  }

  return results ;
}
