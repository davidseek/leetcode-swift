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





https://leetcode.com/problems/rotate-image/


You are given an n x n 2D matrix representing an image.

Rotate the image by 90 degrees (clockwise).

Note:

You have to rotate the image in-place, which means you have to modify the input 2D matrix directly. DO NOT allocate another 2D matrix and do the rotation.

Example 1:

Given input matrix = 
[
  [1,2,3],
  [4,5,6],
  [7,8,9]
],

rotate the input matrix in-place such that it becomes:
[
  [7,4,1],
  [8,5,2],
  [9,6,3]
]
Example 2:

Given input matrix =
[
  [ 5, 1, 9,11],
  [ 2, 4, 8,10],
  [13, 3, 6, 7],
  [15,14,12,16]
], 

rotate the input matrix in-place such that it becomes:
[
  [15,13, 2, 5],
  [14, 3, 4, 1],
  [12, 6, 8, 9],
  [16, 7,10,11]
]

*/

/**
Big O Annotation
Time complexity O(n^2) in the worst case where n is the number of elements in the matrix.
We're technically running O(n * n-1) but might as well call it O(n^2).
Space complexity O(1) as we're using in-place allocation.
*/
func rotate(_ matrix: inout [[Int]]) {
        
    /**
    To go from:

    [1,2,3],
    [4,5,6],
    [7,8,9]

    to: 

    [7,8,9],
    [4,5,6],
    [1,2,3]

    ...we first need to reverse the matrix.
    */
    matrix = matrix.reversed()
    
    /**
    Then we iterate through the matrix.
    But in the j loop we iterate up to but
    not including i. To not override/revert what we just did.

    The goal is to transpose the matrix.
    So...
    index 1,0 becomes 0,1
    index 2,0 becomes 0,2
    index 2,1 becomes 1,2
    index 2,2 stays 2,2

    That way we're adding the final step of the rotation.
    */
    for i in 0..<matrix.count {
        
        for j in 0..<i {
        
            let temp = matrix[i][j]
            matrix[i][j] = matrix[j][i]
            matrix[j][i] = temp
        }
    }

    // No return necessary as we're mutating in-space
}