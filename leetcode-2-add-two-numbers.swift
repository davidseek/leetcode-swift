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





https://leetcode.com/problems/two-sum/


Given an array of integers, return indices of the two numbers such that they add up to a specific target.

You may assume that each input would have exactly one solution, and you may not use the same element twice.

Example:

Given nums = [2, 7, 11, 15], target = 9,

Because nums[0] + nums[1] = 2 + 7 = 9,
return [0, 1].

*/

/**
Big O Annotation
Time complexity O(n) where n is the combined amount of elements in l1 and l2.
Space complexity O(n) where n is the combined amount of elements in l1 and l2.
*/
func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        
    var l1Values: [Int] = []
    var l2Values: [Int] = []
    
    /**
    Get all values from l1 from root to leave
    and add them to the respective values array.
    */
    l1?.traverseList { value in 
        l1Values.append(value)
    }
    
    // Same for l2
    l2?.traverseList { value in 
        l2Values.append(value)
    }
    
    var result: [Int] = []
    var carry: Int = 0 
    var index: Int = 0 
    
    /**
    While clause is true while the current index
    is at least smaller than either l1 values or l2 values.
    */
    while index < l1Values.count || index < l2Values.count {
        
        /**
        Temporary values used in case
        we have already reached the end of either list
        */
        var l1: Int = 0 
        var l2: Int = 0 
        
        // Check if l1 contains the current index...
        if l1Values.indices.contains(index) {

            // ... and if so, set as the current value
            l1 = l1Values[index]
        }
        
        // Same for l2
        if l2Values.indices.contains(index) {
            l2 = l2Values[index]
        }
        
        /**
        Add the current value of l1 and l2 with the
        carry of the last round. 
        
        In the first round the carry is 0

        The carry is the >9 remainder of the mathematical sum.
        For example 4 + 6 = 10
        The remainder is 1,
        the value is 0.
        */
        let sum = l1 + l2 + carry 
        let value = sum % 10
        carry = sum / 10
        
        result.append(value)
        index += 1
    }
    
    /**
    If the carry is > 0, then we need to add it.
    Example: 400 + 600 = 1000
    
    The above iteration only goes over 3 loops,
    so the remaining carry of 1 needs to be added here
    */
    if carry > 0 {
        result.append(carry)
    }
    
    /**
    Init a dummy list of -1 (or any other value).
    This will be the object we're appending our new list to
    */
    var dummy: ListNode? = ListNode(-1)

    /**
    Hold a reference to our head of the list
    so we can later return head.next 
    to lost the -1 root
    */ 
    let head: ListNode? = dummy
    
    // Iterate through the result
    for element in result {

        /** 
        Set the current's element next to 
        the new node we want to create
        */
        dummy?.next = ListNode(element)

        /**
        And set the dummy to next 
        of the current element
        */
        dummy = dummy?.next
    }
    
    // Return .next to lose the -1 root
    return head?.next
}

extension ListNode {
    
    /**
    Function to get the current and next
    value in the nodes. Called recursively.
    */
    func traverseList(_ result: (Int) -> Void) {
        result(val)
        next?.traverseList(result)
    } 
}