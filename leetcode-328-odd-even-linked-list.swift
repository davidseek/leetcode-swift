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





https://leetcode.com/problems/odd-even-linked-list/


Given a singly linked list, group all odd nodes together followed by the even nodes. Please note here we are talking about the node number and not the value in the nodes.

You should try to do it in place. The program should run in O(1) space complexity and O(nodes) time complexity.

Example 1:

Input: 1->2->3->4->5->NULL
Output: 1->3->5->2->4->NULL
Example 2:

Input: 2->1->3->5->6->4->7->NULL
Output: 2->3->6->7->1->5->4->NULL
Note:

The relative order inside both the even and odd groups should remain as it was in the input.
The first node is considered odd, the second node even and so on ...

*/

/**
Big O Annotation
Time complexity O(n) where n is the amount of nodes in head.
Space complexity O(1) we're using 3 variables of space.
*/
func oddEvenList(_ head: ListNode?) -> ListNode? {
        
    guard let head = head else {
        return nil
    }
    
    /**
            O  E  O  E  O
            1  2  3  4  5 
    Input:  1->2->3->4->5->NULL
    
            O  O  O  E  E
            1  3  4  2  4
    Output: 1->3->5->2->4->NULL
    
            O  E  O  E  O  E  O
            1  2  3  4  5  6  7
    Input:  2->1->3->5->6->4->7->NULL
    
            O  O  O  O  E  E  E
            1  3  5  7  2  4  6
    Output: 2->3->6->7->1->5->4->NULL
            
    */
    
    // Get a reference to the first odd node
    var odd: ListNode? = head

    // And a reference to the first even node
    var even: ListNode? = head.next

    // And a total reference of all even nodes
    var evenHead: ListNode? = even
    
    // While we still have even elements
    while even != nil && even!.next != nil {

        // Set even's next element as the next of the odd list
        odd?.next = even?.next

        // And move odd a long
        odd = odd?.next

        // Same for the even list
        even?.next = odd?.next
        even = even?.next
    }
    
    // Append the even list to the odd list
    odd?.next = evenHead

    // And return the mutated head
    return head
}