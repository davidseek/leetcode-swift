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





https://leetcode.com/problems/number-of-islands/


Given a 2d grid map of '1's (land) and '0's (water), count the number of islands. An island is surrounded by water and is formed by connecting adjacent lands horizontally or vertically. You may assume all four edges of the grid are all surrounded by water.

Example 1:

Input:
11110
11010
11000
00000

Output: 1
Example 2:

Input:
11000
11000
00100
00011

Output: 3

*/

/**
Big O Annotation
Time complexity O(n) where n is the total amount of elements in the 2D array.
Space complexity O(n) as we're creating a mutable copy of the given grid.
*/
func numIslands(_ grid: [[Character]]) -> Int {
        
    /**
    If the grid is empty we're 
    not going to have any islands
    */
    guard grid.count > 0 && grid[0].count > 0 else {
        return 0
    }
    
    var numberOfIslands: Int = 0

    /**
    Create a mutable copy of the grid 
    so we can flatten the islands
    */
    var grid = grid
    
    // Iterate through the grid
    for (i, row) in grid.enumerated() {
        
        // Iterate through each row in the gid
        for (j, column) in row.enumerated() {
            
            // If we have found an island...
            if column == "1" {
                
                // ... we'll count and flatten it
                numberOfIslands += flattenIsland(in: &grid, at: i, and: j)
            }
        }
    }
    
    return numberOfIslands
}

/**
Function to flatten any island.
discardableResult as we don't need the result. 
To mute warnings.
*/
@discardableResult
func flattenIsland(in grid: inout [[Character]], at row: Int, and column: Int) -> Int {
    
    // Check that we'renot off bounds top and left
    guard row >= 0 && column >= 0 else {
        return 0
    }
    
    // Check that we're not off bounds right and bottom
    guard row < grid.count && column < grid[row].count else {
        return 0
    }
    
    // Check if the current element is part of an island
    guard grid[row][column] == "1" else {
        return 0
    }
    
    // Flatten it
    grid[row][column] = "0"
    
    // Flatten surrounding islands
    flattenIsland(in: &grid, at: row + 1, and: column)
    flattenIsland(in: &grid, at: row - 1, and: column)
    flattenIsland(in: &grid, at: row, and: column + 1)
    flattenIsland(in: &grid, at: row, and: column - 1)
    
    // Return 1 to only cound for 1 island
    return 1
}