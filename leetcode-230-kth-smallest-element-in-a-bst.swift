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





https://leetcode.com/problems/kth-smallest-element-in-a-bst/


Given a binary search tree, write a function kthSmallest to find the kth smallest element in it.

Note:
You may assume k is always valid, 1 ≤ k ≤ BST's total elements.

Example 1:

Input: root = [3,1,4,null,2], k = 1
   3
  / \
 1   4
  \
   2
Output: 1
Example 2:

Input: root = [5,3,6,2,4,null,null,1], k = 3
       5
      / \
     3   6
    / \
   2   4
  /
 1
Output: 3
Follow up:
What if the BST is modified (insert/delete operations) often and you need to find the kth smallest frequently? How would you optimize the kthSmallest routine?

*/

/**
Big O Annotation
Time complexity O(n) where n is the amount of elements in nums.
Space complexity O(n) where n is the amount of elements in nums.

I guess since it's a BST we could speed this up by 
checking the left side of the Tree, see if we get enough values to match k.
If so, return that, otherwise get the right side as well.

But I think this is O(n) and fairly good enough for the challenge.
It got us into the 50% range 🤷🏻‍♂️

I might improve later on.
*/
func kthSmallest(_ root: TreeNode?, _ k: Int) -> Int {
        
    // The BSTs values...
    var values: [Int] = []

    // Traversed...
    root?.traverse { values.append($0)}

    // Sorted and returned
    return values.sorted()[k - 1]
}

// Simple Pre order traversal
extension TreeNode {
    func traverse(_ visit: (Int) -> Void) {
        visit(val)
        left?.traverse(visit) 
        right?.traverse(visit)
    }
}