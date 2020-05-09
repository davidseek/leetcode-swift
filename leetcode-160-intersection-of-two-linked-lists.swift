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





https://leetcode.com/problems/intersection-of-two-linked-lists/


Write a program to find the node at which the intersection of two singly linked lists begins.

For example, the following two linked lists:


begin to intersect at node c1.

 

Example 1:


Input: intersectVal = 8, listA = [4,1,8,4,5], listB = [5,0,1,8,4,5], skipA = 2, skipB = 3
Output: Reference of the node with value = 8
Input Explanation: The intersected node's value is 8 (note that this must not be 0 if the two lists intersect). From the head of A, it reads as [4,1,8,4,5]. From the head of B, it reads as [5,0,1,8,4,5]. There are 2 nodes before the intersected node in A; There are 3 nodes before the intersected node in B.

*/

/**
Big O Annotation
Time complexity O(n) where n is the combined number of elements in headA and headB.
Space complexity O(n) where n is the combined number of elements in headA and headB.
*/
func getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
        
    var valueListA: Set<ListNode> = []
    var inserSection: ListNode?
    
    // Traverse A into the Set
    headA?.traverse { valueListA.insert($0) }
    
    // Traverse B and get the intersection
    headB?.traverse { node in 

        /**
        Make sure to not overwrite with later nodes
        as that would not be the intersection but
        common nodes.

        We could optimize this by interrupting the close calls
        and directly returning.
        */
        if valueListA.contains(node) && inserSection == nil {
            inserSection = node
        }
    }
    
    return inserSection
}

extension ListNode {

    // Function to traverse the list
    func traverse(visit: (ListNode) -> Void) {
        visit(self)
        next?.traverse(visit: visit)
    }
}

/**
Conform ListNode to Hashable to use in a Set
and to take advantage of constant contains operation.

Using ObjectIdentifier to use the memory reference for equality.
*/
extension ListNode: Hashable {

    public static func == (lhs: ListNode, rhs: ListNode) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(val)
    }
}