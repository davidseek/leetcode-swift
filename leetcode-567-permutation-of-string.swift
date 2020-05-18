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





https://leetcode.com/problems/permutation-in-string/


Given two strings s1 and s2, write a function to return true if s2 contains the permutation of s1. In other words, one of the first string's permutations is the substring of the second string.

 

Example 1:

Input: s1 = "ab" s2 = "eidbaooo"
Output: True
Explanation: s2 contains one permutation of s1 ("ba").
Example 2:

Input:s1= "ab" s2 = "eidboaoo"
Output: False
 

Note:

The input strings only contain lower case letters.
The length of both given strings is in range [1, 10,000].

*/

/**
Big O Annotation
Time complexity O(n) where n is the amount of characters in s.
Space complexity O(n) where n is the amount of characters in s and p.
*/
func checkInclusion(_ s1: String, _ s2: String) -> Bool {
    
    // If p is longer, than we can't find an anagram
    guard s1.count <= s2.count else {
        return false
    }
    
    // Get a character: count map from p
    let map = getMapped(string: p)

    // The length for easier access
    let length = (s1.count - 1)
    
    /**
    Get a character array from s
    for easier index access
    */
    let s: [Character] = Array(s2)      

    // Out magical queue data structure  
    var queue = SuperQueue(start: Array(s[0...length]), map: map)

    // The starting index
    var index: Int = 0

    // The result indices
    var indices: [Int] = []
    
    /**
    Check if the initial substring 
    is an anagram of p
    */
    if queue.isInitiallyAnAnagram() {
        indices.append(index)
    }
    
    // Continue on the next elements
    index = length + 1

    // Until we have exhausted the string...
    while index < s.count {
        
        // Get the current character
        let character = s[index]
        
        // And add it to the queue with evaluation
        if queue.add(character) {
            indices.append(index - length)
        }

        // And proceed...
        index += 1
    }

    return !indices.isEmpty
}

/**
- parameters:
    - string: The String s1
- returns: 
    Returns a map of characters and their count in p.

Time and space complexity: O(n)
where n is the amount of characters in string.
*/
private func getMapped(string: String) -> [Character: Int] {
    
    var map: [Character: Int] = [:] 
    
    for character in string {
        map[character, default: 0] += 1 
    }
    
    return map
}

/**
Queue Stack data structure.
Enqueue and dequeue have O(1) in time complexity.

The idea is, that we take string s2 as 
initial map of characters and their counts.

Then we create a map of:
uses: characters and their counts
falses: characters and their counts
extras: characters and their counts

Every character in the processed substring
that was in the original map will go into uses
with the counts of usage.

Every character in the processed substring that
was NOT in the original map, will go into falses.

Every character of the original map that has NOT
been used by the initial processing,
will go into extras with the respective count.

For every new character we add,
we adjust those 3 dictionaries for
the character we're popping 
and for the character we're adding.

IF extras and falses is isEmpty,
we found a new anagram of the original string
compared to the currently processed substring.
*/
struct SuperQueue {
    private var enqueueStack: [Character] = []
    private var dequeueStack: [Character] = []
    
    private var map: [Character: Int] 
    
    private var uses: [Character: Int] = [:]
    private var falses: [Character: Int] = [:]
    private var extras: [Character: Int] = [:]

    init(start: [Character], map: [Character: Int]) {
        self.enqueueStack = start
        self.map = map
    }
    
    // Adds a new character to the queue
    public mutating func enqueue(_ character: Character) {
        enqueueStack.append(character)
    }
    
    // Drops a character from the queue
    public mutating func dequeue() -> Character? {
        if dequeueStack.isEmpty {
            dequeueStack = enqueueStack.reversed()
            enqueueStack.removeAll()
        }
        
        return dequeueStack.popLast()
    }
    
    /**
    This function does the actual job.
    Dequeues the least used character.
    Adds the new one.

    And checks for falses, extras and uses.
    */
    public mutating func add(_ character: Character) -> Bool {
        
        // Pop the first element in the queue
        guard let popped = dequeue() else {
            return false
        }
        
        /**
        Check if this character had been a character
        that was NOT in the original map
        */
        if let mapped = falses[popped] {
            
            // If so, remove it from falses
            let newCount = mapped - 1
            falses[popped] = (newCount > 0) ? newCount : nil
            
        /**
        Otherwise the character must 
        have been used and therefore...
        */
        } else if let mapped = uses[popped] {
            
            // We want to remove it from uses
            let newCount = mapped - 1
            uses[popped] = (newCount > 0) ? newCount : nil

            // ... and add it back to extras
            extras[popped, default: 0] += 1 
        }
        
        // Add the new character
        enqueue(character)
        
        // And check if it's available in extras
        if let mapped = extras[character] {
            
            // If so, decrease the count in extras...
            let newCount = mapped - 1
            extras[character] = (newCount > 0) ? newCount : nil

            // .. and add it to uses
            uses[character, default: 0] += 1 
            
        } else {
            
            // Otherwise add it to falses
            falses[character, default: 0] += 1
        }
        
        /**
        If extras and falses are 
        each empty, then we have found a new anagram
        */
        return extras.isEmpty && falses.isEmpty
    }
    
    /**
    Initial function to process
    the very first substring.

    This function will only be called on 
    the initial setup of the queue.
    */
    public mutating func isInitiallyAnAnagram() -> Bool {

        // Move everything into the dequeu stack
        dequeueStack = enqueueStack.reversed()
        enqueueStack.removeAll()
        
        // Variable we will return...
        var isValid: Bool = true
        
        // For every element in the queue...
        for character in dequeueStack {
             
            // Check if we have the character available 
            if let mapped = map[character] {

                // .. and adjust the count...
                let newCount = mapped - 1
                map[character] = (newCount > 0) ? newCount : nil

                // .. also add it to uses
                uses[character, default: 0] += 1

            } else {

                // ... otherwise add it to falses...
                falses[character, default: 0] += 1
                isValid = false
            }
        }
        
        /**
        If we're here, we would expect the map
        to be empty, if that's not the case,
        then we need to now dump everything 
        into the extras dictionary.
        */
        for (key, value) in map {
            extras[key] = value
        }
        
        return isValid
    }
}