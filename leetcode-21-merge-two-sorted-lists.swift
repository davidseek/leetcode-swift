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





https://leetcode.com/problemset/all/


Merge two sorted linked lists and return it as a new list. The new list should be made by splicing together the nodes of the first two lists.

Example:

Input: 1->2->4, 1->3->4
Output: 1->1->2->3->4->4

*/

/**
Big O Annotation
Time complexity O(n) where n is the combined amount of nodes in l1 + l2.
Space complexity O(n) where n is the combined amount of nodes in l1 + l2.
*/
func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
	
    // Check if l1 exists
    guard let l1 = l1 else {
        return l2
    }
    
    // Check if l2 exists
    guard let l2 = l2 else {
        return l1
    }
    
    // Get a current node reference and a head to lose
    var current: ListNode? = ListNode(-1)

    // Keep a reference of the head
    var head: ListNode = current!
    
    // Get the current list references
    var currentL1: ListNode? = l1
    var currentL2: ListNode? = l2
    
    // While both lists still have work to do
    while currentL1 != nil && currentL2 != nil {
        
        // Check if l1 is smaller or l2
        if currentL1!.val <= currentL2!.val {

            // Append the smaller element
            current!.next = currentL1

            // And update the reference
            currentL1 = currentL1!.next
        } else {

            // Same as above
            current!.next = currentL2
            currentL2 = currentL2!.next
        }
        
        // Move current along
        current = current?.next
    }
    
    // And append missing elements
    if let list = currentL1 {
        current?.next = list
    }
    
    // Sane as above
    if let list = currentL2 {
        current?.next = list
    }
    
    // Return head.next to lose the -1 node
    return head.next
}