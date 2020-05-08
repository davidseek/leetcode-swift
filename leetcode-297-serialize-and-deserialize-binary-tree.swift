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





https://leetcode.com/problems/serialize-and-deserialize-binary-tree/


Serialization is the process of converting a data structure or object into a sequence of bits so that it can be stored in a file or memory buffer, or transmitted across a network connection link to be reconstructed later in the same or another computer environment.

Design an algorithm to serialize and deserialize a binary tree. There is no restriction on how your serialization/deserialization algorithm should work. You just need to ensure that a binary tree can be serialized to a string and this string can be deserialized to the original tree structure.

Example: 

You may serialize the following tree:

    1
   / \
  2   3
     / \
    4   5

as "[1,2,3,null,null,4,5]"
Clarification: The above format is the same as how LeetCode serializes a binary tree. You do not necessarily need to follow this format, so please be creative and come up with different approaches yourself.

Note: Do not use class member/global/static variables to store states. Your serialize and deserialize algorithms should be stateless.

*/

extension TreeNode {

    /**
    Returns all values of the binary tree
    in order and "nil" as string for non-existens nodes.
    */
	func traverseInOrder(_ node: TreeNode?, visit: (String) -> Void) {
		guard let node = node else {
			visit("nil")
			return
		}
		
		visit(String(node.val))
		traverseInOrder(node.left, visit: visit)
		traverseInOrder(node.right, visit: visit)
	}
}

class Codec {


    /**
    Big O Annotation
    Time complexity O(n) where n is the amount of nodes in the tree.
    Space complexity O(n) where n is the amount of nodes in the tree.
    */
	func serialize(_ root: TreeNode?) -> String {
		
        // If we have no root node, we have nothing to return
		guard let root = root else {
			return ""
		}
		
		var serialized = ""
		
        // Get all values in order
		root.traverseInOrder(root) { value in
			serialized += value + ","
		}
		
		// Drop the last comma
		serialized.removeLast()
		return serialized
	}
	
    /**
    Big O Annotation
    Time complexity O(n) where n is the amount of nodes in the tree.
    Space complexity O(n) where n is the amount of nodes in the tree.
    */
	func deserialize(_ data: String) -> TreeNode? {
		
        // If we have no data, we can't generate a tree
		guard !data.isEmpty else {
			return nil
		}
		
        // Separate all node values by comma
		let elements: [String] = data.components(separatedBy: ",")

        // We're starting at index 0 
		var index: Int = 0 
		return getNodeInOrder(fromElements: elements, startingAt: &index)
	}
	
	func getNodeInOrder(fromElements elements: [String], startingAt index: inout Int) -> TreeNode? {
		
        /**
        If the current element is "nil", 
        return nil and skip to the next index
        */
		if elements[index] == "nil" {
			index += 1
			return nil
		}
		
        // Get the current element
		let element = elements[index]

        /**
        We can safely force unwrap the integer 
        as we know it must be an interger.

        Could potentially be replaced by a 
        guard let statement.
        */
		let value = Int(element)!
		let node = TreeNode(value)
		
        // Move to the next index
		index += 1
		
        // And further down the tree
		node.left = getNodeInOrder(fromElements: elements, startingAt: &index)
		node.right = getNodeInOrder(fromElements: elements, startingAt: &index)
		
        /**
        Return the node of the current recursion.
        This node will be the root.
        But also for all other calls the children and leaves.
        */
		return node
	}
}