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





https://leetcode.com/problems/average-of-levels-in-binary-tree/

Given a non-empty binary tree, return the average value of the nodes on each level in the form of an array.
Example 1:
Input:
    3
   / \
  9  20
    /  \
   15   7
Output: [3, 14.5, 11]
Explanation:
The average value of nodes on level 0 is 3,  on level 1 is 14.5, and on level 2 is 11. Hence return [3, 14.5, 11].
Note:
The range of node's value is in the range of 32-bit signed integer.

*/

/**
Big O Annotation
Time complexity O(n) where n is the amount of nodes in root.
Space complexity O(n) where n is the amount of nodes in root.
*/
func averageOfLevels(_ root: TreeNode?) -> [Double] {
        
    // Check if there is a root node
    guard let root = root else {
        return []
    }
    
    // Get level order traversal
    let levelOrder = getLevelTraversal(ofTreeAt: root)
    
    // Init a result array of count levelOrder keys
    var result: [Double] = Array(repeating: 0.0, count: levelOrder.count)
    
    // Iterate through all levels
    for (level, values) in levelOrder {

        /**
        And set their index on level and calculate the value
        based on summed up level node.value 
        count divided by amount of nodes
        */
        result[level] = values.sum / values.count
    }
    
    return result
}

// Level order traversal function O(n) time and space
private func getLevelTraversal(ofTreeAt root: TreeNode) -> [Int: (sum: Double, count: Double)] {
    
    /**
    Dictionary of levels and
    sum of nodes.values of the level 
    and count as number of nodes total in this level
    */
    var levelOrder: [Int: (sum: Double, count: Double)] = [:]
    
    // Init a queue
    var queue = Queue()

    // Add root at level 0
    queue.enqueue(root, at: 0)
    
    // While we still have work to do
    while !queue.isEmpty {
        
        // Enqueue node at level
        let (node, level) = queue.dequeue()!
        
        // Check if we already have values at that level
        if let (sum, count) = levelOrder[level] {       

            // If so, add count and add sum         
            levelOrder[level] = (sum + Double(node.val), count + 1)

        } else {

            // If not init at that level
            levelOrder[level] = (Double(node.val), 1)
        }
        
        // Add left node if exists to the queue
        if let left = node.left {

            // Incrementing the level
            queue.enqueue(left, at: level + 1)
        }
        
        // Same for the right side
        if let right = node.right {
            queue.enqueue(right, at: level + 1)
        }
    } 
    
    return levelOrder
}

/**
Basic Queue implementation.
All operations are O(1) time
*/
fileprivate struct Queue {
    private var enqueueStack: [(node: TreeNode, level: Int)] = []
    private var dequeueStack: [(node: TreeNode, level: Int)] = []
    
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