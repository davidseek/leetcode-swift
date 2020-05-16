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





https://leetcode.com/problems/two-sum/


Given a paragraph and a list of banned words, return the most frequent word that is not in the list of banned words.  It is guaranteed there is at least one word that isn't banned, and that the answer is unique.

Words in the list of banned words are given in lowercase, and free of punctuation.  Words in the paragraph are not case sensitive.  The answer is in lowercase.

 

Example:

Input: 
paragraph = "Bob hit a ball, the hit BALL flew far after it was hit."
banned = ["hit"]
Output: "ball"
Explanation: 
"hit" occurs 3 times, but it is a banned word.
"ball" occurs twice (and no other word does), so it is the most frequent non-banned word in the paragraph. 
Note that words in the paragraph are not case sensitive,
that punctuation is ignored (even if adjacent to words, such as "ball,"), 
and that "hit" isn't the answer even though it occurs more because it is banned.
 

Note:

1 <= paragraph.length <= 1000.
0 <= banned.length <= 100.
1 <= banned[i].length <= 10.
The answer is unique, and written in lowercase (even if its occurrences in paragraph may have uppercase symbols, and even if it is a proper noun.)
paragraph only consists of letters, spaces, or the punctuation symbols !?',;.
There are no hyphens or hyphenated words.
Words only consist of letters, never apostrophes or other punctuation symbols.

*/

/**
Big O Annotation
Time complexity O(n) where n is the amount of words in paragraph.
Space complexity O(n) where n is the amount of words in paragraph.
*/
func mostCommonWord(_ paragraph: String, _ banned: [String]) -> String {
		
    /**
    First we get a Set from the banned 
    words for constant contains operation
    */
    let banHash: Set<String> = Set(banned)

    // In this dictionary we're going to count the occurrences
    var resultHash: [String: Int] = [:]

    // Getting the paragraph as array of words
    let words = getSanitizedComponents(of: paragraph)

    // Iterate through the words
    for word in words {
        
        // Check that the word is not empty and not banned
        guard !word.isEmpty && !banHash.contains(word) else {
            continue
        }

        // Count it's occurences
        if let mapped = resultHash[word] {
            resultHash[word] = mapped + 1
        } else {
            resultHash[word] = 1
        }
    }
    
    // And find the most used word
    return getCandidate(in: resultHash)
}

/**
Sanitizes the String by removing 
special characters and formating each word
with at least 1 white space in between.
*/
private func getSanitizedComponents(of paragraph: String) -> [String] {
    
    // Get mutable copy
    var paragraph = paragraph

    // Lowercase all letter
    paragraph = paragraph.lowercased()

    // Remove occurrences like "we,need to, remove,this"
    paragraph = paragraph.replacingOccurrences(of: ",", with: " ")

    // Filter out all none alphabetical letters
    paragraph = paragraph.filter { "abcdefghijklmmopqrstuvwxyz ".contains($0) }

    // And split by white spaces
    return paragraph.components(separatedBy: " ")
}

// Find the most used candidate
private func getCandidate(in hash: [String: Int]) -> String {
    
    // Reference
    var candidate: (key: String, value: Int)?
    
    // Iterate through dictionary
    for (key, value) in hash {
        
        // Check if we already have a candidate
        if let c = candidate {
            
            /**
            If so, check if the current one 
            has been used more often.
            */
            if c.value < value {

                // If so make new candidate
                candidate = (key, value)
            }
                
        } else {
            
            // Init with "any candidate"
            candidate = (key, value)
        }
    }

    /**
    We can forcefully unwrap the candidate,
    as we have been guaranteed a result.
    */
    return candidate!.key
}