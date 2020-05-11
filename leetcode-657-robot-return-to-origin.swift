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





https://leetcode.com/problems/robot-return-to-origin/


There is a robot starting at position (0, 0), the origin, on a 2D plane. Given a sequence of its moves, judge if this robot ends up at (0, 0) after it completes its moves.

The move sequence is represented by a string, and the character moves[i] represents its ith move. Valid moves are R (right), L (left), U (up), and D (down). If the robot returns to the origin after it finishes all of its moves, return true. Otherwise, return false.

Note: The way that the robot is "facing" is irrelevant. "R" will always make the robot move to the right once, "L" will always make it move left, etc. Also, assume that the magnitude of the robot's movement is the same for each move.

Example 1:

Input: "UD"
Output: true 
Explanation: The robot moves up once, and then down once. All moves have the same magnitude, so it ended up at the origin where it started. Therefore, we return true.
 

Example 2:

Input: "LL"
Output: false
Explanation: The robot moves left twice. It ends up two "moves" to the left of the origin. We return false because it is not at the origin at the end of its moves.

*/

/**
Big O Annotation
Time complexity O(n) where n is the amount of character in moves.
Space complexity O(1) we're not using any extra space.
*/
func judgeCircle(_ moves: String) -> Bool {
        
    /**
    We will have a reference to 
    where we are space wise. 

    Example: "UUURRR" will get us
    3 ups and 3 rights.
    Therefore:

    upDowns = 3
    leftRights = 3
    */
    var upDowns: Int = 0
    var leftRights: Int = 0
    
    for move in moves {
        
        // For up, add 1
        if move == "U" {
            upDowns += 1    
        }
        
        // For down, remove 1
        if move == "D" {
            upDowns -= 1
        }
        
        // For left, add 1
        if move == "L" {
            leftRights += 1
        }
        
        // For right, remove 1
        if move == "R" {
            leftRights -= 1
        }
    }
    
    // In the end we need to be back to 0 / 0 
    return (upDowns == 0) && (leftRights == 0)
}