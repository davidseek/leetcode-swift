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





https://leetcode.com/problems/3sum/


Given an array nums of n integers, are there elements a, b, c in nums such that a + b + c = 0? Find all unique triplets in the array which gives the sum of zero.

Note:

The solution set must not contain duplicate triplets.

Example:

Given array nums = [-1, 0, 1, 2, -1, -4],

A solution set is:
[
  [-1, 0, 1],
  [-1, -1, 2]
]

*/

/**
Big O Annotation
Time complexity O(n^2) where n is the amount of elements in nums.
Space complexity O(1) where n is the amount of elements in nums.
*/
func threeSum(_ nums: [Int]) -> [[Int]] {
	
    var subsets: [[Int]] = []
    
    /**
    Get a mutable reference of nums
    and sort to improve BigO from O^3 to O^2
    */
    var nums = nums
    nums.sort()

    // Iterate through nums
    for (index, element) in nums.enumerated() {
        
        var firstIndex = index + 1
        var lastIndex = nums.count - 1		

        /**
        If the element at index is the same 
        as the element before,
        we will skip as we can ignore 
        duplicates.

        We already know the outcome.
        */
        if index > 0 && element == nums[index - 1] {
            continue
        }
    
        /**
        Inner loop while start
        is smaller than end.
        */
        while firstIndex < lastIndex {

            /**
            Like above we want to skip
            repeating elements at the end.
            */
            if lastIndex < nums.count - 1 && nums[lastIndex] == nums[lastIndex + 1] {
                lastIndex -= 1
                continue
            }

            // Get the sum of the current element and the two pointers
            let sum = element + nums[firstIndex] + nums[lastIndex]
        
            // If sum is 0
            if sum == 0 {

                // Add to subsets
                subsets.append([element, nums[firstIndex], nums[lastIndex]])

                // And move both pointers along
                firstIndex += 1
                lastIndex -= 1
                
            // Otherwise move either the front...
            } else if sum < 0 {

                firstIndex += 1
                
            // ... or end pointer along
            } else {
                lastIndex -= 1
            }
        }
    }

    return subsets
}