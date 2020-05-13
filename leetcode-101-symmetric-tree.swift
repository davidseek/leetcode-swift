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





https://leetcode.com/problems/symmetric-tree/


Given a binary tree, check whether it is a mirror of itself (ie, symmetric around its center).

For example, this binary tree [1,2,2,3,4,4,3] is symmetric:

    1
   / \
  2   2
 / \ / \
3  4 4  3
 

But the following [1,2,2,null,3,null,3] is not:

    1
   / \
  2   2
   \   \
   3    3
 

Follow up: Solve it both recursively and iteratively.

*/

/**
Big O Annotation
Time complexity O(n) where n is the amount of nodes in root.
Space complexity O(n) where n is the amount of nodes in root.
*/
func isSymmetric(_ root: TreeNode?) -> Bool {
    
    /**
    This case does not make much sense to me.
    If there is no root, how can it be symmetric.
    But it's what we need to do to satisfy the test.
    */
    guard let root = root else {
        return true
    }
    
    // First we need to traverse the tree in order
    let levelOrder = traverseInLevelOrder(root)
    
    // Then check if it's a palindrome
    for (level, values) in levelOrder {
        
        // If any of the levels is not, then return false
        if isPalindrome(values) == false {
            return false
        }
    }
    
    // If we fallback till here, it's a palindrome
    return true
}
    
/**
This functions checks an array of Integers
and returns true if it's a palindrome.

Example: 
[0,1,2,1,0] - true
[0,1,1,2,0] - false

Time O(n) n = values in array
Space O(1)
*/
public func isPalindrome(_ values: [Int]) -> Bool {
    
    // One pointer on the left and one on the right
    var leftPointer: Int = 0 
    var rightPointer: Int = values.count - 1
    
    // Loop until they meet
    while leftPointer < rightPointer {
        
        // Compare the left to the right element
        let left: Int = values[leftPointer]
        let right: Int = values[rightPointer]
        
        // Return false if they dont equal
        if left != right {
            return false
        }
        
        // Move along
        leftPointer += 1
        rightPointer -= 1
    }
    
    return true
}

/**
Returns a level traversed dictionary represenation of a tree
Example input: 

    1
   / \
  2   2
 / \ / \
3  4 4  3

Returns: 

[
    0: [1],
    1: [2,2],
    3: [3,4,4,3]
]

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