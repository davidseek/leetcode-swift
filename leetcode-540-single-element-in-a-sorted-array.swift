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





https://leetcode.com/problems/single-element-in-a-sorted-array/


You are given a sorted array consisting of only integers where every element appears exactly twice, except for one element which appears exactly once. Find this single element that appears only once.

 

Example 1:

Input: [1,1,2,3,3,4,4,8,8]
Output: 2
Example 2:

Input: [3,3,7,7,10,11,11]
Output: 10
 

Note: Your solution should run in O(log n) time and O(1) space.

*/

/**
Big O Annotation
Time complexity O(log n) where n is the number of elements in nums.
Space complexity O(1) we're not using any extra space
*/
func singleNonDuplicate(_ nums: [Int]) -> Int {
            
    /**
    The idea is to have a binary search approach.

             0 1 2 3 4  5  6 
            [3,3,7,7,10,11,11]
    Round 1  l     m        r
    Round 2        l  m     r

    Every round we're cutting the amount
    of elements we need to check in half.

    First we'll get a left, a right and a mid pointer.
    */
    var leftPointer: Int = 0
    var rightPointer: Int = nums.count - 1
    var midPointer: Int = rightPointer / 2
    
    // While the pointers havent crossed
    while leftPointer < rightPointer {
        
        /**
        Check if the current index is even.
        If the index is even, then we know, 
        that we need a counter part of the element 
        at the index at the right.

        Example above: 
        Index 0, Element 3, Index 1, Element 3
        Index 2, Element 7, Index 3, Element 7
        */
        let evenIndex: Bool = midPointer % 2 == 0
        
        /**
        We're going to initiate the nextMatch and lastMatch
        variables as true booleans as we consider it
        true if there is no next or last neightbor.

        Those cases are true when we're running out of array bounds.
        For example index 0 hast no neighbor on the left. 
        -1 is out of bounds.
        */
        var nextMatch: Bool = true
        var lastMatch: Bool = true
        
        // Check if we're in bounds
        if midPointer < nums.count - 1 {

            /**
            And then check if the neighbor 
            equals the current expected mid point.
            */
            nextMatch = nums[midPointer] == nums[midPointer + 1]
        }
        
        // Same as with the nextMatch above
        if midPointer > 0 {
            lastMatch = nums[midPointer] == nums[midPointer - 1]
        }

        /**
        If we have no match partner to the left
        or to the right, then we know for sure,
        that the current mid element IS the 
        value we where looking for.
        */
        if !nextMatch && !lastMatch {
            return nums[midPointer]
        }
        
        /**
        Othwise we check if for an even index
        we have a match to thre right,
        or for an odd index a match to the left.
        */
        if evenIndex && nextMatch || !evenIndex && lastMatch {
            
            /**
            If so, then set the mid as the next left pointer 
            as we know, that everything on the mid 
            is perfect.
            */
            leftPointer = midPointer + 1
            
        } else {
            
            // Otherwise move the right pointer to the middle
            rightPointer = midPointer - 1
        }
        
        // Calculate the new mid point based on the new boundaries.
        midPointer = leftPointer + ((rightPointer - leftPointer) / 2)
        
    }

    /**
    Once we've arrived here, the element
    pointed at by the midPointer
    must be the candidate.
    */ 
    return nums[midPointer]
}