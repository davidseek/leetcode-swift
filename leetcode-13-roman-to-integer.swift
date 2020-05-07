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





https://leetcode.com/problems/roman-to-integer/


Roman numerals are represented by seven different symbols: I, V, X, L, C, D and M.

Symbol       Value
I             1
V             5
X             10
L             50
C             100
D             500
M             1000
For example, two is written as II in Roman numeral, just two one's added together. Twelve is written as, XII, which is simply X + II. The number twenty seven is written as XXVII, which is XX + V + II.

Roman numerals are usually written largest to smallest from left to right. However, the numeral for four is not IIII. Instead, the number four is written as IV. Because the one is before the five we subtract it making four. The same principle applies to the number nine, which is written as IX. There are six instances where subtraction is used:

I can be placed before V (5) and X (10) to make 4 and 9. 
X can be placed before L (50) and C (100) to make 40 and 90. 
C can be placed before D (500) and M (1000) to make 400 and 900.
Given a roman numeral, convert it to an integer. Input is guaranteed to be within the range from 1 to 3999.

*/

/**
Big O Annotation
Time complexity O(n) where n is the amount of characters in the string.
Space complexity O(n) where n is the amount of characters in the string.
*/
func romanToInt(_ s: String) -> Int {
		
    /**
    We need to prepare the map of roman 
    numerals and their values
    */
    var romans: [String:Int] = [
        "I": 1,
        "V": 5,
        "X": 10,
        "L": 50,
        "C": 100,
        "D": 500,
        "M": 1000,
        "IV": 4,
        "IX": 9,
        "XL": 40,
        "XC": 90,
        "CD": 400,
        "CM": 900
    ]

    var result: Int = 0

    /**
    Skipped indices to account for numerals like IX
    Set so we can access ".contains" in constant time.
    */
    var skippedIndex: Set<Int> = []

    /**
    Convert our string to a Character Array 
    for easier index access.
    */
    var array = Array(s)

    // Iterate through the array
    for (index, character) in array.enumerated() {
    
        /**
        Check if the current index has been market as skipped
        using the constant time contains method of the Set. 
        */
        if skippedIndex.contains(index) {
            continue
        }

        /**
        Check if the index + 1 is part of the string
        so we're not falling out of bounds.
        */
        if array.count > index + 1 {

            // Check for the possible longer substring IX XL etc
            let substring = String(character) + String(array[index + 1])
        
            // Check if that string is part of the map
            if let map = romans[substring] {
                result += map

                /**
                If so append the next index to the skipped indices and continue 
                to avoic further excution in this loop
                */
                skippedIndex.append(index + 1)
                continue
            }
        }
    
        /**
        If we don't have a 2 character element,
        just add the current one
        */
        if let map = romans[String(character)] {
            result += map
        }
    }

    return result
}