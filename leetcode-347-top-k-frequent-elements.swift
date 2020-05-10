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





https://leetcode.com/problems/top-k-frequent-elements/


Given a non-empty array of integers, return the k most frequent elements.

Example 1:

Input: nums = [1,1,1,2,2,3], k = 2
Output: [1,2]
Example 2:

Input: nums = [1], k = 1
Output: [1]
Note:

You may assume k is always valid, 1 ≤ k ≤ number of unique elements.
Your algorithm's time complexity must be better than O(n log n), where n is the array's size.
It's guaranteed that the answer is unique, in other words the set of the top k frequent elements is unique.
You can return the answer in any order.

*/

/**
Big O Annotation
Time complexity O(n log n) because of the sorting overhead.
Space complexity O(n) where n is the amount of elements in nums.
*/
func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
    
    /**
    Hash map of nums elements and 
    their frequency
    */
    var hash: [Int: Int] = [:]
    
    // Iterate through nums
    for element in nums {
        
        /**
        Check if we have already mapped 
        the given element..
        */
        if let mapped = hash[element] {

            // ... if so, add 1
            hash[element] = mapped + 1

        } else {

            // If not, set 1
            hash[element] = 1
        }
    }
    
    // Sort the map by value descending
    let sorted = hash.sorted { element1, element2 in 
        return element1.value > element2.value
    }
    
    // Map to only have array of nums elements
    let mapped = sorted.map { element in
        return element.key
    }
    
    /**
    Return the desired elements 
    as a new array from 0 up to but not including k.

    Safe operation as stated in the notes:
    "You may assume k is always valid, 1 ≤ k ≤ number of unique elements."
    */
    return Array(mapped[0..<k])
}