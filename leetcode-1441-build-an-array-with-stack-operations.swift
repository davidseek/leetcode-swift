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





https://leetcode.com/contest/weekly-contest-188/problems/build-an-array-with-stack-operations/


Given an array target and an integer n. In each iteration, you will read a number from  list = {1,2,3..., n}.

Build the target array using the following operations:

Push: Read a new element from the beginning list, and push it in the array.
Pop: delete the last element of the array.
If the target array is already built, stop reading more elements.
You are guaranteed that the target array is strictly increasing, only containing numbers between 1 to n inclusive.

Return the operations to build the target array.

You are guaranteed that the answer is unique.

 

Example 1:

Input: target = [1,3], n = 3
Output: ["Push","Push","Pop","Push"]
Explanation: 
Read number 1 and automatically push in the array -> [1]
Read number 2 and automatically push in the array then Pop it -> [1]
Read number 3 and automatically push in the array -> [1,3]
Example 2:

Input: target = [1,2,3], n = 3
Output: ["Push","Push","Push"]
Example 3:

Input: target = [1,2], n = 4
Output: ["Push","Push"]
Explanation: You only need to read the first 2 numbers and stop.
Example 4:

Input: target = [2,3,4], n = 4
Output: ["Push","Pop","Push","Push","Push"]
 

Constraints:

1 <= target.length <= 100
1 <= target[i] <= 100
1 <= n <= 100
target is strictly increasing.

*/

/**
Big O Annotation
Time complexity O(n) where n is the amount of elements between 1 and n.
Space complexity O(n) where n is the amount of elements in target.
*/
func buildArray(_ target: [Int], _ n: Int) -> [String] {
        
    /**
    Init a Set from the target array
    for O(1) constant .contains operation
    */
    let asSet: Set<Int> = Set(target)

    // All performed operations
    var operations: [String] = []

    // Reference to the currently created array
    var currentTarget: [Int] = [] 
    
    // Iterate from 1 up to including n
    for element in 1...n {
        
        // Add a "Push" operation...
        operations.append("Push")

        // ... and add the element to the target reference
        currentTarget.append(element)
        
        // Check if the set contains the current element...
        if !asSet.contains(element) {

            // ... and if not, add a "Pop" operation
            operations.append("Pop")

            // and actually pop from the reference array
            currentTarget.popLast()
        }
        
        /**
        Check if our reference and the target 
        match to be able to return early
        */
        if currentTarget == target {
            return operations
        }
    }

    return operations
}