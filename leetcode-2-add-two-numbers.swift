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





https://leetcode.com/problems/two-sum/


Given an array of integers, return indices of the two numbers such that they add up to a specific target.

You may assume that each input would have exactly one solution, and you may not use the same element twice.

Example:

Given nums = [2, 7, 11, 15], target = 9,

Because nums[0] + nums[1] = 2 + 7 = 9,
return [0, 1].

*/

/**
Big O Annotation
Time complexity O(n) where n is the combined amount of elements in l1 and l2.
Space complexity O(n) where n is the combined amount of elements in l1 and l2.
*/
func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        
    // Get a mutable reference to each head of l1 and l2
    var currentL1: ListNode? = l1
    var currentL2: ListNode? = l2

    // Create a reference to a node we're going to append on
    var sumList: ListNode? = ListNode(-1)

    // And a reference to its head
    var head: ListNode? = sumList

    // The carry for values > 9
    var carry: Int = 0
    
    // While we haven't fully iterated both lists yet...
    while currentL1 != nil || currentL2 != nil {
        
        /**
        Get a dummy value of 0 for each list
        in the niche case that either list
        is longer than the other.
        */
        var value1: Int = 0
        var value2: Int = 0
        
        // Replace with l1's value if it exists
        if let l1 = currentL1 {
            value1 = l1.val
        }
        
        // Same for l2
        if let l2 = currentL2 {
            value2 = l2.val
        }
        
        // Sum up both values and the last carry
        let sum: Int = value1 + value2 + carry 

        // Get the value < 10
        let value = sum % 10

        // Get the carry if above 10
        carry = sum / 10

        // Add a node with the new value
        sumList?.next = ListNode(value)

        // And move the head reference
        sumList = sumList?.next
        
        // Move l1 and l2 along as well
        currentL1 = currentL1?.next
        currentL2 = currentL2?.next
    }
    
    // If we still have carry left
    if carry > 0 {
        /**
        Add a node for the carry.
        This case could happen on 
        (9 -> 9) + (1) = (0 -> 0 -> 1)
        */
        sumList?.next = ListNode(carry)
    }
    
    // Return head.next to lose the -1 dummy head
    return head?.next
}