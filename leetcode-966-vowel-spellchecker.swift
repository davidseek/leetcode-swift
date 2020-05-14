/**

Copyright (c) 2020 David Seek, LLC

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
OR OTHER DEALINGS IN THE SOFTWARE.





https://leetcode.com/problems/vowel-spellchecker/


Given a wordlist, we want to implement a spellchecker that converts a query word into a correct word.

For a given query word, the spell checker handles two categories of spelling mistakes:

Capitalization: If the query matches a word in the wordlist (case-insensitive), then the query word is returned with the same case as the case in the wordlist.
Example: wordlist = ["yellow"], query = "YellOw": correct = "yellow"
Example: wordlist = ["Yellow"], query = "yellow": correct = "Yellow"
Example: wordlist = ["yellow"], query = "yellow": correct = "yellow"
Vowel Errors: If after replacing the vowels ('a', 'e', 'i', 'o', 'u') of the query word with any vowel individually, it matches a word in the wordlist (case-insensitive), then the query word is returned with the same case as the match in the wordlist.
Example: wordlist = ["YellOw"], query = "yollow": correct = "YellOw"
Example: wordlist = ["YellOw"], query = "yeellow": correct = "" (no match)
Example: wordlist = ["YellOw"], query = "yllw": correct = "" (no match)
In addition, the spell checker operates under the following precedence rules:

When the query exactly matches a word in the wordlist (case-sensitive), you should return the same word back.
When the query matches a word up to capitlization, you should return the first such match in the wordlist.
When the query matches a word up to vowel errors, you should return the first such match in the wordlist.
If the query has no matches in the wordlist, you should return the empty string.
Given some queries, return a list of words answer, where answer[i] is the correct word for query = queries[i].

 

Example 1:

Input: wordlist = ["KiTe","kite","hare","Hare"], queries = ["kite","Kite","KiTe","Hare","HARE","Hear","hear","keti","keet","keto"]
Output: ["kite","KiTe","KiTe","Hare","hare","","","KiTe","","KiTe"]

*/

/**
Big O Annotation
Time complexity O(n) where n is the amount of elements in queries.
Space complexity O(n) where n is the amount of elements in wordlist.
*/
func spellchecker(_ wordlist: [String], _ queries: [String]) -> [String] {
        
    // Get all vowels
    let vowels: Set<Character> = ["a", "e", "i", "o", "u"]
    
    /**
    We will need one set of words to compare 
    for equality in constant time
    */
    var words: Set<String> = Set(wordlist)

    /**
    Then we will have one dictionary of lowercased words
    but with the regularly spelled word as the value.

    Using the FIRST occurance of that word.
    */
    var lowercases: [String: String] = [:]

    /**
    And one dictionary of words without vowels.
    Keto will become ["k?t?": Keto]...
    ... with the value in the proper spelling.

    Using the FIRST occurance of that word.
    */
    var vowelRemoved: [String: String] = [:]
    
    // Iteratethrough all words
    for word in wordlist {
        
        // Get a lowercased instance
        let lowercased = word.lowercased()
        
        // Add each word in a lowercased version
        if lowercases[lowercased] == nil {
            lowercases[lowercased] = word
        }

        // And in a version without vowels
        var characters: [Character] = Array(lowercased)
        let mapped: [Character] = characters.map { character in
            return vowels.contains(character) ? "?" : character
        }
        
        /**
        In both version make sure to only 
        store the first occurance by checking for nil
        */
        if vowelRemoved[String(mapped)] == nil {
            vowelRemoved[String(mapped)] = word
        }
    }
    
    // In the end return the mapped query
    return queries.map { query in
                        
        let lowercased = query.lowercased()
                        
        var characters: [Character] = Array(lowercased)
        let mapped: [Character] = characters.map { character in
            return vowels.contains(character) ? "?" : character
        }

        // First check for equality
        if words.contains(query) {
            
            return query
            
        // Then for lower case options
        } else if let word = lowercases[lowercased] {
            
            return word
            
        // Lastly for vowel-free version
        } else if let word = vowelRemoved[String(mapped)] {
            
            return word
            
        // Otherwise return an empty string
        } else {
            
            return ""
        }
    }
}