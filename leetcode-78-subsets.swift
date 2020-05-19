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





https://leetcode.com/problems/subsets/


Given a set of distinct integers, nums, return all possible subsets (the power set).

Note: The solution set must not contain duplicate subsets.

Example:

Input: nums = [1,2,3]
Output:
[
  [3],
  [1],
  [2],
  [1,2,3],
  [1,3],
  [2,3],
  [1,2],
  []
]

*/

/**
Big O Annotation
Time complexity O(2^n) where n is the amount of elements in nums.
Space complexity O(n) where n is the amount of elements in nums.
*/
func subsets(_ nums: [Int]) -> [[Int]] {
        
    // Create the output array
    var subsets: [[Int]] = []

    // Add all subsets
    add(&subsets, for: nums)

    // And returns        
    return subsets
}

private func add(_ subsets: inout [[Int]], for numbers: [Int], startAt index: Int = 0, current: [Int] = []) {

    // Add the current value of current to the output
    subsets.append(current)

    // Get a mutable copy of current
    var current = current
    
    // Iterate through the remaining indices
    for i in index..<numbers.count {

        // Add the current number
        current.append(numbers[i])

        // Recursivly call again
        add(&subsets, for: numbers, startAt: i + 1, current: current)

        // And also remove the number
        current.remove(at: current.count - 1)
    }
}