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
Time complexity O(n^2) where n is the amount of elements in prices.
We have O(n^2 - n) since our inner loop starts at n-i ... which is O(n^2)

Space complexity O(1) we're not using any extra space.
*/
func maxProfit(_ prices: [Int]) -> Int {
		
    // Get a reference to the maximum profit
    var maximumProfit: Int = Int.min
    
    // While we still have elements to process...
    for (index, startPrice) in prices.enumerated() {

        // Iterate away from the current index
        for j in index..<prices.count {

            // Get the price at the right pointer
            let endPrice = prices[j]

            /**
            First check if we even can
            make a profit... If not we might
            as well skip the calculation.
            */
            if endPrice < startPrice {
                
                // ... and the sum 
                let sum = endPrice - startPrice 
                /**
                Update the maximum profit
                comparing the last maxium profit and 
                the current maxium profit 
                */
                maximumProfit = max(maximumProfit, sum)
            }
        }
    }

    /**
    Check if the maximum profit is a profit,
    otherwise return 0
    */
    return (maximumProfit > 0) ? maximumProfit : 0
}