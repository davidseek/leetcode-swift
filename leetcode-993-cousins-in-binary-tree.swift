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





https://leetcode.com/problems/cousins-in-binary-tree/


In a binary tree, the root node is at depth 0, and children of each depth k node are at depth k+1.

Two nodes of a binary tree are cousins if they have the same depth, but have different parents.

We are given the root of a binary tree with unique values, and the values x and y of two different nodes in the tree.

Return true if and only if the nodes corresponding to the values x and y are cousins.

 

Example 1:


Input: root = [1,2,3,4], x = 4, y = 3
Output: false
Example 2:


Input: root = [1,2,3,null,4,null,5], x = 5, y = 4
Output: true
Example 3:



Input: root = [1,2,3,null,4], x = 2, y = 3
Output: false
 

Note:

The number of nodes in the tree will be between 2 and 100.
Each node has a unique integer value from 1 to 100.

/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     public var val: Int
 *     public var left: TreeNode?
 *     public var right: TreeNode?
 *     public init() { self.val = 0; self.left = nil; self.right = nil; }
 *     public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
 *     public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
 *         self.val = val
 *         self.left = left
 *         self.right = right
 *     }
 * }
 */

*/

/**
Big O Annotation
Time complexity O(n) where n is the number of nodes in the tree.
Space complexity O(1) is constant as we only create at most
2x TreeNodeCousinParameters objects to hold the parameters we're looking for.
*/
func isCousins(_ root: TreeNode?, _ x: Int, _ y: Int) -> Bool {
		
    // There wont be any cousins if root is nil
	guard let root = root else {
		return false 
	}
	
    /**
    If root is either one of those values, then
    it's also impossible that we'll have 2 cousins on the same
    level with different parents
    */
	guard root.val != x && root.val != y else {
		return false
	} 
	
	var xResult: TreeNodeCousinParameters?
	var yResult: TreeNodeCousinParameters?
	
    /**
    Get the parameters of potential child with value x
    The parameters will hold the value of the parent
    and the level this child is in.

    If the child does not exist, we'll get nil
    */ 
	root.findChild(x) { parameters in
		if parameters != nil {
			xResult = parameters
		}
	}
	
    // Same for child with value y 
	root.findChild(y) { parameters in
		if parameters != nil {
			yResult = parameters
		}
	}
	
    // If we don't have two valid parameter results, we can return false
	guard let xResult_ = xResult, let yResult_ = yResult else {
		return false
	}
	
    // Otherwise check for level equality and parent difference
	return xResult_.level == yResult_.level && xResult_.parent != yResult_.parent
}

/**
Helper construct to clearly define
that we're looking for the parent and
the level of the child
*/
struct TreeNodeCousinParameters {
	let parent: Int
	let level: Int
	init(_ parent: Int, _ level: Int) {
		self.parent = parent
		self.level = level
	}
}

extension TreeNode {
	
	/**
	Completion block returns nil if not existent
	and TreeNodeCousinParameters if exists
	
	parent will be the value of the parent node
	level will be the logical level 0 based from the root down
	*/
	func findChild(_ value: Int, 
				   at level: Int = 0, 
				   _ result: (TreeNodeCousinParameters?) -> Void) {
		
		var hasLeftOrRightChild: Bool = false
		
		if let left = left {
			
			hasLeftOrRightChild = true
			
			if left.val == value {
				
				let parameters = TreeNodeCousinParameters(self.val, level)
				result(parameters)
				
			} else {
				
				left.findChild(value, at: level + 1, result)
			}
		}
		
		if let right = right {
			
			hasLeftOrRightChild = true 
			
			if right.val == value {
				
				let parameters = TreeNodeCousinParameters(self.val, level)
				result(parameters)
				
			} else {
				
				right.findChild(value, at: level + 1, result)
			}
		}
		
		if hasLeftOrRightChild == false {
			result(nil)
		}
	}
}