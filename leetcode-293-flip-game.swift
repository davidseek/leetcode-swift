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





https://leetcode.com/problems/flip-game/


You are playing the following Flip Game with your friend: Given a string that contains only these two characters: + and -, you and your friend take turns to flip two consecutive "++" into "--". The game ends when a person can no longer make a move and therefore the other person will be the winner.

Write a function to compute all possible states of the string after one valid move.

Example:

Input: s = "++++"
Output: 
[
  "--++",
  "+--+",
  "++--"
]
Note: If there is no valid move, return an empty list [].

*/

/**
Big O Annotation
Time complexity O(n) where n is the amount of characters in s.
Space complexity O(n) where n is the amount of possible states.
*/
func generatePossibleNextMoves(_ s: String) -> [String] {
        
    // Create an empty states array
    var states: [String] = []

    /**
    Get a character array from s 
    for easier index access
    */
    var s: [Character] = Array(s)
    
    // Iterate through S
    for (index, character) in s.enumerated() {
        
        // Check if the current element is a +
        if character == "+" {
            
            // Get a mutable copy of the array
            var current = s
            
            // Check if the next index is also a +
            if (index + 1) < s.count && s[index + 1] == "+"  {
                
                // Turn both indices to -
                current[index] = "-"
                current[index + 1] = "-"

                // ... and add to the states
                states.append(String(current))
            }
        }
    }
    
    return states
}