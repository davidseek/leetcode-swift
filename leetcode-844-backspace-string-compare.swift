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





https://leetcode.com/problems/backspace-string-compare/


Given two strings S and T, return if they are equal when both are typed into empty text editors. # means a backspace character.

Note that after backspacing an empty text, the text will continue empty.

Example 1:

Input: S = "ab#c", T = "ad#c"
Output: true
Explanation: Both S and T become "ac".
Example 2:

Input: S = "ab##", T = "c#d#"
Output: true
Explanation: Both S and T become "".
Example 3:

Input: S = "a##c", T = "#a#c"
Output: true
Explanation: Both S and T become "c".
Example 4:

Input: S = "a#c", T = "b"
Output: false
Explanation: S becomes "c" while T becomes "b".
Note:

1 <= S.length <= 200
1 <= T.length <= 200
S and T only contain lowercase letters and '#' characters.
Follow up:

Can you solve it in O(N) time and O(1) space?

*/

/**
Big O Annotation
Time complexity O(n) where n is the combined character length of S and T.
Space complexity O(n) where n is the combined character length of S and T.
*/
func backspaceCompare(_ S: String, _ T: String) -> Bool {

	/**
	Stacks to hold the characters of each S and T
	*/
	var sStack = Stack<Character>()
	var tStack = Stack<Character>()
		
	// Iterate through S
	for character in S {
			
		// And for every # pop the last..
		if character == "#" {
				
			// ... character in the stack
			sStack.pop()
				
		} else {
				
			// Otherwise push the characters into the stack
			sStack.push(character)
		}
	}
		
	// Same as for S
	for character in T {
			
		if character == "#" {
				
			tStack.pop()
				
		} else {
				
			tStack.push(character)
		}
	}

	/**
	Check if the amount of elements in the stack is equal
	if not then there is no chance for us to create the same strings.
	*/	
	guard sStack.count == tStack.count else {
		return false
	}
		
	/**
	We know the length of the stacks is equal
	so we can iterate through either of them...
	*/
	for _ in 0..<sStack.count {
			
		// To get the last elements of both stacks
		let s = sStack.pop()
		let t = tStack.pop()
		
		// If they differ return false
		guard s == t else {
			return false
		}
	}
	
	/**
	If we fell through the iteration we 
	can return true as we've checked for proper equality.
	*/
	return true
}

struct Stack<Element: Equatable> {
	var array: [Element]
	
	init() {
		array = []
	}
	
	public var isEmpty: Bool {
		return array.isEmpty
	}
	
	public var peek: Element? {
		return array.last
	}
	
	public var count: Int {
		return array.count
	}
	
	mutating public func push(_ element: Element) {
		array.append(element)
	}
	
	@discardableResult
	mutating public func pop() -> Element? {
		return array.popLast()
	}
}


print(backspaceCompare("ab#c", "ad#c"))