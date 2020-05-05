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