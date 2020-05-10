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





https://leetcode.com/problems/longest-substring-without-repeating-characters/


Given a string, find the length of the longest substring without repeating characters.

Example 1:

Input: "abcabcbb"
Output: 3 
Explanation: The answer is "abc", with the length of 3. 
Example 2:

Input: "bbbbb"
Output: 1
Explanation: The answer is "b", with the length of 1.
Example 3:

Input: "pwwkew"
Output: 3
Explanation: The answer is "wke", with the length of 3. 
             Note that the answer must be a substring, "pwke" is a subsequence and not a substring.

*/

/**
Big O Annotation
Time complexity O(n) where n is the amount of elements in nums.
Space complexity O(n) where n is the amount of elements in nums.
*/
func lengthOfLongestSubstring(_ s: String) -> Int {
	
    /**
    First we get an array of the string
    to more conveniently access the indicies
    */
    var array = Array(s)

    /**
    We create a set to check for 
    processed character Set.contains 
    in contant time
    */
    var hash = Set<Character>()
    
    // We create a left and a right pointer
    var leftPointer: Int = 0
    var rightPointer: Int = 0
    
    // Our current maximum
    var maximum: Int = 0

    // While we still have characters to process...
    while rightPointer < array.count {
        
        // ... get the left and right character
        let left = array[leftPointer]
        let right = array[rightPointer]
        
        /**
        In the example of "abcabcbb",
        we first get left and right pointers
        on index 0 aka "a".

        Next we check if "a" is already 
        in the Set, no, so insert it.

        Then we move the right pointer forwards.
        "b", not in the list, add it.

        Next. "c" not in the list. Add it.
        Next. "a" already in the list,
        so remove "a" and continue to the next character.

        Once removed, our pointer is still on the 
        2nd "a", so we move it back to the array.
        And move along to the next characters.

        Always updating our maximum to the new total maximum.
        */

        if hash.contains(right) {
            
            hash.remove(left)
            leftPointer += 1
            
        } else {
            
            hash.insert(right)
            rightPointer += 1
            maximum = max(hash.count, maximum)
        }
    }

    return maximum
}