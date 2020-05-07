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





https://leetcode.com/problems/fizz-buzz/


Write a program that outputs the string representation of numbers from 1 to n.

But for multiples of three it should output “Fizz” instead of the number and for the multiples of five output “Buzz”. For numbers which are multiples of both three and five output “FizzBuzz”.

Example:

n = 15,

Return:
[
    "1",
    "2",
    "Fizz",
    "4",
    "Buzz",
    "Fizz",
    "7",
    "8",
    "Fizz",
    "Buzz",
    "11",
    "Fizz",
    "13",
    "14",
    "FizzBuzz"
]

*/

/**
Big O Annotation
Time complexity O(n) where n is 1...n.
Space complexity O(n) where n is 1...n.
*/
func fizzBuzz(_ n: Int) -> [String] {
        
    var result: [String] = []
    
    // Iterate from 0 to n
    for number in 1...n {
        
        // Check if element is a multiplication of 3
        let multiplicationOf3 = (number % 3) == 0 

        // Check if element is a multiplication of 5
        let multiplicationOf5 = (number % 5) == 0 
        
        // If it's both, then add "FizzBuzz"
        if multiplicationOf3 && multiplicationOf5 {
            
            result.append("FizzBuzz")
            
        // Add "Fizz" for 3 
        } else if multiplicationOf3 {
            
            result.append("Fizz")
            
        // Add "Fizz" for 5
        } else if multiplicationOf5 {
            
            result.append("Buzz")
        
        // Else add just the number
        } else {
            
            result.append("\(number)")
        }
    }
    
    return result
}