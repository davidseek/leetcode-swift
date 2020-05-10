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





https://leetcode.com/problems/fibonacci-number/


The Fibonacci numbers, commonly denoted F(n) form a sequence, called the Fibonacci sequence, such that each number is the sum of the two preceding ones, starting from 0 and 1. That is,

F(0) = 0,   F(1) = 1
F(N) = F(N - 1) + F(N - 2), for N > 1.
Given N, calculate F(N).

*/

/**
Big O Annotation
Time complexity O(n) where n is N.
Space complexity O(n) where n is N.

The bottom up approach takes more memory 
than the recursive approach.

But the recursive approach might fail
as a stackoverflow protection when the 
recursive function is called too many times
in a short amount of time.

Happens for example on the CodeRunner application.
*/
func fib(_ N: Int) -> Int {
        
    // Init a bottom up array
    var bottomUp: [Int] = []
    
    /**
    Add the 3 known starting cases of 
    the fibonacci sequence
    */
    bottomUp.append(0)
    bottomUp.append(1)
    bottomUp.append(1)
    
    // Check that N is larger than 2
    if N > 2 {
        
        // If so, iterate up through N + 1
        for index in 3...N + 1 {

            // And calculate the fib for that spot
            bottomUp.append(bottomUp[index - 1] + bottomUp[index - 2])
        }
    }
    
    // Return the Nth fib
    return bottomUp[N]
}