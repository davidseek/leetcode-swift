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





https://leetcode.com/problems/minimum-number-of-steps-to-make-two-strings-anagram/


Given two equal-size strings s and t. In one step you can choose any character of t and replace it with another character.

Return the minimum number of steps to make t an anagram of s.

An Anagram of a string is a string that contains the same characters with a different (or the same) ordering.

 

Example 1:

Input: s = "bab", t = "aba"
Output: 1
Explanation: Replace the first 'a' in t with b, t = "bba" which is anagram of s.
Example 2:

Input: s = "leetcode", t = "practice"
Output: 5
Explanation: Replace 'p', 'r', 'a', 'i' and 'c' from t with proper characters to make t anagram of s.
Example 3:

Input: s = "anagram", t = "mangaar"
Output: 0
Explanation: "anagram" and "mangaar" are anagrams. 
Example 4:

Input: s = "xxyyzz", t = "xxyyzz"
Output: 0
Example 5:

Input: s = "friend", t = "family"
Output: 4
 

Constraints:

1 <= s.length <= 50000
s.length == t.length
s and t contain lower-case English letters only.

*/

/**
Big O Annotation
Time complexity O(n) where n is the amount of characters in the longest string.
Space complexity O(n) where n is the amount of characters in t.
*/
func minSteps(_ s: String, _ t: String) -> Int {
        
    /**
    Init a new map depicting the characters 
    and the amount in what they appear in t
    */
    var hash: [Character: Int] = [:]
    
    // Iterate through string t
    for character in t {
        
        // And checked if it's in the map
        if let mapped = hash[character] {

            // If so, then increase the amount
            hash[character] = mapped + 1
        } else {

            // If not, set the amount to 0
            hash[character] = 1
        }
    }
    
    // Potential changes
    var changes: Int = 0 
    
    // Iterate through s
    for character in s {
        
        // Check if the character is mapped
        if let mapped = hash[character] {
            
            // And decrease the available count
            let newSum = mapped - 1

            // Update or potentially set to nil
            hash[character] = (newSum > 0) ? newSum : nil
            
        } else {
            
            // If not, add 1 change
            changes += 1
        }
    }
    
    return changes
}