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

print(isValid(""))
