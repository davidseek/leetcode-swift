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





https://leetcode.com/problems/minimum-cost-to-connect-sticks/


You have some sticks with positive integer lengths.

You can connect any two sticks of lengths X and Y into one stick by paying a cost of X + Y.  You perform this action until there is one stick remaining.

Return the minimum cost of connecting all the given sticks into one stick in this way.

 

Example 1:

Input: sticks = [2,4,3]
Output: 14
Example 2:

Input: sticks = [1,8,3,5]
Output: 30
 

Constraints:

1 <= sticks.length <= 10^4
1 <= sticks[i] <= 10^4

*/

/**
Big O Annotation
Time complexity O(n) where n is the amount of elements in nums.
Space complexity O(n) where n is the amount of elements in nums.
*/
func connectSticks(_ sticks: [Int]) -> Int {
        
    // Init a min heap from the sticks
    var heap = Heap(sticks, areSorted: <)

    // The total costs
    var cost: Int = 0
    
    // While the heap is not empty
    while !heap.isEmpty {
        
        // Get the root (aka the most min element)
        let stick1 = heap.getRoot()!

        // See if there is a second elements
        guard let stick2 = heap.getRoot() else {

            // ... if not, stop
            break
        }
        
        // ... if so, smash them
        let sum = stick1 + stick2

        // And append the costs
        cost += sum

        // And add the smashed stick to the heap
        heap.insert(sum)
    }
    
    return cost
}

// Basic Heap implementation
struct Heap {
    
    private var storage: [Int] = []
    private var areSorted: (Int, Int) -> Bool
    
    init(_ storage: [Int], areSorted: @escaping (Int, Int) -> Bool) {
        self.storage = storage
        self.areSorted = areSorted
        
        guard !storage.isEmpty else {
            return 
        }
        
        for index in stride(from: storage.count / 2 - 1, through: 0 , by: -1) {
            siftDown(from: index)
        }
    }
    
    public var isEmpty: Bool {
        return storage.isEmpty
    } 
    
    public var count: Int {
        return storage.count
    }
    
    public func getChildIndices(forParentAt index: Int) -> (left: Int, right: Int) {
        let left = (index * 2) + 1
        return (left, left + 1)
    }
    
    public func getParentIndex(forChildAt index: Int) -> Int {
        return (index - 1) / 2
    }
    
    public mutating func insert(_ element: Int) {
        storage.append(element)
        siftUp(from: count - 1)
    }
    
    public mutating func getRoot() -> Int? {
        
        guard !isEmpty else {
            return nil
        }
        
        storage.swapAt(0, count - 1)
        let root = storage.removeLast()
        siftDown(from: 0)
        return root
    }
    
    public mutating func siftUp(from index: Int) {
        
        var childIndex = index
        var parentIndex = getParentIndex(forChildAt: childIndex)
        
        while childIndex > 0 && areSorted(storage[childIndex], storage[parentIndex]) {
            
            storage.swapAt(childIndex, parentIndex)
            childIndex = parentIndex
            parentIndex = getParentIndex(forChildAt: childIndex)
        }
    }
    
    public mutating func siftDown(from index: Int) {
        
        var parentIndex = index
        
        while true {
            
            let (left, right) = getChildIndices(forParentAt: parentIndex)
            var swapIndex: Int?
            
            if left < count && areSorted(storage[left], storage[parentIndex]) {
                swapIndex = left
            }
            
            if right < count && areSorted(storage[right], storage[swapIndex ?? parentIndex]) {
                swapIndex = right
            }
            
            guard swapIndex != nil else {
                return 
            }
            
            storage.swapAt(parentIndex, swapIndex!)
            parentIndex = swapIndex!
        }
    }
}