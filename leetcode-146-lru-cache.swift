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





https://leetcode.com/problems/lru-cache/


Design and implement a data structure for Least Recently Used (LRU) cache. It should support the following operations: get and put.

get(key) - Get the value (will always be positive) of the key if the key exists in the cache, otherwise return -1.
put(key, value) - Set or insert the value if the key is not already present. When the cache reached its capacity, it should invalidate the least recently used item before inserting a new item.

The cache is initialized with a positive capacity.

Follow up:
Could you do both operations in O(1) time complexity?

Example:

LRUCache cache = new LRUCache( 2 /* capacity */ );

cache.put(1, 1);
cache.put(2, 2);
cache.get(1);       // returns 1
cache.put(3, 3);    // evicts key 2
cache.get(2);       // returns -1 (not found)
cache.put(4, 4);    // evicts key 1
cache.get(1);       // returns -1 (not found)
cache.get(3);       // returns 3
cache.get(4);       // returns 4

*/

/**
Big O Annotation
Time complexity O(n) where n is the amount of elements in cache.
Space complexity O(n) where n is the amount of elements in cache.
*/
class LRUCache {
    
    // Capacity of the cache
    private let capacity: Int

    // The actual key:value cache
    private var cache: [Int: Int] = [:]

    // The queue that holds the usage
    private var queue: [Int] = [] 

    init(_ capacity: Int) {
        self.capacity = capacity
    }
    
    /**
    When getting an element we need to update
    the usage of the key...
    */ 
    func get(_ key: Int) -> Int {
            
        updateUsage(of: key)
        return cache[key] ?? -1 
    }
    
    func put(_ key: Int, _ value: Int) {
        
        /**
        If the element is not a new key,
        we only want to update it's usage,
        not add it to the queue...
        */
        let newKey: Bool = cache[key] == nil
        
        // Update/add the value
        cache[key] = value
        
        // Update usage if it's a known element...
        if !newKey {
            updateUsage(of: key)
            return
        }

        // ... otherwise add it to the queue
        queue.append(key)
            
        /**
        When our queue has reached capacity,
        we need to remove the least used element
        in the queue. That will always be the first element.
        */  
        if queue.count > capacity {
            if let element = queue.first {

                // Delete it from the queue
                queue.removeFirst()

                // And remove its value from the cache
                cache[element] = nil
            }
        }
    }
    
    /**
    To update the usage of a key,
    we get it from the queue array by its index,
    we remove it from it's original index 
    and put it on the back of the queue.
    */
    private func updateUsage(of key: Int) {
        
        if let index = queue.firstIndex(of: key) {
            let element = queue.remove(at: index)
            queue.append(element)
        }
    }
}