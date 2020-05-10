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





https://leetcode.com/problems/palindrome-linked-list/


Given a singly linked list, determine if it is a palindrome.

Example 1:

Input: 1->2
Output: false
Example 2:

Input: 1->2->2->1
Output: true
Follow up:
Could you do it in O(n) time and O(1) space?

*/

/**
Big O Annotation
Time complexity O(n) where n is the amount of nodes in head.
Space complexity O(n) where n is the amount of nodes in head.
*/
func isPalindrome(_ head: ListNode?) -> Bool {
        
    /**
    If we have no head node, 
    it's supposed to be a valid palindrome.

    Makes no sense to me, but it's not my challenge.
    */
    guard let head = head else {
        return true
    }
    
    /**
    If we ONLY have a head node, 
    it's a valid palindrome.
    */
    guard head.next != nil else {
        return true
    }
    
    // Temporary values
    var stack: [Int] = []
    
    // Traversing the list
    head.traverse { stack.append($0) }
    
    // Creating a left and a right pointer
    var left: Int = 0
    var right: Int = stack.count - 1
    
    // Loop as long as the pointers haven't crossed
    while left < right {

        // If left != right, we do not have a palindrome
        if stack[left] != stack[right] {
            return false
        } 
        
        // Move pointers along
        left += 1
        right -= 1
    }
    
    // If we made it till here we have a palindrome
    return true
}

extension ListNode {

    // Recursive function to traverse the list
    func traverse(_ visit: (Int) -> Void) {
        visit(val)
        next?.traverse(visit)
    }
}