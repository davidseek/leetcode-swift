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





https://leetcode.com/problems/meeting-rooms-ii/


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
Space complexity O(n) where n is the amount of elements in intervals.
*/
func minMeetingRooms(_ intervals: [[Int]]) -> Int {
        
    // If we have no meetings, we need no rooms
    guard !intervals.isEmpty else {
        return 0
    } 
    
    // If we have 1 meeting, we need 1 room
    guard intervals.count > 1 else {
        return 1
    }
    
    // Sort by start time
    var sorted = intervals.sorted { interval1, interval2 in
        return interval1[0] < interval2[0]
    }     
    
    /**
    Get a min heap with sorting by end time
    and init the heap with the first element of sorted.

    Heap implementation taken from: 
    https://github.com/raywenderlich/swift-algorithm-club/blob/master/Heap/Heap.swift
    */
    var minHeap: Heap<[Int]> = Heap([sorted.first!], areSorted: { $0[1] < $1[1] } )

    // Loop through the remaining elements
    for i in 1..<sorted.count {

        // Get the element
        var current = sorted[i]

        // And the root of the heap
        var heap = minHeap.removeRoot()!
        
        /**
        Check if the current element
        starts before the last root of the heap ended
        */
        if current[0] >= heap[1] {

            /**
            ... if not, then adjust the end 
            time of the heap element
            */
            heap[1] = current[1]
        } else {

            // If it does, add it to the heap
            minHeap.insert(current)
        }
        
        // Add the removed element back
        minHeap.insert(heap)
    }
    
    // And return the heap count
    return minHeap.count
}