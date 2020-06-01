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





https://leetcode.com/problems/invert-binary-tree/


Invert a binary tree.

Example:

Input:

     4
   /   \
  2     7
 / \   / \
1   3 6   9
Output:

     4
   /   \
  7     2
 / \   / \
9   6 3   1
Trivia:
This problem was inspired by this original tweet by Max Howell:

Google: 90% of our engineers use the software you wrote (Homebrew), but you can’t invert a binary tree on a whiteboard so f*** off.

*/

/**
Big O Annotation
Time complexity O(n) where n is the amount of nodes in root.
Space complexity O(n) where n is the amount of nodes in root.
*/
func invertTree(_ root: TreeNode?) -> TreeNode? {
        
    // Without a root, no tree, return nil
    guard let root = root else {
        return nil
    }

    // First we need to traverse the tree in order
    let levelOrder = traverseInLevelOrder(root)
    
    /**
    0: [4]
    1: [2, 7]
    2: [1, 3, 6, 9]
    3: []
    */
    
    var index: Int = 1

    // The root is for sure the same as the given root
    var head: TreeNode = TreeNode(root.val)

    // Push the root into the nodes we need to process
    var nodes: [TreeNode] = [head]
    
    // While we still have work to do..
    while true {
        
        /**
        Get the current nodes.
        If there are none, then we're done.
        */
        guard let mapped = levelOrder[index] else {
            break 
        }
        
        // We now need to reverse the level order
        let reversed: [Int] = mapped.reversed()
        
        // We need a second index counter
        var index_: Int = 0

        // And a reference to the newly processed nodes
        var newNodes: [TreeNode] = []
        
        // For node in the last nodes we have processed...
        for node in nodes {
            
            // Check if the counter is a valid index
            if index_ < reversed.count {
                
                let value = reversed[index_]

                // Int.min equals a nil node
                if value > Int.min {

                    // Create a new node from the valid value
                    let newNode = TreeNode(value)

                    // First we add a left node
                    node.left = newNode

                    // Then we push the node to the newly processed nodes
                    newNodes.append(newNode)
                }
            }

            // index + 1 equals the right node of the current
            if index_ + 1 < reversed.count {
                
                let value = reversed[index_ + 1]

                if value > Int.min {

                    let newNode = TreeNode(value)
                    node.right = newNode
                    newNodes.append(newNode)
                }
            }
            
            // Move the counter along
            index_ += 2
        }
        
        // Update the references to our nodes
        nodes = newNodes
        index += 1
    }
    
    return head
}

/**
Time O(n) n = nodes in tree
Space O(n) n = nodes in tree
*/
private func traverseInLevelOrder(_ root: TreeNode) -> [Int: [Int]] {
    
    // Final output dictionary
    var levelOrder: [Int: [Int]] = [:]

    // Init a queue
    var queue = QueueStack()

    // ... and enqueue root at level 0
    queue.enqueue(root, at: 0)
    
    // While the queue is not empty...
    while !queue.isEmpty {
        
        // Dequeue the next element
        let (node, level) = queue.dequeue()!
        
        // If we already have values for this level
        if let mapped = levelOrder[level] {

            // Combine them
            levelOrder[level] = mapped + [node.val]

        } else {

            // If not, set them
            levelOrder[level] = [node.val]
        }
        
        /**
        This step is crazy important:
        As we need to make sure to gather 
        placeholders for incomplete sub trees,
        we need to init "dead" nodes with Int.min as value.
        
        But we don't want to add dead nodes to dead nodes to dead nodes...
        Therefore we need to check if the value is Int.min and skip if so.

        This has to be discussed with an interviewer potentially,
        as the range could reach down to Int.min
        */
        if node.val != Int.min {
            
            // Add left node to level + 1
            if let left = node.left {
                queue.enqueue(left, at: level + 1)
            } else {
                // Otherwise add a dummy node
                queue.enqueue(TreeNode(Int.min), at: level + 1)
            }

            // Same for the right
            if let right = node.right {
                queue.enqueue(right, at: level + 1)
            } else {
                queue.enqueue(TreeNode(Int.min), at: level + 1)
            }
        } 
    }
    
    return levelOrder
}

/**
All operations of this Queue implementation
have a time complexity of O(1)
*/
struct QueueStack {
    
    private var enqueueStack: [(node: TreeNode, level: Int)] = []
    private var dequeueStack: [(node: TreeNode, level: Int)] = []
    
    init() {}
    
    public var isEmpty: Bool {
        return enqueueStack.isEmpty && dequeueStack.isEmpty
    }
    
    public mutating func enqueue(_ element: TreeNode, at level: Int) {
        enqueueStack.append((node: element, level: level))
    }
    
    public mutating func dequeue() -> (node: TreeNode, level: Int)? {
        if dequeueStack.isEmpty {
            dequeueStack = enqueueStack.reversed()
            enqueueStack.removeAll()
        }
        
        return dequeueStack.popLast()
    }
}