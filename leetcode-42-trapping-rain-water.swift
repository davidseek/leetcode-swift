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
	
    /**
    If we have no heights at all, 
    we can't trap any rain water
    */
    guard height.count > 0 else {
        return 0
    }

    var result: Int = 0
    var level: Int = 0 

    // Left pointer
    var left: Int = 0

    // Right pointer 
    var right: Int = height.count - 1

    /**
    While our pointers haven't crossed, 
    keep on looping.
    */
    while left < right {
        
        /**
        First we need to check if we have 
        a wall to the left or a wall to the right

        If the element at the left pointer is 
        smaller than the element at the right pointer,
        then we have a wall to the right.

        If not, then we have a wall to the left.
        */
        let wallTotheRight = height[left] < height[right]

        /**
        If we have a wall to the right,
        get the left pointer's current element.

        If we have a wall to the left,
        get the right pointer's current element.
        */
        let index = wallTotheRight ? left : right 

        /**
        The current element of the desired pointer 
        defines the current level
        */
        let currentLevel = height[index]

        /**
        Next we want to set the new level 
        to the maximum between our old level and the 
        current level.
        */
        level = max(level, currentLevel)

        /**
        Add the difference between the global level
        and the current level to our result.
        */
        result += level - currentLevel
    
        /**
        Lastly move the pointer without the wall 
        further along. If we have a wall to the right,
        we want to move the left pointer towards the right pointer.

        If we have a wall to the left, we want to move the left pointer
        towards the right pointer.
        */
        if wallTotheRight {
            left += 1
        } else {
            right -= 1
        }
    }

    return result
}