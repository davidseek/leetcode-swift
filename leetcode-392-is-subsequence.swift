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





https://leetcode.com/problems/is-subsequence/


Given a string s and a string t, check if s is subsequence of t.

A subsequence of a string is a new string which is formed from the original string by deleting some (can be none) of the characters without disturbing the relative positions of the remaining characters. (ie, "ace" is a subsequence of "abcde" while "aec" is not).

Follow up:
If there are lots of incoming S, say S1, S2, ... , Sk where k >= 1B, and you want to check one by one to see if T has its subsequence. In this scenario, how would you change your code?

Credits:
Special thanks to @pbrother for adding this problem and creating all test cases.

*/

/**
Big O Annotation
Time complexity O(n) where n is the amount of characters in t.
Space complexity O(n) where n is the amount of characters in s.
*/
func isSubsequence(_ s: String, _ t: String) -> Bool {
        
    // Init a stack from String s
    var stack = Stack(s)
    
    // Loop through String t
    for character in t {

        // Check if the first element of the stack equals the current character
        if let element = stack.peek, character == element {

            // If so, pop it
            stack.pop()
        }
    }

    // Lastly check if the stack is empty
    return stack.isEmpty
}

struct Stack {
    
    private var stack: [Character] = []
    
    init(_ s: String) {
        stack = Array(s).reversed()
    }
    
    public var isEmpty: Bool {
        return stack.isEmpty
    }
    
    public var peek: Character? {
        return stack.last
    }
    
    public mutating func pop() -> Character? {
        return stack.popLast()
    }
}