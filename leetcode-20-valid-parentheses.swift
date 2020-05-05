/**


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

func isValid(_ s: String) -> Bool {
	
	// Init a Character Queue
	var queue = Queue<Character>()
	
	// Iterate through given string
	for character in s {

		// Check if the character is (, { or [
		if isOpen(character) {
			
			// If so put into the queue
			queue.enqueue(character)
			
		} else {
			
			// Dequeue the last element of the queue
			guard let element = queue.dequeue() else {
				return false 
			}
			
			// Check if it's the desired counter part
			if !isOpposite(character, of: element) {
				return false
			}
		}
	}
		
	// Check if the Queue is empty
	// If not then we did not close all brackets
	return queue.isEmpty 
}

func isOpen(_ character: Character) -> Bool {
	return character == "(" ||
	character == "{" ||
	character == "["
}

func isOpposite(_ character: Character, of queueElement: Character) -> Bool {
	if character == ")" {
		return queueElement == "("
	}
	
	if character == "}" {
		return queueElement == "{"
	}
	
	// character must be ]
	return queueElement == "["
}

struct Queue<Element: Equatable> {
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
	
	mutating public func enqueue(_ element: Element) {
		array.append(element)
	}
	
	mutating public func dequeue() -> Element? {
		return array.popLast()
	}
}