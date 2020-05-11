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





https://leetcode.com/problems/swap-nodes-in-pairs/


Given a linked list, swap every two adjacent nodes and return its head.

You may not modify the values in the list's nodes, only nodes itself may be changed.

*/

/**
Big O Annotation
Time complexity O(n) where n is the amount of nodes in the list.
Space complexity O(1) we're not using any extra space.
*/
func swapPairs(_ head: ListNode?) -> ListNode? {
        
    // Return is there is no next node
    if head?.next == nil { 
        return head
    }
    
    /**
    Get a reference to the current next node
    In this example: [1,2,3,4],
    we have now [2,3,4]
    */
    let next = head?.next

    /**
    Now we're computing [1]'s next,
    with parameter next?.next what is right now [3,4]
    That will give us [1,3,4]
    and that iteration called again
    will give us [1,4,3]
    */
    head?.next = swapPairs(next?.next)

    // Set [2]'s next to [1,4,3]
    next?.next = head

    // And return
    return next
}