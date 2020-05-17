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





https://leetcode.com/problems/search-suggestions-system/


Given an array of strings products and a string searchWord. We want to design a system that suggests at most three product names from products after each character of searchWord is typed. Suggested products should have common prefix with the searchWord. If there are more than three products with a common prefix return the three lexicographically minimums products.

Return list of lists of the suggested products after each character of searchWord is typed. 

 

Example 1:

Input: products = ["mobile","mouse","moneypot","monitor","mousepad"], searchWord = "mouse"
Output: [
["mobile","moneypot","monitor"],
["mobile","moneypot","monitor"],
["mouse","mousepad"],
["mouse","mousepad"],
["mouse","mousepad"]
]
Explanation: products sorted lexicographically = ["mobile","moneypot","monitor","mouse","mousepad"]
After typing m and mo all products match and we show user ["mobile","moneypot","monitor"]
After typing mou, mous and mouse the system suggests ["mouse","mousepad"]
Example 2:

Input: products = ["havana"], searchWord = "havana"
Output: [["havana"],["havana"],["havana"],["havana"],["havana"],["havana"]]
Example 3:

Input: products = ["bags","baggage","banner","box","cloths"], searchWord = "bags"
Output: [["baggage","bags","banner"],["baggage","bags","banner"],["baggage","bags"],["bags"]]
Example 4:

Input: products = ["havana"], searchWord = "tatiana"
Output: [[],[],[],[],[],[],[]]

*/

/**
Big O Annotation
Time complexity O(n log n) because of the alphabetical sort where 
n is the number of string in products.
Space complexity O(n) where n is the number of string in products.
*/
func suggestedProducts(_ products: [String], _ searchWord: String) -> [[String]] {
        
    // Init a basic trie
    let trie = Trie()

    // The final array
    var output: [[String]] = []
    
    // Add every word to the trie
    for word in products {
        trie.insert(word)
    }
    
    // Iterate through the search word
    for index in 0..<searchWord.count {
        
        // Get the current substring for 0...index
        let endIndex = searchWord.index(searchWord.startIndex, offsetBy: index)
        let substring = searchWord[searchWord.startIndex...endIndex]

        // Get the words that are available in the trie for that substring
        var wordsContainingSubstring = trie.getWordsContaining(String(substring))
        
        // If we have more than 3 words...
        if wordsContainingSubstring.count > 3 {

            // Cut the array for less than 3 words
            wordsContainingSubstring = Array(wordsContainingSubstring[0..<3])
        }
        
        // And append to the output array
        output.append(wordsContainingSubstring)
    }
    
    return output
}

// Basic Trie data structure
class Trie {
    
    // Value less head of the trie
    let head: TrieNode
    
    init() {
        head = TrieNode()
    }
    
    // Insert method O(n) n=characters
    func insert(_ word: String) {
        
        // Return if the word is empty
        guard !word.isEmpty else {
            return 
        }

        // Get character Array
        let characters: [Character] = Array(word)

        // Reference to current node
        var current: TrieNode = head

        // And index of the current element in the word
        var index: Int = 0 
        
        // While we still have characters...
        while index < characters.count {
            
            // Get the current character
            let character = characters[index]
            
            // Check if the character already exists
            if let child = current.children[character] {
                
                // If so, add this new word
                child.insert(word)

                // And set the child as current for the next round
                current = child

            } else {

                // If not, create a new Child 
                current = current.add(character, of: word)
            }
            
            // Increase index
            index += 1

            // And check if the word terminates
            current.isTerminating = (index == characters.count)
        }
    }
    
    /**
    Actual function to return all words
    that contain the given substring.
    */
    func getWordsContaining(_ word: String) -> [String] {
        
        // If empty, then there is no word
        guard !word.isEmpty else {
            return []
        }
        
        // Get characters of the word
        let characters: [Character] = Array(word)

        // The current node we're processing
        var current: TrieNode = head
        
        // Reference to the index we're at
        var index: Int = 0
        
        // While we still have words and the character exists...
        while index < characters.count, let child = current.children[characters[index]] {
            
            // Continue
            index += 1
            current = child
        }
        
        /**
        If we have no children for the given character
        but still characters left out, then just return an empty array
        */
        if index < characters.count {
            return []
        }
        
        /**
        Otherwise return an array of 
        the words set of the last node.

        Will contain all the words this node is part of. 
        */
        return Array(current.words).sorted()
    }
}

// Basic Trie Node 
class TrieNode {
    
    // The value of this node
    var value: Character?

    // All the words that the node is part of
    var words: Set<String>

    // All the node's children
    var children: [Character: TrieNode]

    // And if this node is the last character of a word
    var isTerminating: Bool = false
    
    init(value: Character? = nil, words: Set<String> = []) {
        self.value = value
        self.words = words
        self.children = [:]
    }
    
    // Adding a new children
    func add(_ character: Character, of word: String) -> TrieNode {
        
        /**
        Check if this character already exists,
        if so we need to add the word to it.
        */
        if let node = children[character] {
            node.words.insert(word)
            children[character] = node
            return node
        }
        
        // If not, we need to add it
        let node = TrieNode(value: character, words: [word])
        children[character] = node
        return node
    } 
    
    // Add just the used word for an existing node
    func insert(_ word: String) {
        words.insert(word)
    }
}