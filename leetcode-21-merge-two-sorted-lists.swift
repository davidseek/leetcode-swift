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
	
    /**
    If we have no list 1, we can just
    return our list 2, if that is nil 
    as well, then the total return will be nil
    */
    guard let list1 = l1 else {
        return l2
    }

    // Same for list 2
    guard let list2 = l2 else {
        return l1
    }

    // Our new head node
    var resultList: ListNode? = nil

    // Check if the node of 1 or 2 is smalled
    if list1.val <= list2.val {

        // And add the smaller one to the head
        resultList = list1 
        // And continue the recursion with the next node
        resultList!.next = mergeTwoLists(list1.next, list2)

    } else {

        // Same as above
        resultList = list2
        resultList!.next = mergeTwoLists(list1, list2.next)
    }

    // Return the new head
    return resultList 
}