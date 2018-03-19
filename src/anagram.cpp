#include <Rcpp.h>
using namespace Rcpp;
#include <array>


void process_data( int size, DataFrame data, List& out){
  std::array<int, 128> counts ;

  // by design data has 26 rows, one for each letter in a-z
  for( int i=0; i<26; i++){
    char letter = i + 'a' ;



  }


}


// [[Rcpp::export]]
List get_all_anagrams( DataFrame grouped, int n){

  IntegerVector sizes = grouped[0] ;
  List datas = grouped[1] ;
  int nr = grouped.nrow() ;

  // the final list
  List out(n) ;

  for( int i=0; i<nr; i++){
    process_data( sizes[i], DataFrame(datas[i]), out) ;
  }

  return out ;
}




// [[Rcpp::export]]
std::vector<std::string> anagram_get( String word, List words ){
  const char* s = word.get_cstring() ;
  int n = LENGTH(word.get_sexp()) ;

  // counting how many times each letter from 'a' to 'z' appears in the word
  std::array<int, 128> counts ;
  std::fill( std::begin(counts), std::end(counts), 0 ) ;
  for( int i=0; i<n; i++){
    counts[ s[i] ]++ ;
  }
  std::array<bool,128> seen ;
  std::fill( std::begin(seen), std::end(seen), false ) ;

  std::vector<std::string> results ;

  for( int i=0; i<n; i++){
    char c = s[i] ;

    // skip if we have already seen this as the first letter
    if( seen[c] ) continue ;
    seen[c] = true ;

    // words that start with the c character
    // -'a' to align "a" with the first element of the list
    CharacterVector all_words = words[c - 'a'] ;

    std::for_each( std::begin(all_words), std::end(all_words), [&counts, n, &results](auto st){
      // copy the counts into a local array
      std::array<int,128> local_counts ;
      std::copy( std::begin(counts), std::end(counts), std::begin(local_counts) ) ;

      // For every character in the current word, we
      // decrement its count in the `local_counts` array
      //
      // if at any point we get a negative count it means
      // that the current word is not an anagram of the target word
      const char* w = CHAR(st) ;
      for(int j=0; j<n; j++, w++){
        if( --local_counts[*w] < 0 ) return ;
      }

      // if we survive the loop, we have an anagram
      results.push_back( std::string(st) ) ;
    }) ;

  }

  return results ;
}
