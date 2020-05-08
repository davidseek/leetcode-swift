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





https://leetcode.com/problems/search-a-2d-matrix-ii/


Write an efficient algorithm that searches for a value in an m x n matrix. This matrix has the following properties:

Integers in each row are sorted in ascending from left to right.
Integers in each column are sorted in ascending from top to bottom.
Example:

Consider the following matrix:

[
  [1,   4,  7, 11, 15],
  [2,   5,  8, 12, 19],
  [3,   6,  9, 16, 22],
  [10, 13, 14, 17, 24],
  [18, 21, 23, 26, 30]
]
Given target = 5, return true.

Given target = 20, return false.

*/

/**
Big O Annotation
Time complexity O(nm) where n is the number of rows in 
matrix and m the number of elements in each row.
Space complexity O(1). We're not using any extra space.

I'm sure there is a binary search kind of thing
that would be a better algorithm, 
but for now I'm satisfied with my 2 pointer approach.
*/
func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
	
    guard !matrix.isEmpty else {
        return false 
    }

    var i: Int = 0 
    var j: Int = matrix.count - 1
    
    while i <= j {
        
        for element in matrix[i] {
            if element == target {
                return true
            }
        }   
        
        for element in matrix[j] {
            if element == target {
                return true
            }
        }
        
        i += 1
        j -= 1
    }
    
    return false
}