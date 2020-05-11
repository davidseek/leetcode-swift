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





https://leetcode.com/problems/reverse-string/


Write a function that reverses a string. The input string is given as an array of characters char[].

Do not allocate extra space for another array, you must do this by modifying the input array in-place with O(1) extra memory.

You may assume all the characters consist of printable ascii characters.

 

Example 1:

Input: ["h","e","l","l","o"]
Output: ["o","l","l","e","h"]
Example 2:

Input: ["H","a","n","n","a","h"]
Output: ["h","a","n","n","a","H"]

*/

/**
Big O Annotation
Time complexity O(log n) where n is the amount of elements in reverseString.
The two pointer recursion cuts the work load in half.

Space complexity O(1) we're not using any extra space.
*/
func reverseString(_ s: inout [Character]) {
        
    swapCharacters(
        atLeftPointer: 0,
        andRightPointer: s.count - 1,
        in: &s
    )
}

/**
The goal of this challenge was to use an iterative approach,
so that's what we're doing.
*/
func swapCharacters(atLeftPointer left: Int, 
                    andRightPointer right: Int, 
                    in array: inout [Character]) {
    
    // The base case hits when the pointers cross
    guard left < right else {
        return 
    }
    
    // Until then swap the elements at the pointers
    array.swapAt(left, right)
    
    // And repeat by increasing/decreasing the pointers
    swapCharacters(
        atLeftPointer: left + 1, 
        andRightPointer: right - 1, 
        in: &array
    )
}