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





https://leetcode.com/problems/construct-binary-search-tree-from-preorder-traversal/


Return the root node of a binary search tree that matches the given preorder traversal.

(Recall that a binary search tree is a binary tree where for every node, any descendant of node.left has a value < node.val, and any descendant of node.right has a value > node.val.  Also recall that a preorder traversal displays the value of the node first, then traverses node.left, then traverses node.right.)

It's guaranteed that for the given test cases there is always possible to find a binary search tree with the given requirements.

Example 1:

Input: [8,5,1,7,10,12]
Output: [8,5,10,1,7,null,12]

 

Constraints:

1 <= preorder.length <= 100
1 <= preorder[i] <= 10^8
The values of preorder are distinct.

*/

/**
Big O Annotation
Time complexity O(n) where n is the amount of elements in preorder.
Space complexity O(1) we're not using any extra space.
*/
func bstFromPreorder(_ preorder: [Int]) -> TreeNode? {
        
    /**
    If there's nothing in the array, 
    there's not gonna be a BST
    */
    guard !preorder.isEmpty else {
        return nil
    }
    
    // Get the root node
    let root = TreeNode(preorder[0])
    
    // Fill it with the remaining values...
    for i in 1..<preorder.count {
        root.insert(preorder[i])
    }
    
    return root
}

extension TreeNode {

    // Simple insert function
    func insert(_ value: Int) {
        
        // If the value is smaller than root...
        if value < val {
            
            // Check if we already have a left node...
            if let left = left {

                // If so, start recursion
                left.insert(value)
            } else {
                
                // If not, make it the left node
                left = TreeNode(value)
            }
            
        } else {
            
            // Same on the right
            if let right = right {
                right.insert(value)
            } else {
                right = TreeNode(value)
            }
        }
    }
}