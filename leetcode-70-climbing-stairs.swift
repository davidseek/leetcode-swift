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





https://leetcode.com/problems/climbing-stairs/


You are climbing a stair case. It takes n steps to reach to the top.

Each time you can either climb 1 or 2 steps. In how many distinct ways can you climb to the top?

Note: Given n will be a positive integer.

Example 1:

Input: 2
Output: 2
Explanation: There are two ways to climb to the top.
1. 1 step + 1 step
2. 2 steps
Example 2:

Input: 3
Output: 3
Explanation: There are three ways to climb to the top.
1. 1 step + 1 step + 1 step
2. 1 step + 2 steps
3. 2 steps + 1 step

*/

/**
Big O Annotation
Time complexity O(n) where n is the amount of elements between 0 and target.
Space complexity O(n) where n is the amount of elements between 0 and target.
*/
func climbStairs(_ n: Int) -> Int {
        
    /** 
    In our dp approach we're going to use the bottom up way
    of creating our output array. The advantage besides 
    memoization is, that we're not running into 
    stackoverflow protection territory.

    If we'd call the recursive function hundreds of times,
    many code runners return Segment 11 error.

    The idea is, that we're adding the 
    amount of stairs it will take upfront.

    Example:
    5 stair

    0 stair     -> 1 way
    1 stair     -> 1 way
    2 stairs    -> 2 ways (0 + 1)
    3 stairs    -> 3 ways (1 + 2)
    4 stairs    -> 5 ways (2 + 3)
    5 stairs    -> 8 ways (3 + 5)
    */
    var bottomUp: [Int] = []
    bottomUp.append(1) // 0 stairs -> 1 way
    bottomUp.append(2) // 1 stairs -> 1 way
    bottomUp.append(3) // 2 stairs -> 2 ways
    
    /**
    Since we're forming bounds from 3 up to n,
    we need to make sure,
    that we actually have n > 3
    otherwise we'll run into bounds forming errors.
    */
    if n > 2 {
        
        for index in 3...n + 1 {

            bottomUp.append(bottomUp[index - 1] + bottomUp[index - 2])
        }
    }
    
    return bottomUp[n - 1]
}