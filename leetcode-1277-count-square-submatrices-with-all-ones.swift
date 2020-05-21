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





https://leetcode.com/problems/count-square-submatrices-with-all-ones/


Given a m * n matrix of ones and zeros, return how many square submatrices have all ones.

 

Example 1:

Input: matrix =
[
  [0,1,1,1],
  [1,1,1,1],
  [0,1,1,1]
]
Output: 15
Explanation: 
There are 10 squares of side 1.
There are 4 squares of side 2.
There is  1 square of side 3.
Total number of squares = 10 + 4 + 1 = 15.
Example 2:

Input: matrix = 
[
  [1,0,1],
  [1,1,0],
  [1,1,0]
]
Output: 7
Explanation: 
There are 6 squares of side 1.  
There is 1 square of side 2. 
Total number of squares = 6 + 1 = 7.
 

Constraints:

1 <= arr.length <= 300
1 <= arr[0].length <= 300
0 <= arr[i][j] <= 1

*/

/**
Big O Annotation
Time complexity O(mn) where m is the rows and n the columns in matrix.
Space complexity O(mn) where m is the rows and n the columns in matrix.
*/
func countSquares(_ matrix: [[Int]]) -> Int {
        
    // First check if the matrix is empty
    guard !matrix.isEmpty && !matrix[0].isEmpty else {
        return 0
    }
    
    // Then we want to get a bunch of rows of just zeros
    let matrixContent: [Int] = Array(repeating: 0, count: matrix[0].count + 1)

    // And a matrix, that's one line longer than the original matrix
    var calculationMatrix: [[Int]] = Array(repeating: matrixContent, count: matrix.count + 1)

    // And the final sum...
    var sum: Int = 0 
    
    // Iterate through the matrix
    for i in 0..<matrix.count {
        
        // ... and through each row
        for j in 0..<matrix[0].count {
            
            // Check if the given element is a 1
            if matrix[i][j] == 1 {

                /**
                If so, get the left, top and diagonal element,
                take the minimum amount of those and add 1.

                The idea is to end up with a matrix like so:

                Input: 
                [0,1,1,1]
                [1,1,1,1]
                [0,1,1,1]

                Calculation:

                [0, 0, 0, 0, 0]
                [0, 0, 1, 1, 1]
                [0, 1, 1, 2, 2]
                [0, 0, 1, 2, 3]

                Each number represents the largest
                square that we can form at any given index.
                Example 3: The largest square
                with only 1s we can form is 3x3

                And the sum of all elements 
                represents the total amount of squares.
                */
                let left: Int = calculationMatrix[i][j + 1]
                let top: Int = calculationMatrix[i + 1][j]
                let diagonal: Int = calculationMatrix[i][j]
                let values: [Int] = [left, top, diagonal]
                let value: Int = values.min()! + 1

                // Add the value to our sum for the final output
                sum += value

                // And adjust the calculation matrix
                calculationMatrix[i + 1][j + 1] = value
            }
            
        }
    }
    
    return sum
}