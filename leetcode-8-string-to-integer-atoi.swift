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





https://leetcode.com/problems/string-to-integer-atoi/


Implement atoi which converts a string to an integer.

The function first discards as many whitespace characters as necessary until the first non-whitespace character is found. Then, starting from this character, takes an optional initial plus or minus sign followed by as many numerical digits as possible, and interprets them as a numerical value.

The string can contain additional characters after those that form the integral number, which are ignored and have no effect on the behavior of this function.

If the first sequence of non-whitespace characters in str is not a valid integral number, or if no such sequence exists because either str is empty or it contains only whitespace characters, no conversion is performed.

If no valid conversion could be performed, a zero value is returned.

Note:

Only the space character ' ' is considered as whitespace character.
Assume we are dealing with an environment which could only store integers within the 32-bit signed integer range: [−231,  231 − 1]. If the numerical value is out of the range of representable values, INT_MAX (231 − 1) or INT_MIN (−231) is returned.
Example 1:

Input: "42"
Output: 42
Example 2:

Input: "   -42"
Output: -42
Explanation: The first non-whitespace character is '-', which is the minus sign.
             Then take as many numerical digits as possible, which gets 42.
Example 3:

Input: "4193 with words"
Output: 4193
Explanation: Conversion stops at digit '3' as the next character is not a numerical digit.
Example 4:

Input: "words and 987"
Output: 0
Explanation: The first non-whitespace character is 'w', which is not a numerical 
             digit or a +/- sign. Therefore no valid conversion could be performed.
Example 5:

Input: "-91283472332"
Output: -2147483648
Explanation: The number "-91283472332" is out of the range of a 32-bit signed integer.
             Thefore INT_MIN (−231) is returned.

*/

/**
Big O Annotation
Time complexity O(n) where n is the amount of characters in str.
Space complexity O(n) where n is the amount of characters in str.
*/
func myAtoi(_ str: String) -> Int {
		
    // We create a set of valid digits for O(1) contains operation
    let digits: Set<Character> = ["0","1","2","3","4","5","6","7","8","9"]
    // First we split the string into a character array
    let characters: [Character] = Array(str)
    var finalDigit: [Character] = [] 

    // Iterate through the character array
    for character in characters {

        // Check if the current character is a digit...
        if digits.contains(character) {

            /**
            ... and if so simply add it to the finalDigit array
            */
            finalDigit.append(character)

        } else {

            // If not then we first check for white spaces
            if character == " " {

                /**
                If it's before a potential number,
                we just want to skip to the next character.
                */
                if finalDigit.count == 0 {

                    continue

                } else {

                    /**
                    Otherwise we have a number 
                    and everything afterwards is not not 
                    of interest to us anymore according to the challenge.
                    */
                    break
                }

            // Next we check if we have a minus or plus character
            } else if character == "-" || character == "+" {

                // If so, but we have no digits yet...
                if finalDigit.count == 0 {

                    // ... we simply want to add it.
                    finalDigit.append(character)

                } else {

                    // Otherwise break and leave
                    break
                }

            } else {

                /**
                If we have a whole different character,
                we check if the finalDigit array is empty
                and if so we want to return 0 as
                stated in the challenge description: Example 4.
                Otherwise break and exist the loop.
                */
                if finalDigit.count == 0 {
                    return 0
                } else {
                    break
                }

            }
        }
    }

    // Map to a String array
    let mapped: [String] = finalDigit.map { element in
        return "\(element)"
    }

    // Join the characters together
    let joined = mapped.joined()

    /**
    First let's check if we can turn the 
    result generally into a number represenation.
    */
    if Double(joined) == nil {
        return 0
    }

    /**
    Next we want to check if our joined string
    can be turned into a 32 bit integer 
    or if it overflows.
    */  
    let doesntOverflow = Int32(joined) != nil

    // If it doesn't overflows, return
    if doesntOverflow {

        return Int(Int32(joined)!)

    // If it does...
    } else {

        /**
        We need to check if it was positive or 
        negative and return min/max respectively
        */
        if finalDigit[0] == "-" {
            return Int(Int32.min)
        } else {
            return Int(Int32.max)
        }
    }
}