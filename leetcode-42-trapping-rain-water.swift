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





https://leetcode.com/problems/trapping-rain-water/


Given n non-negative integers representing an elevation map where the width of each bar is 1, compute how much water it is able to trap after raining.


The above elevation map is represented by array [0,1,0,2,1,0,1,3,2,1,2,1]. In this case, 6 units of rain water (blue section) are being trapped. Thanks Marcos for contributing this image!

Example:

Input: [0,1,0,2,1,0,1,3,2,1,2,1]
Output: 6

*/

/**
Big O Annotation
Time complexity O(n) where n is the amount of elements in nums.
Space complexity O(n) where n is the amount of elements in nums.
*/
func trap(_ height: [Int]) -> Int {
        
    guard !height.isEmpty else {
        return 0
    }

    /**
    We want to precalculate the highest
    building to the left and to the right
    for every given index.

    To reduce the complexity from O(n^2) to O(n)
    */
    var lefties: [Int] = Array(repeating: 0, count: height.count)
    lefties[0] = height[0]
    
    var righties: [Int] = Array(repeating: 0, count: height.count)
    righties[height.count - 1] = height[height.count - 1]

    // The final amount
    var water: Int = 0
    
    /**
    Iterate first through the heights
    and get the highest building 
    for every given index's left and right side
    */
    for i in 1..<height.count {

        /**
        The highest to the left is either
        the one to the left or the current index.
        */
        lefties[i] = max(lefties[i - 1], height[i])
        
        /**
        Same on the right, but we count 
        from the right to the left
        */
        let index = (height.count - 1) - i
        righties[index] = max(righties[index + 1], height[index])
    }
        
    // And finally go through the array
    for (index, element) in height.enumerated() {
        
        /**
        Get the max amount of water each index could 
        potentially hold based on the left and right walls
        */
        let maxWater: Int = min(lefties[index], righties[index])

        // And reduce by the index's own elevation
        let actualWater: Int = maxWater - element

        // Finally add the amount
        water += actualWater
    }
    
    return water
}



/**
Brute force

Big O Annotation
Time complexity O(n^2) where n is the amount of elements in nums.
Space complexity O(n) where n is the amount of elements in nums.
*/
func trap(_ height: [Int]) -> Int {
        
    var water: Int = 0
    
    for (index, element) in height.enumerated() {
        
        let leftMax: Int = Array(height[0...index]).max() ?? 0
        let rightMax: Int = Array(height[index..<height.count]).max() ?? 0
        let maxWater: Int = min(leftMax, rightMax)
        let actualWater: Int = maxWater - element
        water += actualWater
    }
    
    return water
}