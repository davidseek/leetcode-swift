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





https://leetcode.com/problems/rotting-oranges/


In a given grid, each cell can have one of three values:

the value 0 representing an empty cell;
the value 1 representing a fresh orange;
the value 2 representing a rotten orange.
Every minute, any fresh orange that is adjacent (4-directionally) to a rotten orange becomes rotten.

Return the minimum number of minutes that must elapse until no cell has a fresh orange.  If this is impossible, return -1 instead.

 

Example 1:



Input: [[2,1,1],[1,1,0],[0,1,1]]
Output: 4
Example 2:

Input: [[2,1,1],[0,1,1],[1,0,1]]
Output: -1
Explanation:  The orange in the bottom left corner (row 2, column 0) is never rotten, because rotting only happens 4-directionally.
Example 3:

Input: [[0,2]]
Output: 0
Explanation:  Since there are already no fresh oranges at minute 0, the answer is just 0.

*/

/**
Big O Annotation
Time complexity O(n) where n is the amount of elements in nums.
Space complexity O(n) where n is the amount of elements in nums.
*/
func orangesRotting(_ grid: [[Int]]) -> Int {
	
    /**
    The directions that oranges can 
    affect other oranges
    */
    let directions: [[Int]] = [
        [0,1],  // right
        [0,-1], // left
        [1,0],  // down
        [-1,0]  // up
    ]

    // Reference to our rotten oranges
    var rotten: [String: Int] = [:]

    // Reference to the fresh oranges
    var fresh: [String: Int] = [:]

    // Iterate through the matrix
    for (i, row) in grid.enumerated() {

        // And through each row
        for (j, orange) in row.enumerated() {

            // And store whether oranges are
            if orange == 2 {

                // ... rotten...
                rotten["\(i) \(j)"] = 0

            } else if orange == 1 {

                // ... or fresh
                fresh["\(i) \(j)"] = 0
            }
        }
    }	

    // Final count 
    var result: Int = 0 

    // Now iterate while we still have fresh oranges
    while fresh.count > 0 {
    
        /**
        Store the newly rottenoranges
        to make sure we're not counting those
        within the current iteration
        */
        var newlyRotten: [String: Int] = [:]
            
        // Iterate through the rotten oranges
        for (key, _) in rotten {
        
            // Get the coordinates as ["0", "1"]
            let coordinates = key.components(separatedBy: " ")

            // And get the row and column of the matrix
            let row = Int(coordinates[0])! // Example: "0" -> 0
            let column = Int(coordinates[1])! // Example: "1" -> 1
        
            // For each direction in direactions...
            for direction in directions {
            
                // Get the directional row
                let nextRow = row + direction[0]

                // Get the directional column
                let nextColumn = column + direction[1]
            
                /**
                If we have a fresh orange at that coordinate,
                add it to the newlyRotten oranges and
                delete from the fresh oranges
                */
                if let _ = fresh["\(nextRow) \(nextColumn)"] {
                    fresh["\(nextRow) \(nextColumn)"] = nil
                    newlyRotten["\(nextRow) \(nextColumn)"] = 0
                }
            }
        }
    
        /**
        If we don't have any newlyRotten oranges,
        then that means that we're unable to infect
        any new fresh oranges anymore
        */
        if newlyRotten.isEmpty {
            return -1
        }
    
        // Lastly we want to merge the rotten and newlyRotten oranges
        rotten = rotten.merging(newlyRotten) { (current, _) in current }

        // And update out counter
        result += 1
    }

    return result	
}