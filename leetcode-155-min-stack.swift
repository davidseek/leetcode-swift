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





https://leetcode.com/problems/min-stack/


Design a stack that supports push, pop, top, and retrieving the minimum element in constant time.

push(x) -- Push element x onto stack.
pop() -- Removes the element on top of the stack.
top() -- Get the top element.
getMin() -- Retrieve the minimum element in the stack.
 

Example 1:

Input
["MinStack","push","push","push","getMin","pop","top","getMin"]
[[],[-2],[0],[-3],[],[],[],[]]

Output
[null,null,null,null,-3,null,0,-2]

Explanation
MinStack minStack = new MinStack();
minStack.push(-2);
minStack.push(0);
minStack.push(-3);
minStack.getMin(); // return -3
minStack.pop();
minStack.top();    // return 0
minStack.getMin(); // return -2

*/

/**
Big O Annotation
Time complexity O(1) all operations are constant.
Space complexity O(n) where n is the number of elements in the stack.
*/
class MinStack {

    /**
    Min stack holds all min elements
    with the current lowest min on the top (last)
    */
    private var minStack: [Int] = []

    // Array of all elements on the stack
    private var array: [Int] = []

    // Empty init
    init() {}
    
    func push(_ x: Int) {

        // Add element to general stack    
        array.append(x)
        
        // Check if we have a last min element
        guard let last = minStack.last else {

            // If not add the current element
            minStack.append(x)
            return 
        }

        /**
        Otherwise check if we have a new minimum element.
        
        Initially I was setting this just to ">"m
        but I failed a test that expects same minimum
        elements to also be stored/returned
        */
        if last >= x {
            minStack.append(x)
        }
    }
    
    func pop() {
        
        // Pop the last element from the general stack
        let popped = array.popLast()
        
        /**
        Check if it's equal to our last element of the 
        min stack, if so pop it as well
        */
        if let last = minStack.last, last == popped {
            minStack.popLast()
        }
    }
    
    func top() -> Int {

        /**
        "Peeks" on the last element of the general array.
        
        There was no requirement for what to return if 
        there is no last element so I'm returning -1
        as this follows the requirements of other challenges
        on leetcode.com.
        */
        return array.last ?? -1
    }
    
    func getMin() -> Int {

        /**
        "Peeks" on the last element of the min stack array.
        
        There was no requirement for what to return if 
        there is no last element so I'm returning -1
        as this follows the requirements of other challenges
        on leetcode.com.
        */
        return minStack.last ?? -1
    }
}