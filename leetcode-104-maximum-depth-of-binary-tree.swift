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





https://leetcode.com/problems/maximum-depth-of-binary-tree/


Given a binary tree, find its maximum depth.

The maximum depth is the number of nodes along the longest path from the root node down to the farthest leaf node.

Note: A leaf is a node with no children.

Example:

Given binary tree [3,9,20,null,null,15,7],

    3
   / \
  9  20
    /  \
   15   7
return its depth = 3.

*/

/**
Big O Annotation
Time complexity O(n) where n is the amount of nodes in root.
Space complexity O(1) we're not using any extra space.
*/
func maxDepth(_ root: TreeNode?) -> Int {
        
    // Init a 0 depth
    var depth: Int = 0 
    
    /**
    Traverse through the whole tree
    and get the depth of every node
    */
    traverse(root) { level in

        /**
        Compare to the current deepest depth 
        and only keep the depeest one we have seen
        */
        depth = max(depth, level)
    }
    
    return depth
}

/**
Take in a node and a current depth level
and in the close returns the depth level of every node.

Will traverse the whole tree and be called recursively
until there is no more node left.
*/
func traverse(_ node: TreeNode?, at level: Int = 1, visited: (Int) -> Void) {
    
    guard let node = node else  {return }
    visited(level)
    traverse(node.left, at: level + 1, visited: visited)
    traverse(node.right, at: level + 1, visited: visited)
}