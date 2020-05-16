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





https://leetcode.com/problems/max-area-of-island/


Given a non-empty 2D array grid of 0's and 1's, an island is a group of 1's (representing land) connected 4-directionally (horizontal or vertical.) You may assume all four edges of the grid are surrounded by water.

Find the maximum area of an island in the given 2D array. (If there is no island, the maximum area is 0.)

Example 1:

[[0,0,1,0,0,0,0,1,0,0,0,0,0],
 [0,0,0,0,0,0,0,1,1,1,0,0,0],
 [0,1,1,0,1,0,0,0,0,0,0,0,0],
 [0,1,0,0,1,1,0,0,1,0,1,0,0],
 [0,1,0,0,1,1,0,0,1,1,1,0,0],
 [0,0,0,0,0,0,0,0,0,0,1,0,0],
 [0,0,0,0,0,0,0,1,1,1,0,0,0],
 [0,0,0,0,0,0,0,1,1,0,0,0,0]]
Given the above grid, return 6. Note the answer is not 11, because the island must be connected 4-directionally.
Example 2:

[[0,0,0,0,0,0,0,0]]
Given the above grid, return 0.
Note: The length of each dimension in the given grid does not exceed 50.

*/

/**
Big O Annotation
Time complexity O(n) where n is the amount of elements in grid.
Space complexity O(n) where n is the amount of elements in grid.
*/
func maxAreaOfIsland(_ grid: [[Int]]) -> Int {
        
    // Get a mutable copy of the grid
    var grid = grid

    /**
    Init an empty area set.
    We will fill this with all the 
    available areas of all the islands
    and in the end return max()
    */
    var islands: Set<Int> = []
    
    // Iterate through the grid
    for (i, row) in grid.enumerated() {
        
        // And through each row
        for (j, column) in row.enumerated() {
            
            // Init area as 0
            var area: Int = 0

            // Flatten all connected parts of this island 
            flattenIsland(&grid, i, j, area: &area)

            // And add the final area to the set
            islands.insert(area)
        }
    }
    
    // Return the max element
    return islands.max() ?? 0
}

/**
Takes the grid, the x/y and the area as mutable element.
Will visit all adjacent neighbors, flatten them
and add their count to the area.
*/
func flattenIsland(_ grid: inout [[Int]], _ i: Int, _ j: Int, area: inout Int) {
    
    // Check left and top bounds
    guard i >= 0 && j >= 0 else {
        return 
    }
    
    // Check right and bottom bounds
    guard i < grid.count && j < grid[i].count else {
        return
    }

    // Make sure it's actually an island
    guard grid[i][j] == 1 else {
        return
    }
    
    // Flatten it so we dont count it again
    grid[i][j] = 0

    // And add +1 to the area
    area += 1
    
    // Continue through the neighbors
    flattenIsland(&grid, i + 1, j, area: &area)
    flattenIsland(&grid, i - 1, j, area: &area)
    flattenIsland(&grid, i, j + 1, area: &area)
    flattenIsland(&grid, i, j - 1, area: &area)
}