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





https://leetcode.com/problems/design-tic-tac-toe/


Design a Tic-tac-toe game that is played between two players on a n x n grid.

You may assume the following rules:

A move is guaranteed to be valid and is placed on an empty block.
Once a winning condition is reached, no more moves is allowed.
A player who succeeds in placing n of their marks in a horizontal, vertical, or diagonal row wins the game.
Example:
Given n = 3, assume that player 1 is "X" and player 2 is "O" in the board.

TicTacToe toe = new TicTacToe(3);

toe.move(0, 0, 1); -> Returns 0 (no one wins)
|X| | |
| | | |    // Player 1 makes a move at (0, 0).
| | | |

toe.move(0, 2, 2); -> Returns 0 (no one wins)
|X| |O|
| | | |    // Player 2 makes a move at (0, 2).
| | | |

toe.move(2, 2, 1); -> Returns 0 (no one wins)
|X| |O|
| | | |    // Player 1 makes a move at (2, 2).
| | |X|

toe.move(1, 1, 2); -> Returns 0 (no one wins)
|X| |O|
| |O| |    // Player 2 makes a move at (1, 1).
| | |X|

toe.move(2, 0, 1); -> Returns 0 (no one wins)
|X| |O|
| |O| |    // Player 1 makes a move at (2, 0).
|X| |X|

toe.move(1, 0, 2); -> Returns 0 (no one wins)
|X| |O|
|O|O| |    // Player 2 makes a move at (1, 0).
|X| |X|

toe.move(2, 1, 1); -> Returns 1 (player 1 wins)
|X| |O|
|O|O| |    // Player 1 makes a move at (2, 1).
|X|X|X|
Follow up:
Could you do better than O(n2) per move() operation?

*/

/**
Big O Annotation
Time complexity O(n^2) where n is the amount of elements in grid.
Space complexity O(n) where n is the amount of elements in grid.
*/
class TicTacToe {
    
    /**
    
    ["TicTacToe","move","move","move"]
    [[2],[0,0,2],[0,1,1],[1,1,2]]
    
    [2][1]
    [][2]
    
    
    */
    
    private var grid: [[Int]] 

    /** Initialize your data structure here. */
    init(_ n: Int) {
        
        let inner: [Int] = Array(repeating: 0, count: n)
        grid = Array(repeating: inner, count: n)
    }
    
    /** Player {player} makes a move at ({row}, {col}).
        @param row The row of the board.
        @param col The column of the board.
        @param player The player, can be either 1 or 2.
        @return The current winning condition, can be either:
                0: No one wins.
                1: Player 1 wins.
                2: Player 2 wins. */
    func move(_ row: Int, _ col: Int, _ player: Int) -> Int {
        
        grid[row][col] = player
        let didFoundWinner = getGridStatus(for: player)
        return didFoundWinner ? player : 0
    }
    
    private func getGridStatus(for player: Int) -> Bool {
        
        return foundWinnerVertically(player) ||
            foundWinnerHorizontally(player) ||
            foundWinnerDiagonallyForwards(player) ||
            foundWinnerDiagonallyBackwards(player)
    }
    
    private func foundWinnerVertically(_ player: Int) -> Bool {
        
        /**
        Checks top to bottom

        [X][ ][ ]
        [X][ ][ ]
        [X][ ][ ]
        */
        for (index, column) in grid[0].enumerated() {
            
            if column == player {
                
                var row: Int = 1
                
                while row < grid.count {
                    
                    if grid[row][index] == player {
                        row += 1
                    } else {
                        break
                    }
                }
                
                if row == grid.count {
                    return true
                }
            }
        }
        
        return false
    }
    
    private func foundWinnerHorizontally(_ player: Int) -> Bool {
        
        /**
        Checks top to bottom

        [X][X][X]
        [ ][ ][ ]
        [ ][ ][ ]
        */
        for (index, row) in grid.enumerated() {
            
            if row[0] == player {
                
                var column: Int = 1
                
                while column < grid[index].count {
                    
                    if grid[index][column] == player {
                        column += 1
                    } else {
                        break
                    }
                }
                
                if column == grid[index].count {
                    return true
                }
            }
        }
        
        return false
    }
    
    private func foundWinnerDiagonallyForwards(_ player: Int) -> Bool {
        
        /**
        Checks top to bottom

        [X][ ][ ]
        [ ][X][ ]
        [ ][ ][X]
        */
        if grid[0][0] == player {
            
            var index: Int = 0
                
            while index < grid.count {

                if grid[index][index] == player {
                    index += 1
                } else {
                    break
                }
            }

            if index == grid.count {
                return true
            }
        }
        
        return false
    }
    
    private func foundWinnerDiagonallyBackwards(_ player: Int) -> Bool {
        
        /**
        Checks top to bottom

        [ ][ ][X]
        [ ][X][ ]
        [X][ ][ ]
        */
        if grid[0][grid.count - 1] == player {
            
            var index: Int = 0
            var end: Int = grid.count - 1
                
            while index < grid.count {

                if grid[index][end] == player {
                    index += 1
                    end -= 1
                } else {
                    break
                }
            }

            if index == grid.count {
                return true
            }
        }
        
        return false
    }
}

/**
 * Your TicTacToe object will be instantiated and called as such:
 * let obj = TicTacToe(n)
 * let ret_1: Int = obj.move(row, col, player)
 */