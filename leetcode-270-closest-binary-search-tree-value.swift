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





https://leetcode.com/problems/closest-binary-search-tree-value/


Given a non-empty binary search tree and a target value, find the value in the BST that is closest to the target.

Note:

Given target value is a floating point.
You are guaranteed to have only one unique value in the BST that is closest to the target.
Example:

Input: root = [4,2,5,1,3], target = 3.714286

    4
   / \
  2   5
 / \
1   3

Output: 4

*/

/**
Big O Annotation
Time complexity O(n) where n is the amount of nodes in root.
Space complexity O(n) where n is the amount of nodes in root.
*/
func closestValue(_ root: TreeNode?, _ target: Double) -> Int {
        
    // First we want to get a rounded target
    let floatTarget: Float = Float(target).rounded()
    let integerTarget: Int = Int(floatTarget)
    
    // Then we need to traverse the BST
    var values: [Int] = []
    traverse(root) { values.append($0) }

    // Lastly we want to get the closes value
    return getClosest(to: Int(target), in: values)
}

// Simple in order traversal
private func traverse(_ node: TreeNode?, _ visit: (Int) -> Void) {
    guard let node = node else { return }
    traverse(node.left, visit)
    visit(node.val)
    traverse(node.right, visit)
}

// Gets the closes element in an array to target
private func getClosest(to target: Int, in array: [Int]) -> Int {
    
    var distance: Int = Int.max
    var index: Int = 0 
    var candidate: Int = 0
    
    for element in array {
        
        let currentDistance = abs(element - target)
        if currentDistance < distance {
            distance = currentDistance
            candidate = element
        }
    }
    
    return candidate
}