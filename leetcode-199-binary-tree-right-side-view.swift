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





https://leetcode.com/problems/binary-tree-right-side-view/


Given a binary tree, imagine yourself standing on the right side of it, return the values of the nodes you can see ordered from top to bottom.

Example:

Input: [1,2,3,null,5,null,4]
Output: [1, 3, 4]
Explanation:

   1            <---
 /   \
2     3         <---
 \     \
  5     4       <---

*/

/**
Big O Annotation
Time complexity O(n) where n is the amount of nodes in root.
Space complexity O(n) where n is the amount of nodes in nums.
*/
func rightSideView(_ root: TreeNode?) -> [Int] {

    // Without root nothing to see from the side
    guard let root = root else {
        return [] 
    }

    // Get the tree in level order traversal
    let levelTraversal = getLevelTraversal(of: root)

    // Get a result array of size levels
    var result: [Int] = Array(repeating: 0, count: levelTraversal.count)

    // Iterate through the traversal
    for (level, values) in levelTraversal {

        // And get the last element of each level
        result[level] = values.last ?? 0
    }

    return result
}

/**
Simple level order traversal:
Example: 

[
  0: [1]    
  1: [4,2]  
  2: [5,3]  
]
*/
func getLevelTraversal(of root: TreeNode) -> [Int: [Int]] {

    // The final output dictionary
    var levelTraversal: [Int: [Int]] = [:]

    // Init a queue
    var queue = Queue()

    // And enqueue the root at level 0
    queue.enqueue(root, at: 0)

    // While the queue is not empty
    while !queue.isEmpty {

        // Dequeue
        let (node, level) = queue.dequeue()!

        // Check if we already have a mapping for this level
        if let mapped = levelTraversal[level] {

            // If so, add nodes value
            levelTraversal[level] = mapped + [node.val]

        } else {

            // If not, set it
            levelTraversal[level] = [node.val]
        }

        // Enqueue the left child
        if let left = node.left {
            queue.enqueue(left, at: level + 1)
        }

        // And the right child
        if let right = node.right {
            queue.enqueue(right, at: level + 1)
        }
    }

    return levelTraversal
}

/**
Basic Queue Stack.
All operations are O(1) in time.
*/
struct Queue {

    private var enqueueStack: [(node: TreeNode, level: Int)] = []
    private var dequeueStack: [(node: TreeNode, level: Int)] = []

    init() {}

    public var isEmpty: Bool {
        return enqueueStack.isEmpty && dequeueStack.isEmpty
    }

    public mutating func enqueue(_ node: TreeNode, at level: Int) {
        enqueueStack.append((node: node, level: level))
    }

    public mutating func dequeue() -> (node: TreeNode, level: Int)? {

        if dequeueStack.isEmpty {

            dequeueStack = enqueueStack.reversed()
            enqueueStack.removeAll()
        }

        return dequeueStack.popLast()
    }
}