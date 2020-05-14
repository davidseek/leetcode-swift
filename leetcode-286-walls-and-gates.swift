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





https://leetcode.com/problems/walls-and-gates/


You are given a m x n 2D grid initialized with these three possible values.

-1 - A wall or an obstacle.
0 - A gate.
INF - Infinity means an empty room. We use the value 231 - 1 = 2147483647 to represent INF as you may assume that the distance to a gate is less than 2147483647.
Fill each empty room with the distance to its nearest gate. If it is impossible to reach a gate, it should be filled with INF.

Example: 

Given the 2D grid:

INF  -1  0  INF
INF INF INF  -1
INF  -1 INF  -1
  0  -1 INF INF
After running your function, the 2D grid should be:

  3  -1   0   1
  2   2   1  -1
  1  -1   2  -1
  0  -1   3   4

*/

/**
Big O Annotation
Time complexity O(n^2) where n is the amount of elements in nums.
Space complexity O(1) we're not using any extra space.
*/
func wallsAndGates(_ rooms: inout [[Int]]) {
        
    // Iterate through every row
    for (i, row) in rooms.enumerated() {
        
        // And every column
        for (j, column) in row.enumerated() {
            
            // Check if we have a gate
            if column == 0 {

                // And run our DFS function
                setRooms(&rooms, atRow: i, andColumn: j)
            }
            
        }
    }
}

// DFS
private func setRooms(_ rooms: inout [[Int]], atRow row: Int, andColumn column: Int, to value: Int = 0) {
    
    // Check left, right, upper and lower bounds
    guard row >= 0 && column >= 0 && row < rooms.count && column < rooms[row].count else {
        return 
    }
    
    /**
    We need to check the room value.
    As we only want to update rooms that are 
    larger than our value.

    That leaves out the doors with value -1
    as the minimum value is 0.

    And it sets all the Int.max values to at least 0+1
    */
    guard value <= rooms[row][column] else {
        return
    }
    
    // Set the room to value
    rooms[row][column] = value
    
    // And traverse in all directions, updating value by 1
    setRooms(&rooms, atRow: row + 1, andColumn: column, to: value + 1)
    setRooms(&rooms, atRow: row - 1, andColumn: column, to: value + 1)
    setRooms(&rooms, atRow: row, andColumn: column + 1, to: value + 1)
    setRooms(&rooms, atRow: row, andColumn: column - 1, to: value + 1)
}