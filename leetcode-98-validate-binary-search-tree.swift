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





https://leetcode.com/problems/validate-binary-search-tree/


Given a binary tree, determine if it is a valid binary search tree (BST).

Assume a BST is defined as follows:

The left subtree of a node contains only nodes with keys less than the node's key.
The right subtree of a node contains only nodes with keys greater than the node's key.
Both the left and right subtrees must also be binary search trees.
 

Example 1:

    2
   / \
  1   3

Input: [2,1,3]
Output: true
Example 2:

    5
   / \
  1   4
     / \
    3   6

Input: [5,1,4,null,null,3,6]
Output: false
Explanation: The root node's value is 5 but its right child's value is 4.
*/

/**
Big O Annotation
Time complexity O(n) where n is the amount of nodes in the tree.
Space complexity O(1) where not using any extra space.
*/
func isValidBST(_ root: TreeNode?) -> Bool {
	return root?.isValidBST() ?? true
}

extension TreeNode {

    public func isValidBST(max: Int? = nil, min: Int? = nil) -> Bool {
        
        /**
        If self is we reached a leaf
        and the tree is a valid BST
        */ 
        if self == nil {
            
            return true
            
        /**
        If the max is greater than val 
        or the min smaller than val
        we have determined that our BST is invalid
        */
        } else if (max != nil && val >= max!) || (min != nil && val <= min!) {
            
            return false
            
        /**
        Continue to recursively check the BST
        until we reach a leaf and exit on teh first clause
        */
        } else {
            
            let leftValid = left?.isValidBST(max: val, min: min) ?? true
            let rightValid = right?.isValidBST(max: max, min: val) ?? true
            return leftValid && rightValid
        }
    }
}