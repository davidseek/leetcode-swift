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





https://leetcode.com/problems/maximum-sum-circular-subarray/


Given a circular array C of integers represented by A, find the maximum possible sum of a non-empty subarray of C.

Here, a circular array means the end of the array connects to the beginning of the array.  (Formally, C[i] = A[i] when 0 <= i < A.length, and C[i+A.length] = C[i] when i >= 0.)

Also, a subarray may only include each element of the fixed buffer A at most once.  (Formally, for a subarray C[i], C[i+1], ..., C[j], there does not exist i <= k1, k2 <= j with k1 % A.length = k2 % A.length.)

 

Example 1:

Input: [1,-2,3,-2]
Output: 3
Explanation: Subarray [3] has maximum sum 3
Example 2:

Input: [5,-3,5]
Output: 10
Explanation: Subarray [5,5] has maximum sum 5 + 5 = 10
Example 3:

Input: [3,-1,2,-1]
Output: 4
Explanation: Subarray [2,-1,3] has maximum sum 2 + (-1) + 3 = 4
Example 4:

Input: [3,-2,2,-3]
Output: 3
Explanation: Subarray [3] and [3,-2,2] both have maximum sum 3
Example 5:

Input: [-2,-3,-1]
Output: -1
Explanation: Subarray [-1] has maximum sum -1
 

Note:

-30000 <= A[i] <= 30000
1 <= A.length <= 30000

*/

/**
Big O Annotation
Time complexity O(n) where n is the amount of elements in A.
Space complexity O(1) we're not using any extra space.
*/
func maxSubarraySumCircular(_ A: [Int]) -> Int {
        
    guard !A.isEmpty else {
        return 0
    }
    
    /**
    Initialize all min and max values 
    with A's first element
    */
    var currentMax: Int = A[0]
    var totalMax: Int = A[0]
    var currentMin: Int = A[0]
    var totalMin: Int = A[0]
    
    // Including the sum
    var sum: Int = A[0]
    
    // Iterate starting form the 2nd element
    for index in 1..<A.count {
        
        let element = A[index]
        
        // Get the total current max
        currentMax = max(currentMax + element, element)
        // And the total total max
        totalMax = max(currentMax, totalMax)
        
        // Same for the min
        currentMin = min(currentMin + element, element)
        totalMin = min(currentMin, totalMin)
        
        // Add all elements to a sum
        sum += element
    }
    
    /**
    This case holds true when there are 
    only negative numbers in the array
    */
    if sum == totalMin {
        return totalMax
    }
    
    // Return the max of total max and sum - total min
    return max(totalMax, sum - totalMin)
}