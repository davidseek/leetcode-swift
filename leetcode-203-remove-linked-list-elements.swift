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





https://leetcode.com/problems/remove-linked-list-elements/


Remove all elements from a linked list of integers that have value val.

Example:

Input:  1->2->6->3->4->5->6, val = 6
Output: 1->2->3->4->5

*/

/**
In place approach.
Faster -> Gets us into the 100$ range.
And doesn't use any space.

Big O Annotation
Time complexity O(n) where n is the amount of nodes in head.
Space complexity O(1) where removing in place / not using extra space.
*/
func removeElements(_ head: ListNode?, _ val: Int) -> ListNode? {
        
    // Return nil if we don't have a head node
    guard let head = head else {
        return nil
    }

    // Get a reference to the head
    var current: ListNode? = head
    
    // Check that the head doesn't need to be removed
    while current != nil && current!.val == val {

        // If so, set the next node as new head
        current = current?.next
    }
    
    // Store a reference to the final head
    var root: ListNode? = current
    
    // While we still have nodes...
    while current != nil {
        
        // Check, that the next one exists and is not .val == val
        while current!.next != nil && current!.next!.val == val {

            /**
            If so, cut the node out and set to next.next
            Will be repeated until we don't have .val == val
            */
            current!.next = current!.next!.next
        }
        
        /**
        We need to make sure, that the final .next.val
        is not .val for niche cases
        */
        if current!.next?.val == val {
            current!.next = nil
        }
        
        // Continue with the next .next
        current = current?.next
    }
    
    return root
}

/**
Stored values approach. 
Takes longer and is less space efficient.

Big O Annotation
Time complexity O(n) where n is the amount of nodes in head.
Space complexity O(n) where n is the amount of nodes in head.
*/
func removeElements(_ head: ListNode?, _ val: Int) -> ListNode? {
        
    // Get an array of values of the list
    var values: [Int] = []
    head?.traverse { values.append($0) }

    // Filter by the desired removal value
    values = values.filter { $0 != val }

    // Init a new list
    var newHead: ListNode? = ListNode(-1)

    // Store it's head
    var root: ListNode? = newHead
    
    // Iterate through values
    for value in values {

        // And init a new node for every value
        let node = ListNode(value)

        // Set it
        newHead?.next = node

        // And store it as next
        newHead = node
    }

    // Return .next to lose the -1 head
    return root?.next
}

/**
Simple function to traverse 
a list node by node    
*/
extension ListNode {
    func traverse(_ visit: (Int) -> Void) {
        visit(val)
        next?.traverse(visit)
    }
}