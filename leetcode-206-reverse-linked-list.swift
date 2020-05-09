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





https://leetcode.com/problems/reverse-linked-list/


Reverse a singly linked list.

Example:

Input: 1->2->3->4->5->NULL
Output: 5->4->3->2->1->NULL
Follow up:

A linked list can be reversed either iteratively or recursively. Could you implement both?

*/

/**
Big O Annotation
Time complexity O(n) where n is the amount of node in head.
Space complexity O(n) where n is the amount of node in head.
*/
func reverseList(_ head: ListNode?) -> ListNode? {
        
    // Withouta head nothing to reverse
    guard let originalHead = head else {
        return nil
    }
    
    var values: [Int] = []
    
    // Create a new dummy root
    var root: ListNode? = ListNode(-1)

    // And store the reference to the head
    var head: ListNode? = root
    
    // Traverse the original list
    originalHead.traverse { values.append($0) }
    
    // And while the list of values is not empty...
    while !values.isEmpty {
        
        // ... get the last element of the array
        guard let value = values.popLast() else {
            break
        }
        
        // Add it as the next element of the current node
        root?.next = ListNode(value)

        // And set the current node as the next "current"
        root = root?.next
    }
    
    /**
    Return the next of head to 
    lose the -1 temp node
    */
    return head?.next
}

extension ListNode {

    // Function to traverse the list
    func traverse(visit: (Int) -> Void) {
        visit(val)
        next?.traverse(visit: visit)
    }
}