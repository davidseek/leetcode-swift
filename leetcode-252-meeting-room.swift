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





https://leetcode.com/problems/meeting-rooms/


Given an array of meeting time intervals consisting of start and end times [[s1,e1],[s2,e2],...] (si < ei), determine if a person could attend all meetings.

Example 1:

Input: [[0,30],[5,10],[15,20]]
Output: false
Example 2:

Input: [[7,10],[2,4]]
Output: true
NOTE: input types have been changed on April 15, 2019. Please reset to default code definition to get new method signature.

*/

/**
Big O Annotation
Time complexity O(n log n) where n is the amount of elements in intervals.
The sorting costs us O(n log n)

I tried implemetnation with PriorityQueue (Heap), same runtime on leetcode.
Although technically the complexity is O(log n) with a Heap.
But since it's like 100 lines more code as Swift does not 
come with native Heaps, we might as well just go with the Stack.

Space complexity O(n) where n is the amount of elements in intervals.
*/
func canAttendMeetings(_ intervals: [[Int]]) -> Bool {
        
    // If we have less than 2 meetings, then yes, all good
    guard intervals.count > 1 else {
        return true
    }
    
    // Sort by meeting end time descending
    let sorted = intervals.sorted { interval1, interval2 in
        return interval1[1] > interval2[1]
    }
    
    // Get a stack
    var stack = Stack(sorted)

    // And pop the first meeting
    var last: [Int] = stack.pop()!
    
    // While the stack is not empty...
    while !stack.isEmpty {
        
        // Pop the last element
        let popped = stack.pop()!
        
        /**
        And compare if the new meeting starts 
        before the old meeting did end
        */
        if last[1] > popped[0] {
            return false
        }
        
        // Update last
        last = popped
    }
    
    /**
    If we fell all the way through,
    then we're good to go with that schedule.
    */
    return true
}

struct Stack {
    private var stack: [[Int]]
    public var isEmpty: Bool { return stack.isEmpty }
    init(_ array: [[Int]]) { stack = array }
    public mutating func pop() -> [Int]? { return stack.popLast() }
}