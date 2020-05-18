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





https://leetcode.com/problems/copy-list-with-random-pointer/


A linked list is given such that each node contains an additional random pointer which could point to any node in the list or null.

Return a deep copy of the list.

The Linked List is represented in the input/output as a list of n nodes. Each node is represented as a pair of [val, random_index] where:

val: an integer representing Node.val
random_index: the index of the node (range from 0 to n-1) where random pointer points to, or null if it does not point to any node.
 

Example 1:


Input: head = [[7,null],[13,0],[11,4],[10,2],[1,0]]
Output: [[7,null],[13,0],[11,4],[10,2],[1,0]]
Example 2:


Input: head = [[1,1],[2,1]]
Output: [[1,1],[2,1]]
Example 3:



Input: head = [[3,null],[3,0],[3,null]]
Output: [[3,null],[3,0],[3,null]]
Example 4:

Input: head = []
Output: []
Explanation: Given linked list is empty (null pointer), so return null.

*/

/**
Big O Annotation
Time complexity O(n) where n is the amount of nodes in head.
Space complexity O(n) where n is the amount of nodes in head.
*/
func copyRandomList(_ head: Node?) -> Node? {
        
    /**
    Mutable reference of all the nodes 
    to keep track of the random pointers
    */
    var storage: [Node: Node] = [:]

    // Get a copy of the nodes themselves
    let copy = copyNode(head, storage: &storage)

    // And adjust the random pointers
    copyRandom(head, storage: &storage)

    return copy
}

func copyNode(_ node: Node?, storage: inout [Node: Node]) -> Node? {
    
    // Check if there is a node
    guard let node = node else { 
        return nil 
    }
    
    // If so, get a new one with same value
    let copy = Node(node.val)

    // Store the reference for that new node
    storage[node] = copy

    // And continue the recursion down the next elements
    copy.next = copyNode(node.next, storage: &storage)
    
    // Return the new node
    return copy
}

func copyRandom(_ node: Node?, storage: inout [Node: Node]) {

    // Make sure we have a node...    
    guard let node = node else { 
        return 
    }
    
    // Get the random pointer for the current node
    if let random = node.random {

        // And assign it the new one
        storage[node]?.random = storage[random]
    }
    
    // And continue down the recursion 
    copyRandom(node.next, storage: &storage)
}