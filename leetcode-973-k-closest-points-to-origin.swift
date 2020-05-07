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





https://leetcode.com/problems/k-closest-points-to-origin/


We have a list of points on the plane.  Find the K closest points to the origin (0, 0).

(Here, the distance between two points on a plane is the Euclidean distance.)

You may return the answer in any order.  The answer is guaranteed to be unique (except for the order that it is in.)

 

Example 1:

Input: points = [[1,3],[-2,2]], K = 1
Output: [[-2,2]]
Explanation: 
The distance between (1, 3) and the origin is sqrt(10).
The distance between (-2, 2) and the origin is sqrt(8).
Since sqrt(8) < sqrt(10), (-2, 2) is closer to the origin.
We only want the closest K = 1 points from the origin, so the answer is just [[-2,2]].
Example 2:

Input: points = [[3,3],[5,-1],[-2,4]], K = 2
Output: [[3,3],[-2,4]]
(The answer [[-2,4],[3,3]] would also be accepted.)

*/

/**
Big O Annotation
Time complexity O(n) where n is the number elements in points.
Space complexity O(n) where n is the number elements in points.

PS: I've also tried to solve the same challenge using a heap.
But due to the siftDown/Up nature of adding elements to the heap,
the final run time was taking just as long... 🤷🏻‍♂️

In my presented way we save a 
considerable amount of boilerplate code.
*/
func kClosest(_ points: [[Int]], _ K: Int) -> [[Int]] {
        
    /**
    Since the elements are supposed to be unique
    we can use a hashmap to store them.
    */
    var hash: [String: Point] = [:]
    
    // Iterate through the points
    for element in points {
        
        let x = element[0]
        let y = element[1]
        
        // Calculate the Euclidean distance
        let distance = x * x + y * y 

        // Create a point object...
        let point = Point(coordinate: element, distance: distance)

        // ... and store it into the map
        hash["\(x) \(y)"] = point
    }
    
    // Sort the map by distance of the points descending
    let sorted = hash.sorted { element1, element2 in
        return element1.value.distance < element2.distance
    }
    
    /**
    Map to get only a 2D array of 
    the original coordinates
    */
    let mapped = sorted.map { element in
        return element.coordinate
    }
    
    /**
    Return a new array splice of 0 
    up to but not including K
    */
    return Array(mapped[0..<K])
}

/**
Struct API Point to clearly
define what we need to keep track of.

coordinate for the final result
distance to sort the hash map.
*/
struct Point {
    let coordinate: [Int]
    let distance: Int
}