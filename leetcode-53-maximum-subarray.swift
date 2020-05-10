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





https://leetcode.com/problems/maximum-subarray/


Given an integer array nums, find the contiguous subarray (containing at least one number) which has the largest sum and return its sum.

Example:

Input: [-2,1,-3,4,-1,2,1,-5,4],
Output: 6
Explanation: [4,-1,2,1] has the largest sum = 6.
Follow up:

If you have figured out the O(n) solution, try coding another solution using the divide and conquer approach, which is more subtle.

*/

/**
Big O Annotation
Time complexity O(n) where n is the amount of elements in nums.
Space complexity O(1) as we're at most storing 2 variables at the same time.
*/
func maxSubArray(_ nums: [Int]) -> Int {
	
    /**
    If we have nothing in the array, 
    there's nothing to return.
    */
    guard nums.count > 0 else {
        return 0
    }

    /**
    We need a reference to the current
    maximum number and the largest maximum 
    number generally, as we're looking for 
    "contiguous subarray"

    Intialized with nums first element.
    */ 
    var maximumLocal: Int = nums[0] 
    var maximumGlobal: Int = nums[0] 

    // Iterate through the array from 1
    for index in 1..<nums.count {
        
        /**
        First we want to check if current maximum
        is larger than the one before.

        In the first iteration that of an example array of:
        [-2,1,-3,4,-1,2,1,-5,4], we'd be checking max(1, -2 + 1).

        In this example 1 or just nums[index] is the larger subarray
        as [-2, 1] is combined -1.
        */
        maximumLocal = max(nums[index], maximumLocal + nums[index])
    
        /**
        Then we need to check, if our new maximumLocal
        is larger than our formerly stored maximumGlobal.

        In above's example of [1], we've had [-2] as our
        maximumGlobal so now we need to update maximumGlobal to 1.
        */
        if maximumLocal > maximumGlobal {
            maximumGlobal = maximumLocal
        }
    }

    return maximumGlobal
}