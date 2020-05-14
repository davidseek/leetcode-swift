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





https://leetcode.com/problems/word-ladder/


Given two words (beginWord and endWord), and a dictionary's word list, find the length of shortest transformation sequence from beginWord to endWord, such that:

Only one letter can be changed at a time.
Each transformed word must exist in the word list.
Note:

Return 0 if there is no such transformation sequence.
All words have the same length.
All words contain only lowercase alphabetic characters.
You may assume no duplicates in the word list.
You may assume beginWord and endWord are non-empty and are not the same.
Example 1:

Input:
beginWord = "hit",
endWord = "cog",
wordList = ["hot","dot","dog","lot","log","cog"]

Output: 5

Explanation: As one shortest transformation is "hit" -> "hot" -> "dot" -> "dog" -> "cog",
return its length 5.
Example 2:

Input:
beginWord = "hit"
endWord = "cog"
wordList = ["hot","dot","dog","lot","log"]

Output: 0

Explanation: The endWord "cog" is not in wordList, therefore no possible transformation.

*/

/**
Big O Annotation
Time complexity O(n) where n is the amount of elements in nums.
Space complexity O(n) where n is the amount of elements in nums.
*/
func ladderLength(_ beginWord: String, _ endWord: String, _ wordList: [String]) -> Int {
        
    // Set of words for O(1) contains complexity
    var words: Set<String> = Set(wordList) 
    
    // If the endword is not part of the list, return 0
    guard words.contains(endWord) else {
        return 0
    }
    
    // Enqueue the first element at level 1
    var queue: Queue = Queue()
    queue.enqueue(beginWord, at: 1)
    
    // While we still have elements in the queue
    while !queue.isEmpty {
        
        // Empty the whole queue
        for _ in 0..<queue.count {
            
            // Get current word and level 
            let (word, level) = queue.dequeue()!

            // Get character Array from the word for easy index access
            var characters: [Character] = Array(word)
            
            /**
            The idea is now to go through every character
            of the character array and replace every character
            one by one with every letter of the alphabet
            and check if the new word is part of the word list.
            */
            for (j, character) in characters.enumerated() {
                    
                for letter in "abcdefghijklmnopqrstuvwxyz" where letter != character {
                    
                    // Swap the current letter
                    characters[j] = letter
                    
                    // Get the new word
                    let newWord = String(characters)
                    
                    // If it's the end word, then we're done
                    if newWord == endWord {
                        return level + 1
                    }
                    
                    // If not, check if it's part of the word list
                    if words.contains(newWord) {

                        // If so, add it to the queue at the next level
                        queue.enqueue(newWord, at: level + 1)

                        /**
                        And remove it from the word list, so we don't run into 
                        stackoverflow where we're in a cycle of the same
                        2 words over and over again.
                        */
                        words.remove(newWord)
                    }
                }

                /**
                Lastly set the original character back
                for the next iteration.
                */ 
                characters[j] = character
            }
        }
    }
    
    /**
    If we never returnes a level above
    it means, that the word is not in the set.

    Technically we should never arrive here,
    as we already checked for this case.

    So might want to add additional error logs here.
    */
    return 0
}

/**
Simple Queue Stack implementation.
All operations are O(1) in time and O(n) in space.
Where n is the number of Strings of the wordList
*/

struct Queue {
    private var enqueueArray: [(word: String, level: Int)] = []
    private var dequeueArray: [(word: String, level: Int)] = []
    
    init() {}
    
    public var count: Int {
        return enqueueArray.count + dequeueArray.count 
    }
    
    public var isEmpty: Bool {
        return count < 1
    }
    
    public mutating func enqueue(_ element: String, at level: Int) {
        enqueueArray.append((word: element, level: level))
    }
    
    public mutating func dequeue() -> (word: String, level: Int)? {
        
        if dequeueArray.isEmpty {
            dequeueArray = enqueueArray.reversed()
            enqueueArray.removeAll()
        }
        
        return dequeueArray.popLast()
    }
}