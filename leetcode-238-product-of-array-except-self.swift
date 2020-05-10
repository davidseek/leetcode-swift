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





https://leetcode.com/problems/product-of-array-except-self/


Given an array nums of n integers where n > 1,  return an array output such that output[i] is equal to the product of all the elements of nums except nums[i].

Example:

Input:  [1,2,3,4]
Output: [24,12,8,6]
Constraint: It's guaranteed that the product of the elements of any prefix or suffix of the array (including the whole array) fits in a 32 bit integer.

Note: Please solve it without division and in O(n).

Follow up:
Could you solve it with constant space complexity? (The output array does not count as extra space for the purpose of space complexity analysis.)

*/

/**
Big O Annotation
Time complexity O(n) where n is the amount of elements in nums.
Space complexity O(n) where n is the amount of elements in nums.
*/
func productExceptSelf(_ nums: [Int]) -> [Int] {
		
    var output: [Int] = Array(repeating: 1, count: nums.count)
    
    var prefixArray: [Int] = Array(repeating: 1, count: nums.count)
    var suffixArray: [Int] = Array(repeating: 1, count: nums.count)

    // Create prefix
    for (index, element) in nums.enumerated() {
        if index < nums.count - 1 {
            prefixArray[index + 1] = prefixArray[index] * element
        }
    }

    // Create Suffix
    for index in 0..<nums.count {
        let index_ = (nums.count - 1) - index 
    
        if index_ > 0 {
            let element = nums[index_]
            suffixArray[index_ - 1] = suffixArray[index_] * element
        }
    }

    // Combine
    for (index, element) in prefixArray.enumerated() {
        output[index] = element * suffixArray[index]
    }

    return output
}