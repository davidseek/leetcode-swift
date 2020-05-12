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





https://leetcode.com/problems/single-element-in-a-sorted-array/


You are given a sorted array consisting of only integers where every element appears exactly twice, except for one element which appears exactly once. Find this single element that appears only once.

 

Example 1:

Input: [1,1,2,3,3,4,4,8,8]
Output: 2
Example 2:

Input: [3,3,7,7,10,11,11]
Output: 10
 

Note: Your solution should run in O(log n) time and O(1) space.

*/

/**
Big O Annotation
Time complexity O(log n) where n is the amount of elements in nums.
The two pointers put our workload in half.

Space complexity O(1) We have constant space 
as we're only storing at most 4 elements.
4 is a constant value.
*/
func singleNonDuplicate(_ nums: [Int]) -> Int {
    
    // If the array is empty, return -1
    guard !nums.isEmpty else {
        return -1
    }
    
    // If the array has exactly 1 element, return it
    guard nums.count > 1 else {
        return nums[0]
    }
    
    // Get two pointers for left and right
    var leftPointer: Int = 0
    var rightPointer: Int = nums.count - 1
    
    /**
    Init two queues. The idea is to:
    store one element in the queue
    and then take it out and compare it.
    */
    var leftQueue = QueueStack()
    var rightQueue = QueueStack()
            
    // Make sure that the pointers haven't crossed yet
    while leftPointer <= rightPointer {
        
        // Get the right and left element
        let left = nums[leftPointer]
        let right = nums[rightPointer]
        
        // If the stack is empty
        if leftQueue.isEmpty {
            
            // Add it to the stack
            leftQueue.enqueue(left)
            
        } else {

            // If not, then dequeue
            let dequeued = leftQueue.dequeue()!
            
            // And compare
            if dequeued != left {
                return dequeued
            }
        }
        
        // Same as for the left side
        if rightQueue.isEmpty {
            
            rightQueue.enqueue(right)
            
        } else {
            
            let dequeued = rightQueue.dequeue()!
            
            if dequeued != right {
                return dequeued
            }
        }
        
        // Move the pointers along
        leftPointer += 1
        rightPointer -= 1
    }
    
    /**
    If we have an odd array and we made 
    it till here, we have a case like:
    [1,1,2,3,3]
    
    Our loop did not recognize the mid element
    and now we need to simply return it
    as the rest of the array passed our tests.
    */
    if (nums.count % 2) != 0 {
        return nums[nums.count / 2]
    }
    
    return -1
}

/**
Queue implementation.
All operations are constant in time.
*/
struct QueueStack {
    
    private var enqueueStack: [Int] = []
    private var dequeueStack: [Int] = []
    
    init() {}
    
    public var isEmpty: Bool {
        return enqueueStack.isEmpty && dequeueStack.isEmpty
    } 
    
    public mutating func enqueue(_ element: Int) {
        enqueueStack.append(element)
    }
    
    public mutating func dequeue() -> Int? {
        if dequeueStack.isEmpty {
            dequeueStack = enqueueStack.reversed()
            enqueueStack.removeAll()
        }
        
        return dequeueStack.popLast()
    }
}