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





https://leetcode.com/problems/prison-cells-after-n-days/


There are 8 prison cells in a row, and each cell is either occupied or vacant.

Each day, whether the cell is occupied or vacant changes according to the following rules:

If a cell has two adjacent neighbors that are both occupied or both vacant, then the cell becomes occupied.
Otherwise, it becomes vacant.
(Note that because the prison is a row, the first and the last cells in the row can't have two adjacent neighbors.)

We describe the current state of the prison in the following way: cells[i] == 1 if the i-th cell is occupied, else cells[i] == 0.

Given the initial state of the prison, return the state of the prison after N days (and N such changes described above.)

*/

/**
Big O Annotation
Time complexity O(1) 
Space complexity O(1) 

I would argue that we have constant time and space.
We know for sure, that cells is an array of the size 8.
That is a constant attribute.

And we know, that after 14 days, the cycle repeats.
There AT MOST we have to calculate 14 days.

14 is also a constant. 
Therefore even if N is one billion, we only do 14 iterations
to calculate the new state of the 8 cells.

2x constants. Ergo: constant time and space complexity.
*/
func prisonAfterNDays(_ cells: [Int], _ N: Int) -> [Int] {
    
    // If we have no cells, we have nothing to return
    guard cells.count > 0 else {
        return []
    }
    
    /**
    We will calculate the states in the bottom up approach
    with index 0 the given starting state.
    */  
    var bottomUp: [[Int]] = []
    bottomUp.append(cells)
    
    /**
    Every 14 days the cycle repeats.
    The first day is index 0 aka N-1
    
    After we get the modolo remainder,
    we add 1 to take the index 0 into account.
    */
    let N = (N-1) % 14 + 1 
    for day in 1...N {
        
        /**
        Get the last state to take 
        to calculate the new one from.
        */
        let last = bottomUp[day - 1]
        let current = getCalculated(prisonCells: last)
        bottomUp.append(current)
    }
    
    return bottomUp[N]
}

private func getCalculated(prisonCells cells: [Int]) -> [Int] {
    
    var nextState: [Int] = Array(repeating: 0, count: cells.count)
    
    for (index, _) in cells.enumerated() {
        
        var leftNeighbor: Int?
        var rightNeighbor: Int?

        if index > 0 {

            // The cell at index 0 has no left neighbor
            leftNeighbor = cells[index - 1]
        }

        if index < cells.count - 1 {

            // And the cell at N-1 has no neighbor
            rightNeighbor = cells[index + 1]
        }

        /**
        If both neighbors are either 1 or 0,
        ergo if they're equal,
        we want to give the middle cell 
        the active (1) state for the next round...
        */
        if let left = leftNeighbor, let right = rightNeighbor, left == right {
            nextState[index] = 1
        } else {

            // Otherwise it will be passive (0)
            nextState[index] = 0
        }
    }
    
    return nextState
}