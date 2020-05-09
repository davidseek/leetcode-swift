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





https://leetcode.com/problems/check-if-it-is-a-straight-line/


You are given an array coordinates, coordinates[i] = [x, y], where [x, y] represents the coordinate of a point. Check if these points make a straight line in the XY plane.

 

 

Example 1:



Input: coordinates = [[1,2],[2,3],[3,4],[4,5],[5,6],[6,7]]
Output: true
Example 2:



Input: coordinates = [[1,1],[2,2],[3,4],[4,5],[5,6],[7,7]]
Output: false

*/

/**
Big O Annotation
Time complexity O(n) where n is the number of elements in coordinates.
Space complexity O(n) where n is the number of elements in coordinates.
*/
func checkStraightLine(_ coordinates: [[Int]]) -> Bool {

    /**
    If we have less than 2 points 
    we can't have a line...
    */  
    guard coordinates.count > 1 else {
        return false
    }

    /**
    If we have exactly 2 points, 
    we are supposed to return true.
    Makes sense, it's always a straight line...
    */
    guard coordinates.count > 2 else {
        return true
    }

    /*
    The variable that will hold the last 
    results of the iteration
    */
    var lastResult: Double?

    // Let's get the Xs of the first 2 points
    let element1x = coordinates[0][0]
    let element2x = coordinates[1][0]

    // And the Ys of the first 2 points
    let element1y = coordinates[0][1]
    let element2y = coordinates[1][1] 

    // Iterate through the rest
    for index in 2..<coordinates.count {

        // Get X and Y of that current point
        let element = coordinates[index] 

        /**
        Get the absolute value of the current 
        and our 2 original vectors
        */
        let absoluteValue = getAbsoluteValue(
            x1: element1x, 
            x2: element2x, 
            y1: element1y,
            y2: element2y, 
            coordinate3: element
        )

        /**
        Check if we have the same value as before,
        if not we know it's not a straight line 
        and we can return false
        */
        if let lastResult_ = lastResult, lastResult_ != absoluteValue {
            return false
        } else {
            lastResult = absoluteValue
        }
    }

    return true
}

/**
Returns the absolute value of each element in a vector.

We need to break up the calculation as below
as otherwise the compiler might spit out build warnings
for too complex calculation.

https://developer.apple.com/documentation/simd/fabs?language=objc
https://stackoverflow.com/questions/4083807/collinear-points
*/
private func getAbsoluteValue(x1: Int, x2: Int, y1: Int, y2: Int, coordinate3: [Int]) -> Double {

    let coordinate3x = coordinate3[0]
    let coordinate3y = coordinate3[1]

    let e2xe1x = x2 - x1
    let e3ye1y = coordinate3y - y1

    let e3xe1x = coordinate3x - x1
    let e2ye1y = y2 - y1

    let firstTerm = e2xe1x * e3ye1y
    let secondTerm = e3xe1x * e2ye1y

    let result = firstTerm - secondTerm

    return fabs(Double(result))
}