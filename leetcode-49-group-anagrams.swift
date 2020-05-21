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





https://leetcode.com/problems/group-anagrams/


Given an array of integers, return indices of the two numbers such that they add up to a specific target.

You may assume that each input would have exactly one solution, and you may not use the same element twice.

Example:

Given nums = [2, 7, 11, 15], target = 9,

Because nums[0] + nums[1] = 2 + 7 = 9,
return [0, 1].

*/

/**
Big O Annotation
Time complexity O(n^2 log n) where n is the amount of elements in nums.
Because we are sorting each string within the loop.
Space complexity O(n) where n is the amount of elements in nums.
*/
func groupAnagrams(_ strs: [String]) -> [[String]] {
        
    /**
    We want to get a map.
    The idea is to get a sorted string
    as the base. And then all uses of that string.

    So example:

    [
        "aet": ["ate","eat","tea"],
        "ant": ["nat","tan"],
        "abt": ["bat"]
    ]
    */
    var anagrams: [String: [String]] = [:]
    
    // Iterate through the string
    for string in strs {
        
        // Get the character sorted version
        let sorted: [Character] = Array(string).sorted()

        // And append it's current string of strs
        anagrams[String(sorted), default: []].append(string)
    }
    
    // Now let's init a result array
    var result: [[String]] = []
    
    // And simply append every [String] value
    for (key, value) in anagrams {
        result.append(value)
    }
    
    return result
}