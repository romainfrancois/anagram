#include <Rcpp.h>
#include <RProgress.h>

using namespace Rcpp;
#include <array>


void process_word( int size, const char* word, int index, const DataFrame& data, List& out, IntegerVector& lengths){
  // first check if we have already seen the word
  if( !Rf_isNull(out[index]) ) return ;

  // counting how many times each letter from 'a' to 'z' appears in the word
  std::array<int, 128> counts ;
  std::fill( std::begin(counts), std::end(counts), 0 ) ;
  for( int i=0; i<size; i++){
    counts[ word[i] ]++ ;
  }
  std::array<bool,128> seen ;
  std::fill( std::begin(seen), std::end(seen), false ) ;

  std::vector<int>  matches_indices ;
  std::vector<SEXP> matches_anagrams ;

  for( int i=0; i<size; i++){
    char c = word[i] ;

    // skip if we have already seen this as the first letter
    if( seen[c] ) continue ;
    seen[c] = true ;

    // words that start with the c character
    // -'a' to align "a" with the first element of the list
    CharacterVector all_words = VECTOR_ELT( VECTOR_ELT(data[1], c - 'a'), 0 ) ;
    IntegerVector all_indices = VECTOR_ELT( VECTOR_ELT(data[1], c - 'a'), 1 ) ;

    int nw = all_words.size() ;

    for( int j=0; j<nw; j++){
      // copy the counts into a local array
      std::array<int,128> local_counts ;
      std::copy( std::begin(counts), std::end(counts), std::begin(local_counts) ) ;

      // For every character in the current word, we
      // decrement its count in the `local_counts` array
      //
      // if at any point we get a negative count it means
      // that the current word is not an anagram of the target word
      const char* w = CHAR(all_words[j]) ;

      bool match = true ;
      for(int j=0; j<size; j++, w++){
        if( --local_counts[*w] < 0 ) {
          match = false ;
          break ;
        }
      }
      if( match ){
        matches_indices.push_back( all_indices[j] ) ;
        matches_anagrams.push_back( all_words[j] ) ;
      }

    }
  }

  // materialize matches_anagrams into an R vector
  int n_results = matches_anagrams.size() ;
  CharacterVector results(n_results) ;

  for( int i=0; i<n_results; i++){
    results[i] = matches_anagrams[i] ;
  }

  // fill out
  for( int i=0; i<n_results; i++){
    out[matches_indices[i]] = results ;
    lengths[matches_indices[i]] = results.size() ;
  }

}


// size: the number of characters
// data: one row per first letter
// out:  final list to edit
void process_data( int size, DataFrame data, List& out, IntegerVector& lengths, RProgress::RProgress& pb){

  // by design data has 26 rows, one for each letter in a-z
  for( int i=0; i<26; i++){
    CharacterVector words = VECTOR_ELT( VECTOR_ELT( data[1], i ), 0 ) ;
    IntegerVector indices = VECTOR_ELT( VECTOR_ELT( data[1], i ), 1 ) ;

    for( int j=0; j<words.size(); j++){
      process_word( size, CHAR(words[j]), indices[j], data, out, lengths) ;
    }
    pb.tick(words.size()) ;
  }


}


// [[Rcpp::export]]
List get_all_anagrams( DataFrame grouped, int n){

  IntegerVector sizes = grouped[0] ;
  List datas = grouped[1] ;
  int nr = grouped.nrow() ;

  // the final list
  List out(n) ;
  IntegerVector lengths(n) ;

  RProgress::RProgress pb("[:bar] :spin :eta", n);
  for( int i=0; i<nr; i++){
    process_data( sizes[i], DataFrame(datas[i]), out, lengths, pb) ;
  }

  return List::create( out, lengths )  ;
}
