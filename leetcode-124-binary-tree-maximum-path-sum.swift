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





https://leetcode.com/problems/binary-tree-maximum-path-sum/


Given a non-empty binary tree, find the maximum path sum.

For this problem, a path is defined as any sequence of nodes from some starting node to any node in the tree along the parent-child connections. The path must contain at least one node and does not need to go through the root.

Example 1:

Input: [1,2,3]

       1
      / \
     2   3

Output: 6
Example 2:

Input: [-10,9,20,null,null,15,7]

   -10
   / \
  9  20
    /  \
   15   7

Output: 42

*/

/**
Big O Annotation
Time complexity O(n) where n is the amount of nodes in root.
Space complexity O(1) we're not using any extra space but maxPathSum.
*/
 func maxPathSum(_ root: TreeNode?) -> Int {

    // Get a Int.min max path to start with
    var maxPathSum = Int.min

    // Start the recursion
    getMaxPathSum(for: root, maxPathSum: &maxPathSum)

    // Return the final sum
    return maxPathSum
}

func getMaxPathSum(for node: TreeNode?, maxPathSum: inout Int) -> Int {

    // If there is no node, there's no sum
    guard let node = node else {
        return 0
    }

    /**
    Get the left branch's highest sum.
    It's important to check again max(0... to make 
    sure that we're accounting for negative path sums.
    */
    let left = max(0, getMaxPathSum(for: node.left, maxPathSum: &maxPathSum))

    // Same on the right side...
    let right = max(0, getMaxPathSum(for: node.right, maxPathSum: &maxPathSum))

    // Get the new maximum path sum
    maxPathSum = max(maxPathSum, left + right + node.val)

    // Return whatever branch is the larger + node.val
    return max(left, right) + node.val
}  