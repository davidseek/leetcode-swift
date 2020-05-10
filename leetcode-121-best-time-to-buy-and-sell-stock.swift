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





https://leetcode.com/problems/best-time-to-buy-and-sell-stock/


Input: [7,1,5,3,6,4]
Output: 5
Explanation: Buy on day 2 (price = 1) and sell on day 5 (price = 6), profit = 6-1 = 5.
             Not 7-1 = 6, as selling price needs to be larger than buying price.
Example 2:

Input: [7,6,4,3,1]
Output: 0
Explanation: In this case, no transaction is done, i.e. max profit = 0.

*/

/**
Big O Annotation
Time complexity O(n) where n is the amount of elements in prices.
Space complexity O(1) we're not using any extra space.
*/
 func maxProfit(_ prices: [Int]) -> Int {
		
    // Get two pointers...
    var leftPointer: Int = 0
    var rightPointer: Int = 0

    // And a reference to the maximum profit
    var maximumProfit: Int = Int.min
    
    // While we still have elements to process...
    while leftPointer < prices.count {
        
        // ... get the first elements
        let start = prices[leftPointer]
    
        // And while the right pointer has not exhausted the bounds....
        while rightPointer < prices.count {
        
            /**
            Make sure that the right pointer is 
            not equal to the left pointer....
            */
            if leftPointer != rightPointer {
            
                // Get the price at the right pointer
                let end = prices[rightPointer]

                // ... and the sum 
                let sum = end - start 
            
                /**
                Update the maximum profit
                comparing the last maxium profit and 
                the current maxium profit 
                */
                maximumProfit = max(maximumProfit, sum)
            }
        
            // Move the right pointer towards the end.
            rightPointer += 1
        }
    
        // And move to the next number
        leftPointer += 1
        // Start the right pointer on the left pointer
        rightPointer = leftPointer
    }

    /**
    Check if the maximum profit is a profit,
    otherwise return 0
    */
    return (maximumProfit > 0) ? maximumProfit : 0
}