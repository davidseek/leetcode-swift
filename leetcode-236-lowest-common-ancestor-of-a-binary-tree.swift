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





https://leetcode.com/problems/lowest-common-ancestor-of-a-binary-tree/


Given a binary tree, find the lowest common ancestor (LCA) of two given nodes in the tree.

According to the definition of LCA on Wikipedia: “The lowest common ancestor is defined between two nodes p and q as the lowest node in T that has both p and q as descendants (where we allow a node to be a descendant of itself).”

Given the following binary tree:  root = [3,5,1,6,2,0,8,null,null,7,4]


 

Example 1:

Input: root = [3,5,1,6,2,0,8,null,null,7,4], p = 5, q = 1
Output: 3
Explanation: The LCA of nodes 5 and 1 is 3.
Example 2:

Input: root = [3,5,1,6,2,0,8,null,null,7,4], p = 5, q = 4
Output: 5
Explanation: The LCA of nodes 5 and 4 is 5, since a node can be a descendant of itself according to the LCA definition.
 

Note:

All of the nodes' values will be unique.
p and q are different and both values will exist in the binary tree.

*/

/**
Big O Annotation
Time complexity O(n) where n is the amount of nodes in root.
Space complexity O(n) where n is the amount of nodes in root.
*/
func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
    
    // Without a root nothing to return
    guard let root = root else {
        return nil
    }
    
    // All values of p will be stored in this set
    var pValues: Set<Int> = []

    // And we will have multiple candidates
    var candidate: TreeNode? = nil

    // First let's find the branch of p's value
    find(p!.val, in: root) { pValues = Set($0) }

    // Then we're getting all values of q...    
    find(q!.val, in: root) { values in
                            
        // ... and for every value
        for value in values {

            /**
            ... we check if p has the same value
            We're overwriting the candidate to find
            the last occurence, 
            since root and every node after root 
            that is potentially in the same branch 
            will also be listed.

            Example: 

                    3
                5       1
              6   2   0   8
                7   4

            If we want the LCA of 7 and 4,
            we'd get 3, 5 and 2 where 
            2 is the last value. Therefore the LCA.
            */
            if pValues.contains(value) {

                // ... if so, add the last one
                candidate = TreeNode(value)
            }            
        }
    }
    
    return candidate
}

/**
Function to get the traversal of a branch.
We will only get the roots until we find a node.val == value.
From top to bottom.
*/
private func find(_ value: Int, in node: TreeNode?, values: [Int] = [], _ visit: ([Int]) -> Void) {
    
    guard let node = node else {
        return
    }
    
    var values = values
    
    /**
    If we have found the node we where looking for,
    we need to return the values now.
    */
    guard node.val != value else {
        values.append(node.val)
        visit(values)
        return
    }
    
    // Otherwise add the current node
    values.append(node.val)

    // And continue down the left and right branch
    find(value, in: node.left, values: values, visit)
    find(value, in: node.right, values: values, visit)
}