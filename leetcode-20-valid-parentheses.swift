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





https://leetcode.com/problems/valid-parentheses/


Given a string containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.

An input string is valid if:

Open brackets must be closed by the same type of brackets.
Open brackets must be closed in the correct order.
Note that an empty string is also considered valid.




Example 1:

Input: "()"
Output: true
Example 2:

Input: "()[]{}"
Output: true
Example 3:

Input: "(]"
Output: false
Example 4:

Input: "([)]"
Output: false
Example 5:

Input: "{[]}"
Output: true

*/

/**
Big O Annotation
Time complexity O(n) where n is the amount of characters in s.
Space complexity O(n log n) as we're 
always at most holding 1/2 of characters in n
*/
func isValid(_ s: String) -> Bool {
	
	// Init a Character Stack
	var stack = Stack<Character>()
	
	// Iterate through given string
	for character in s {

		// Check if the character is (, { or [
		if isOpen(character) {
			
			// If so put into the stack
			stack.push(character)
			
		} else {
			
			// Pop the last element of the stack
			guard let element = stack.pop() else {
				return false 
			}
			
			// Check if it's the desired counter part
			if !isOpposite(character, of: element) {
				return false
			}
		}
	}
		
	// Check if the Stack is empty
	// If not then we did not close all brackets
	return stack.isEmpty 
}

func isOpen(_ character: Character) -> Bool {
	return character == "(" ||
	character == "{" ||
	character == "["
}

func isOpposite(_ character: Character, of stackElement: Character) -> Bool {
	if character == ")" {
		return stackElement == "("
	}
	
	if character == "}" {
		return stackElement == "{"
	}
	
	// character must be ]
	return stackElement == "["
}

struct Stack<Element: Equatable> {
	private var array: [Element]
	
	public var peek: Element? {
		return array.last
	}
	
	public var isEmpty: Bool {
		return array.isEmpty
	}
	
	init() {
		array = []		
	}
	
	mutating public func push(_ element: Element) {
		array.append(element)
	}
	
	mutating public func pop() -> Element? {
		return array.popLast()
	}
}