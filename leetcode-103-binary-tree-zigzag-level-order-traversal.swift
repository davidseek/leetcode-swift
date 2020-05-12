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





https://leetcode.com/problems/binary-tree-zigzag-level-order-traversal/


Given a binary tree, return the zigzag level order traversal of its nodes' values. (ie, from left to right, then right to left for the next level and alternate between).

For example:
Given binary tree [3,9,20,null,null,15,7],
    3
   / \
  9  20
    /  \
   15   7
return its zigzag level order traversal as:
[
  [3],
  [20,9],
  [15,7]
]

*/

/**
Big O Annotation
Time complexity O(n) where n is the amount of nodes in the BST.
Space complexity O(n) where n is the amount of nodes in the BST.
*/
func zigzagLevelOrder(_ root: TreeNode?) -> [[Int]] {
        
    // If we have no root, return an empty array
    guard let root = root else {
        return []
    }
    
    // Init a queue...
    var queue = Queue()

    /**
    ... and append the root node and the level 0
    Level 0 because it's a 0 based index top down.
    */
    queue.enqueue(root, atLevel: 0)
    
    /**
    Init a temporary dictionary 
    of level and node values
    */
    var levels: [Int: [Int]] = [:]
    
    // While we still have nodes in the queue...
    while !queue.isEmpty {
        
        // Get the top most node/level tuple
        let (node, level) = queue.dequeue()!
        
        // Check if the level already exists in the tree
        if let mapped = levels[level] {

            // If so, add the value to the array (by combining)
            levels[level] = mapped + [node.val]
        } else {

            // Otherwise add the value as array
            levels[level] = [node.val]
        }
        
        /**
        Add the left node to the queue 
        and increment the level
        */
        if let left = node.left {
            queue.enqueue(left, atLevel: level + 1)
        }
        
        // Same for the right node
        if let right = node.right {
            queue.enqueue(right, atLevel: level + 1)
        }
    }
    
    // Init the output array
    var resultArray: [[Int]] = Array(repeating: [], count: levels.count)
    
    // Iterate through the level dictionary
    for (key, value) in levels {
        
        /**
        Check if the current level is odd
        to get the zig zack effect by reversing the values
        */
        let isOdd = (key % 2) != 0
        resultArray[key] = isOdd ? value.reversed() : value
    }
    
    // And done 🙂
    return resultArray
}

/**
QueueStack implementation with 2 private stacks.
One for enqueueing and the other for dequeueing.

Time complexity O(1)
This API gives us contant time for enqueue and dequeue.
*/
struct Queue {
    private var enqueueStack: [(node: TreeNode, level: Int)] = []
    private var dequeueStack: [(node: TreeNode, level: Int)] = [] 
    
    init() {}
    
    public var isEmpty: Bool {
        return enqueueStack.isEmpty && dequeueStack.isEmpty
    }
    
    public mutating func enqueue(_ node: TreeNode, atLevel level: Int) {
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