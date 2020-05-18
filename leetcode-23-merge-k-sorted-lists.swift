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





https://leetcode.com/problems/merge-k-sorted-lists/


Merge k sorted linked lists and return it as one sorted list. Analyze and describe its complexity.

Example:

Input:
[
  1->4->5,
  1->3->4,
  2->6
]
Output: 1->1->2->3->4->4->5->6

*/

/**
Big O Annotation
Time complexity O(n log n) where n is the total amount of nodes in all lists.
The complexity is "n log n" because of the sort of the final array.
Space complexity O(n) where n is the total amount of nodes in all lists.

We're dropping the none dominant Swift sort term O(log n)
*/
func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        
    // Temporary array to store the given values
    var values: [Int] = []
    
    // Iterate through the lists
    for list in lists {
        
        /**
        Traverse each list and 
        add value to our array
        */
        list?.traverse { values.append($0) }
    }
    
    /**
    Create a new root node with value -1.
    We will drop this node later.
    */
    var root: ListNode? = ListNode(-1)

    // Store a reference to the new root
    var head: ListNode? = root 
    
    // Sort the values array
    values.sort()
    
    // Iterate through the values
    for value in values {

        /**
        Create a new node for every value
        and set it as the existing node's next.
        */
        root?.next = ListNode(value)

        /**
        Set this new node as the new current node
        for the next iteration
        */
        root = root?.next
    }
    
    /**
    Return the head's next to 
    drop the -1 temporary node
    */
    return head?.next
}

extension ListNode {

    // Simple function to traverse the list
    func traverse(_ value: (Int) -> Void) {
        value(val)
        next?.traverse(value)
    }
}