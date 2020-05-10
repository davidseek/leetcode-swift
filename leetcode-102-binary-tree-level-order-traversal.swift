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





https://leetcode.com/problems/binary-tree-level-order-traversal/


Given a binary tree, return the level order traversal of its nodes' values. (ie, from left to right, level by level).

For example:
Given binary tree [3,9,20,null,null,15,7],
    3
   / \
  9  20
    /  \
   15   7
return its level order traversal as:
[
  [3],
  [9,20],
  [15,7]
]

*/

/**
Big O Annotation
Time complexity O(n) where n is the amount of nodes in root.
Space complexity O(n) where n is the amount of nodes in root.
*/
 func levelOrder(_ root: TreeNode?) -> [[Int]] {        
    return traverseByLevel(root) ?? []
}

func traverseByLevel(_ root: TreeNode?) -> [[Int]] {
    
    // Without a root, no levels
    guard let root = root else {
        return []
    }
    
    // This will be our result array
    var values: [[Int]] = []
    
    /**
    We need a queue of nodes and our current level
    starting at root and 0.
    */
    var queue: [(TreeNode, Int)] = [(root, 0)]

    // The start and end point of our queue
    var start = queue.startIndex
    var end = queue.endIndex
    
    // While we have still work to do...
    while start < end {

        // Get the current node and level from the queue
        let (node, level) = queue[start]
        
        // If level is above the endIndex
        if level >= values.endIndex { 

            // Add a new empty result array to values
            values.append([]) 
        }
        
        // .. So we can access it and add the node's value
        values[level].append(node.val)
        
        // Then add the left node to the queue in the next level
        if let left = node.left { 
            queue.append((left, level + 1))
        }
        
        // Same for the right child node
        if let right = node.right { 
            queue.append((right, level + 1))
        }

        // Lastly set the end to our new end
        end = queue.endIndex

        // And move start forward
        start += 1
    }
    
    return values
}