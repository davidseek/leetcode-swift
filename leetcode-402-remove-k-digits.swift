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





https://leetcode.com/problems/remove-k-digits/


Given a non-negative integer num represented as a string, remove k digits from the number so that the new number is the smallest possible.

Note:
The length of num is less than 10002 and will be ≥ k.
The given num does not contain any leading zero.
Example 1:

Input: num = "1432219", k = 3
Output: "1219"
Explanation: Remove the three digits 4, 3, and 2 to form the new number 1219 which is the smallest.
Example 2:

Input: num = "10200", k = 1
Output: "200"
Explanation: Remove the leading 1 and the number is 200. Note that the output must not contain leading zeroes.
Example 3:

Input: num = "10", k = 2
Output: "0"
Explanation: Remove all the digits from the number and it is left with nothing which is 0.

*/

/**
Big O Annotation
Time complexity O(n) where n is the amount of characters in num.
Space complexity O(n) where n is the amount of characters in num.
*/
func removeKdigits(_ num: String, _ k: Int) -> String {
    
    // If K is equal to num, it'll remove all letters
    guard k < num.count else {
        return "0"
    } 
    
    // Get a mutable copy of k
    var k = k 

    // Get a character array for easier index access
    var characters = Array(num)

    // Init a stack
    var stack = Stack()
    
    // The current counter
    var index: Int = 0 
    
    // While we still have characters to process...
    while index < characters.count {
        
        // Get the character at index...
        let character = characters[index]
        
        /**
        While:
        
        - we still have characters to delete
        - while the stack is not empty
        - while the top element of the stack is larger
        than the current element...
        */ 
        while k > 0 && !stack.isEmpty && Int(char: stack.peek!) > Int(char: character) {

            // Pop it
            stack.pop()

            // And decrease k by 1
            k -= 1
        }
        
        // Push the element on the top of the stack
        stack.push(character)
        
        // And move on
        index += 1
    }
    
    /**
    Now we need to handle cases like: 888
    where the clause above will never grab,
    because peek > character will always be false.
    */
    while k > 0 {
        stack.pop()
        k -= 1
    }
    
    // And return the array converted as string
    return stack.asString()
}

/**
Convenience init to get an 
integer from a character
*/
fileprivate extension Int {
    init(char: Character) {
        self.init(String(char))!
    }
}

/**
Basic stack implementation.
All operations are O(1) except 
asString() -> O(n)
*/
struct Stack {
    private var stack: [Character] = []
    
    init() {}
    
    public var isEmpty: Bool {
        return stack.isEmpty
    }
    
    public var peek: Character? {
        return stack.last
    }
    
    public mutating func push(_ element: Character) {
        stack.append(element)
    }
    
    @discardableResult
    public mutating func pop() -> Character? {
        return stack.popLast()
    }
    
    public func asString() -> String {
        
        var mapped: [String] = stack.map { character in 
            return String(character)
        }
        
        while mapped.count > 1 && mapped[0] == "0" {
            mapped.removeFirst()
        }

        return mapped.joined()
    }
}