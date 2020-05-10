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





https://leetcode.com/problems/kids-with-the-greatest-number-of-candies/


Given the array candies and the integer extraCandies, where candies[i] represents the number of candies that the ith kid has.

For each kid check if there is a way to distribute extraCandies among the kids such that he or she can have the greatest number of candies among them. Notice that multiple kids can have the greatest number of candies.

 

Example 1:

Input: candies = [2,3,5,1,3], extraCandies = 3
Output: [true,true,true,false,true] 
Explanation: 
Kid 1 has 2 candies and if he or she receives all extra candies (3) will have 5 candies --- the greatest number of candies among the kids. 
Kid 2 has 3 candies and if he or she receives at least 2 extra candies will have the greatest number of candies among the kids. 
Kid 3 has 5 candies and this is already the greatest number of candies among the kids. 
Kid 4 has 1 candy and even if he or she receives all extra candies will only have 4 candies. 
Kid 5 has 3 candies and if he or she receives at least 2 extra candies will have the greatest number of candies among the kids. 
Example 2:

Input: candies = [4,2,1,1,2], extraCandies = 1
Output: [true,false,false,false,false] 
Explanation: There is only 1 extra candy, therefore only kid 1 will have the greatest number of candies among the kids regardless of who takes the extra candy.
Example 3:

Input: candies = [12,1,12], extraCandies = 10
Output: [true,false,true]

*/

/**
Big O Annotation
Time complexity O(n log n) because of the sorting overhead.
Space complexity O(n) as we're creating the sorted array.

Space could be optimized by not sorting first,
but iterating through the candies, getting the largest amount
and then iterating again to calculate.
*/
func kidsWithCandies(_ candies: [Int], _ extraCandies: Int) -> [Bool] {
        
    /**
    If we don't have any candies then
    there's nothing to supply
    */ 
    guard candies.count > 0 else {
        return []
    }
    
    /**
    If we only have one candy,
    then that is automatically the largest.
    */
    guard candies.count > 1 else {
        return [true]
    }
    
    // Sort so we have the largest at the end
    let sorted = candies.sorted()

    /**
    We can savely force unwrap the last item
    as we already checked if we have at least 2 items.
    */
    let largestAmountOfCandy = sorted.last!

    // Results array
    var result: [Bool] = []
    
    // Iterate through the candies
    for candy in candies {
        
        /**
        Calculate if the current candy + all the extra candies
        is at least equal to the largest amount of candy.
        */
        let willHaveLargestAmount = (candy + extraCandies) >= largestAmountOfCandy
        result.append(willHaveLargestAmount)
    }
    
    return result
}