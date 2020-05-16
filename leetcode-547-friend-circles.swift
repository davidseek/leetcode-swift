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





https://leetcode.com/problems/friend-circles/


There are N students in a class. Some of them are friends, while some are not. Their friendship is transitive in nature. For example, if A is a direct friend of B, and B is a direct friend of C, then A is an indirect friend of C. And we defined a friend circle is a group of students who are direct or indirect friends.

Given a N*N matrix M representing the friend relationship between students in the class. If M[i][j] = 1, then the ith and jth students are direct friends with each other, otherwise not. And you have to output the total number of friend circles among all the students.

Example 1:
Input: 
[[1,1,0],
 [1,1,0],
 [0,0,1]]
Output: 2
Explanation:The 0th and 1st students are direct friends, so they are in a friend circle. 
The 2nd student himself is in a friend circle. So return 2.
Example 2:
Input: 
[[1,1,0],
 [1,1,1],
 [0,1,1]]
Output: 1
Explanation:The 0th and 1st students are direct friends, the 1st and 2nd students are direct friends, 
so the 0th and 2nd students are indirect friends. All of them are in the same friend circle, so return 1.
Note:
N is in range [1,200].
M[i][i] = 1 for all students.
If M[i][j] = 1, then M[j][i] = 1.

*/

/**
Big O Annotation
Time complexity O(n) where n is the amount of elements in M[0].
Space complexity O(n) where n is the amount of elements in M[0].
*/
func findCircleNum(_ M: [[Int]]) -> Int {
        
    /**
    The idea is that we move 
    through all the people and we 
    check who they're friends with.

    And all we need to know is, 
    have we already seen the person or not.

    If so, then we already know that
    they're in a circle we already checked out.

    If not, then they're in a new circle.
    */
    var seen: Set<Int> = []
    var circles: Int = 0

    /**
    Since each row of this matrix 
    represents one person, 
    we only need to enumerate through the 
    matrix, not also through each row... 
    */
    for (i, row) in M.enumerated() {

        /**
        Check if we have not yet encountered
        the person at this particular row
        */
        if !seen.contains(i) {

            // If not, then it's starting a new circle
            circles += 1

            // And we need to checkout the neighbors.
            dfs(i, M, seen: &seen)
        }
    }

    return circles
}

func dfs(_ i: Int, _ M: [[Int]], seen: inout Set<Int>) {

    /**
    For each person represented by each 
    index for i's row...
    */
    for (j, isFriends) in M[i].enumerated() {

        /**
        ... we need to check if he's a friend
        and that we have not yet seen this person.
        */
        if isFriends == 1 && !seen.contains(j) {

            // If so, then now add him to seen
            seen.insert(j)
            // And continue with his friends
            dfs(j, M, seen: &seen)
        }
    } 
}