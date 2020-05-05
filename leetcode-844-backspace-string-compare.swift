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

func backspaceCompare(_ S: String, _ T: String) -> Bool {
	var sQueue = Queue<Character>()
	var tQueue = Queue<Character>()
		
	for character in S {
			
		if character == "#" {
				
			sQueue.dequeue()
				
		} else {
				
			sQueue.enqueue(character)
		}
	}
		
	for character in T {
			
		if character == "#" {
				
			tQueue.dequeue()
				
		} else {
				
			tQueue.enqueue(character)
		}
	}
		
	guard sQueue.count == tQueue.count else {
		return false
	}
		
	for _ in 0..<sQueue.count {
			
		let s = sQueue.dequeue()
		let t = tQueue.dequeue()
			
		guard s == t else {
			return false
		}
	}
		
	return true
}

struct Queue<Element: Equatable> {
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
	
	mutating public func enqueue(_ element: Element) {
		array.append(element)
	}
	
	@discardableResult
	mutating public func dequeue() -> Element? {
		return array.popLast()
	}
}


print(backspaceCompare("ab#c", "ad#c"))