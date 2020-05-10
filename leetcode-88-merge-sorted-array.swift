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





https://leetcode.com/problems/merge-sorted-array/


Given two sorted integer arrays nums1 and nums2, merge nums2 into nums1 as one sorted array.

Note:

The number of elements initialized in nums1 and nums2 are m and n respectively.
You may assume that nums1 has enough space (size that is greater or equal to m + n) to hold additional elements from nums2.
Example:

Input:
nums1 = [1,2,3,0,0,0], m = 3
nums2 = [2,5,6],       n = 3

Output: [1,2,2,3,5,6]

*/

/**
Big O Annotation
Time complexity O(n) where n is the amount of elements in nums.
Space complexity O(n) where n is the amount of elements in nums.
*/
func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
	
    /**
    Create each a pointer per array
    and keep track of the insertions.
    */
    var pointer2: Int = 0 
    var pointer1: Int = 0 
    var insertions: Int = 0 

    while pointer2 < n {

        /**
        Get element of the 2nd array 
        for the current pointer
        */
        let element2 = nums2[pointer2]

        while true {

            // And the element of the 1st array
            let element1 = nums1[pointer1]

            /**
            Compare both elements
            */
            if element2 <= element1 {
            
                /**
                We need to:
                
                - insert at pointer of array 1
                - we need to pop one of the zeros
                - we need to update the insertions counter
                - and move to the next index of the array 1
                - and break the loop to move forward in array 2
                */
                nums1.insert(element2, at: pointer1)
                nums1.popLast()
                insertions += 1
                pointer1 += 1
                break

            /**
            If the pointer is larger than elements 
            available in the first array PLUS the insertions,
            we need to replace one of the remaining zeros 
            with the new element from array 2.
            */
            } else if pointer1 >= (m + insertions)  {

                nums1[pointer1] = element2
                pointer1 += 1
                break

            /**
            Else we just want to move the 
            pointer of array 1 along
            */
            } else {

                pointer1 += 1
            }
        }

        // And lastly move the pointer of array 2 forward
        pointer2 += 1
    }
}