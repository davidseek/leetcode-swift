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





https://leetcode.com/problems/binary-search-tree-iterator/


Implement an iterator over a binary search tree (BST). Your iterator will be initialized with the root node of a BST.

Calling next() will return the next smallest number in the BST.

 

Example:



BSTIterator iterator = new BSTIterator(root);
iterator.next();    // return 3
iterator.next();    // return 7
iterator.hasNext(); // return true
iterator.next();    // return 9
iterator.hasNext(); // return true
iterator.next();    // return 15
iterator.hasNext(); // return true
iterator.next();    // return 20
iterator.hasNext(); // return false
 

Note:

next() and hasNext() should run in average O(1) time and uses O(h) memory, where h is the height of the tree.
You may assume that next() call will always be valid, that is, there will be at least a next smallest number in the BST when next() is called.

*/

/**
Big O Annotation
Time complexity of the init is O(1) where n is the amount of nodes in root
Space complexity O(n) where n is the amount of nodes in root

Every other operation has O(1) time complexity.
*/
class BSTIterator {
    
    private var root: TreeNode?
    private var queue: [Int] = []

    init(_ root: TreeNode?) {
        self.root = root

        // Get a queue of the reversed in order 
        traverse(root) { queue.append($0) }
        queue = queue.reversed()
    }
    
    /** @return the next smallest number */
    public func next() -> Int {
        return queue.popLast() ?? 0
    }
    
    /** @return whether we have a next smallest number */
    public func hasNext() -> Bool {
        return queue.last != nil
    }
    
    // Traverse the BST in order
    private func traverse(_ node: TreeNode?, _ visit: (Int) -> Void) {
        guard let node = node else { return }
        traverse(node.left, visit)
        visit(node.val)
        traverse(node.right, visit)
    }
}

/**
 * Your BSTIterator object will be instantiated and called as such:
 * let obj = BSTIterator(root)
 * let ret_1: Int = obj.next()
 * let ret_2: Bool = obj.hasNext()
 */