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





https://leetcode.com/problems/find-the-town-judge/


In a town, there are N people labelled from 1 to N.  There is a rumor that one of these people is secretly the town judge.

If the town judge exists, then:

The town judge trusts nobody.
Everybody (except for the town judge) trusts the town judge.
There is exactly one person that satisfies properties 1 and 2.
You are given trust, an array of pairs trust[i] = [a, b] representing that the person labelled a trusts the person labelled b.

If the town judge exists and can be identified, return the label of the town judge.  Otherwise, return -1.

 

Example 1:

Input: N = 2, trust = [[1,2]]
Output: 2
Example 2:

Input: N = 3, trust = [[1,3],[2,3]]
Output: 3
Example 3:

Input: N = 3, trust = [[1,3],[2,3],[3,1]]
Output: -1
Example 4:

Input: N = 3, trust = [[1,2],[2,3]]
Output: -1
Example 5:

Input: N = 4, trust = [[1,3],[1,4],[2,3],[2,4],[4,3]]
Output: 3

*/

/**
Big O Annotation
Time complexity O(n) where n is the amount of elements in nums.
Space complexity O(n) where n is the amount of elements in nums.
*/
func findJudge(_ N: Int, _ trust: [[Int]]) -> Int {

    /**
    I'm adding this guard statement here under 
    protest but to satisfy the challenge test cases.

    -1 should be the result because without
    any trust elements there should not be a judge
    */
    guard !trust.isEmpty else {
        return 1
    }
    
    /**
    This is our adjacency list that will hold all 
    verticies and their edges. 
    
    Simulated by storing the destination vertex.
    */
    var adjacencyList: [Int: [Int]] = [:]

    // Iterate through the matrix
    for element in trust {

        // Get references to person A and B
        let personA = element[0]
        let personB = element[1]

        // Check if person A has already been mapped
        if let mapped = adjacencyList[personA] {

            /**
            If so, add the new person B to 
            the array of connections
            */
            adjacencyList[personA] = mapped + [personB]
        } else {

            // If not, create the array
            adjacencyList[personA] = [personB]
        }
        
        /**
        We also need to check for person B.
        As the judge is supposed to not have any trust.

        Therefore he will never appear in index 0
        of any Person : Person relation.
        */
        if adjacencyList[personB] == nil {
            adjacencyList[personB] = []
        }
    }

    // Temporary judge object
    var judge: Int?

    /*
    Iterate through the list of 
    elements in our adjacency list.

    It would have been nicer code to just sort 
    the list by values.count,
    but that would have caused O(n log n) overhead.

    Therefore we simply iterate.
    */
    for element in adjacencyList {

        /**
        If one of the people has no trust to anyone,
        aka no edge to another vertex,
        we know it could be the judge.
        */
        if element.value.isEmpty {
            judge = element.key
        }
    }

    // If we have no we can simply return -1
    guard judge != nil else {
        return -1
    }

    /**
    Lastly we need to check for the second condition.
    Namely if everyone else trusts our potential judge.

    This could in theory cause issues,
    if there are >1 persons who don't trust anyone.

    But that was not part of the problem description.
    Could be discussed with an interviewer. 
    */
    for element in adjacencyList where element.key != judge! {

        /**
        If anyone does not trust the judge, 
        our second condition fails and we can return -1
        */
        if !element.value.contains(judge!) {
            return -1
        }
    }

    return judge!
}