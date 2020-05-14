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





https://leetcode.com/problems/implement-trie-prefix-tree/


Implement a trie with insert, search, and startsWith methods.

Example:

Trie trie = new Trie();

trie.insert("apple");
trie.search("apple");   // returns true
trie.search("app");     // returns false
trie.startsWith("app"); // returns true
trie.insert("app");   
trie.search("app");     // returns true
Note:

You may assume that all inputs are consist of lowercase letters a-z.
All inputs are guaranteed to be non-empty strings.

*/

/**
Big O Annotation
Time complexity O(n) where n is the total amount of characters added to the trie.
Space complexity O(n) where n is the total amount of characters added to the trie.
*/
class Trie {
    
    // Root will be value-less
    private let root: TrieNode

    /** Initialize your data structure here. */
    init() {

        // Init a value-less root node
        root = TrieNode()
    }
    
    /** 
    Inserts a word into the trie.
    O(n) in space and time where 
    n is the characters in word
     */
    func insert(_ word: String) {
        
        // Make sure the word is not empty
        guard !word.isEmpty else {
            return 
        }

        // Get a character array from the lowercased word 
        let characters: [Character] = Array(word.lowercased())

        // Reference to the current node, starting at root
        var currentNode: TrieNode = root 
        
        // Index reference 
        var index: Int = 0
        
        // While we still have work to do...
        while index < characters.count {
            
            // Get the current index's character
            let character = characters[index]
            
            // Check if the character exists in node's children
            if let child = currentNode.children[character] {
                
                /**
                If so, set the child as the new currentNode
                to continue down its branch
                */
                currentNode = child
                
            } else {
                
                /**
                If not, add the character as new child
                and take that child to continue the path down
                */
                // 
                currentNode = currentNode.add(child: character)
            }
            
            // Update the index
            index += 1
            
            /**
            If we have exceeded the amount of characters,
            set the the last node to isTerminating.

            This indicates multiple words in a word.
            Example "car.s." -> "car" and "cars"
            */
            if index == characters.count {
              currentNode.isTerminating = true
            }
        }
    }
    
    /** Returns if the word is in the trie. */
    func search(_ word: String) -> Bool {
        return contains(word, mustTerminate: true)
    }
    
    /** Returns if there is any word in the trie that starts with the given prefix. */
    func startsWith(_ prefix: String) -> Bool {
        return contains(prefix, mustTerminate: false)
    }
    
    /**
    Returns if a word exists in the trie
    AND if a word exists, that starts with the given 
    word if "mustTerminate" is false.

    - parameters: 
        - word: The word we're searching for
        - mustTerminate: A boolean indicating if we 
        need the complete word to be in Trie or just the beginning.
        For example if the word is "car", but we have "cars" in the 
        Trie, then [mustTerminate == true] would return false on "car". 
    */
    private func contains(_ word: String, mustTerminate: Bool) -> Bool {
        
        // Without a word nothing to check
        guard !word.isEmpty else {
            return false 
        }
        
        // Get a character array from the lowercased word 
        let characters: [Character] = Array(word.lowercased())

        // Reference to the current node, starting at root
        var currentNode: TrieNode = root 
        
        // Index reference 
        var index: Int = 0
        
        // While we have work to do and while the current character exists in the current branch...
        while index < characters.count, let child = currentNode.children[characters[index]] {

            // Move along
            index += 1
            currentNode = child
        }
        
        // Check if we found the whole word
        if index == characters.count {

            // Lastly check if the word must terminate
            return mustTerminate ? currentNode.isTerminating : true
        } else {
            
            return false
        }
    }
}

// Node class
class TrieNode {

    // The value of this node
    var value: Character?

    // The optional parent of this node
    weak var parent: TrieNode?

    // The node's children
    var children: [Character: TrieNode] = [:]

    // Is this node terminating a word?
    var isTerminating: Bool = false
    
    // Init with overload
    init(value: Character? = nil, parent: TrieNode? = nil) {
        self.value = value
        self.parent = parent
    }
    
    // Adding of a new child O(1)
    func add(child: Character) -> TrieNode {

        // Only add if it does not exist already
        guard children[child] == nil else {
            return children[child]!
        }

        // New node from given value
        let node = TrieNode(value: child, parent: self)
        
        // Add new Node object for this character
        children[child] = node

        // Return the node
        return node
    }
}