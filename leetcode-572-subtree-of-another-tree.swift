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





https://leetcode.com/problems/subtree-of-another-tree/


Given two non-empty binary trees s and t, check whether tree t has exactly the same structure and node values with a subtree of s. A subtree of s is a tree consists of a node in s and all of this node's descendants. The tree s could also be considered as a subtree of itself.

Example 1:
Given tree s:

     3
    / \
   4   5
  / \
 1   2
Given tree t:
   4 
  / \
 1   2
Return true, because t has the same structure and node values with a subtree of s.
 

Example 2:
Given tree s:

     3
    / \
   4   5
  / \
 1   2
    /
   0
Given tree t:
   4
  / \
 1   2
Return false.

*/

/**
Big O Annotation
Time complexity O(n) where n is the amount of nodes in s.
Space complexity O(1) we're not using any extra space.
*/
func isSubtree(_ s: TreeNode?, _ t: TreeNode?) -> Bool {

    // Without no s tree, nothing to check
    guard let s = s else {
        return false
    }
    
    // Check if t is a subtree of s
    guard getEquality(of: s, and: t) else {

        // If not, continue on the left and on the right
        return isSubtree(s.left, t) || isSubtree(s.right, t)
    }
    
    return true
}

private func getEquality(of s: TreeNode?, and t: TreeNode?) -> Bool {
    
    // If either node is nil...
    if s == nil || t == nil {
        
        // ... both need to be nil
        return s == nil && t == nil
    
    // If the current nodes match
    } else if s!.val == t!.val {
        
        // Then all other children need to match as well
        return getEquality(of: s!.left, and: t!.left) && getEquality(of: s!.right, and: t!.right)
    } 
    
    // Otherwise it's not a subtree
    return false
}