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





https://leetcode.com/problems/reorder-data-in-log-files/


You have an array of logs.  Each log is a space delimited string of words.

For each log, the first word in each log is an alphanumeric identifier.  Then, either:

Each word after the identifier will consist only of lowercase letters, or;
Each word after the identifier will consist only of digits.
We will call these two varieties of logs letter-logs and digit-logs.  It is guaranteed that each log has at least one word after its identifier.

Reorder the logs so that all of the letter-logs come before any digit-log.  The letter-logs are ordered lexicographically ignoring identifier, with the identifier used in case of ties.  The digit-logs should be put in their original order.

Return the final order of the logs.

 

Example 1:

Input: logs = ["dig1 8 1 5 1","let1 art can","dig2 3 6","let2 own kit dig","let3 art zero"]
Output: ["let1 art can","let3 art zero","let2 own kit dig","dig1 8 1 5 1","dig2 3 6"]
*/



import Foundation

/**
Model to hold the alphanumeric logs.
Example: "ab1 off key dog"

identifier -> "ab1"
fullLog -> "ab1 off key dog"
alphanumericPart -> "off key dog"
*/
struct Log {
	var identifier: String
	var fullLog: String
	var alphanumericPart: String
	
	init(_ identifier: String, _ fullLog: String, _ alphanumericPart: String) {
		self.identifier = identifier
		self.fullLog = fullLog
		self.alphanumericPart = alphanumericPart
	}
}

/**
Big O Annotation
Time complexity O(n) where n is the number of logs in the array.
Space complexity O(n) as we're holding at least every log entry 
once at the same time in memory.
*/
func reorderLogFiles(_ logs: [String]) -> [String] {
				
	var numLogs: [String] = []
	var alphaLogs: [Log] = []
		
	// Iterate through the logs
	for element in logs {
			
		// Separate the strings by their components
		let components = element.components(separatedBy: " ")
		
		/**
		Testcase is the guaranteed existing first element after the identifier
		only used to "test" if we have a numeric or alpha log
		*/
		let testCase = Array(components[1])
			
		/**
		Next we want to check if the first letter 
		in this test string can be formed to an integer.
		Prevents overflow errors and we can safely assume, 
		that we have a 0 case as the description guarantees it.
		*/
		if Int("\(testCase[0])") != nil {
				
			/**
			Add the whole element to the nums log as we don't
			care for sorting it separetely.
			*/
			numLogs.append(element)
				
		} else {
				
			// Get each element and create our log object. 
			let identifier = components[0]
			let replaced = components[1...].joined(separator: " ")
			let log = Log(identifier, element, replaced)
			alphaLogs.append(log)
		}
	}
	
	
	/**
	Sort the alpha logs based on the problem description
	and map them to only get the fullLog part
	*/
	let sortedAlphaLogs = getSorted(alphaLogs)
	let mappedAlphaLogs = sortedAlphaLogs.map { element in
		return element.fullLog
	}
		
	// Return the two arrays as one
	return mappedAlphaLogs + numLogs
}

/**
Sort function first checks if the alphanumeric part is
identical and if so, sorts on the identifier.
If not sorts ascending.
*/	
func getSorted(_ strings: [Log]) -> [Log] {

	return strings.sorted { element1, element2 in
		if element1.alphanumericPart == element2.alphanumericPart {
			return element1.identifier < element2.identifier
		}

		return element1.alphanumericPart < element2.alphanumericPart
	}
}

print(reorderLogFiles(["j je", "b fjt", "7 zbr", "m le", "o 33"]))