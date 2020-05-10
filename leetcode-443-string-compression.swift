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





https://leetcode.com/problems/string-compression/


Given an array of integers, return indices of the two numbers such that they add up to a specific target.

You may assume that each input would have exactly one solution, and you may not use the same element twice.

Example:

Given nums = [2, 7, 11, 15], target = 9,

Because nums[0] + nums[1] = 2 + 7 = 9,
return [0, 1].

*/

/**
Big O Annotation
Time complexity O(n) where n is the amount of elements in chars.
Space complexity O(1) where not using any extra space.
*/
func compress(_ chars: inout [Character]) -> Int {
        
    /**
    If there is no more than 1 character,
    then there is nothing to do for us.
    */
    guard chars.count > 1 else {
        return chars.count
    }
    
    // Get a right and a left pointer
    var left: Int = 0
    var right: Int = 1
    
    // Continue while we haven't reached the end
    while left < chars.count {
        
        // Get the left character
        let leftCharacter = chars[left]

        // And start counting the characters
        var count: Int = 1
        
        // While the right pointer hasn't reached the end
        while right < chars.count {
            
            // Get the right character
            let rightCharacter = chars[right]
            
            /**
            Check if the characters equal,
            we need to move the counter and right pointer up
            */
            if leftCharacter == rightCharacter {
                
                right += 1
                count += 1
                
            } else {

                // If not, break now
                break
            }
        }
        
        // If the character appears more than once
        if count > 1 {

            /**
            ... we need to remove the extra available characters
            startint from the seconda character and up until the 
            last appearance of the same character.
            */
            chars.removeSubrange((left + 1)...((left - 1) + count))

            /**
            Next we nee to get the reverse 
            arranged characters and their counts
            */
            let (characters, characterCount) = getImportable(count)
            
            // ... and add them into the chars array
            for character in characters {
                chars.insert(character, at: left + 1)
            }
            
            /**
            And move the pointer up 
            by the amount of number character's we've added
            */ 
            left += characterCount
            
        }
        
        // And then move the pointers up
        left += 1
        right = left + 1
    }
    
    return chars.count
}

/**
- parameters:
    - count: The count of the given character 

- returns:
Will return a reversed arround and the character count as a tuple.
For example if the count is 13, we will return (characters: ["3", "1"], count: 2)
*/
private func getImportable(_ count: Int) -> (characters: [Character], count: Int) {
    
    let asString = String(count)
    let asArray = Array(asString)
    let reversed: [Character] = asArray.reversed()
    return (characters: reversed, count: reversed.count)
}