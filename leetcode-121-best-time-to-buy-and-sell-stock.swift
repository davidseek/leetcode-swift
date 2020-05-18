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
	
    // Init a minimum reference to the maximum integer
    var minimum: Int = Int.max

    // This will be our returned profit
    var profit: Int = 0
    
    // For every element in prices...
    for (index, element) in prices.enumerated() {
        
        // Check if we have found a new mimimum value
        if element < minimum {

            // And update our local minimum
            minimum = element
        } else {
            
            /**
            And check if we could make a 
            larger profit if we'd sell today
            */
            profit = max(profit, element - minimum)
        }
    }
    
    return profit
}