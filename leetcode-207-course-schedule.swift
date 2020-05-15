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





https://leetcode.com/problems/course-schedule/


There are a total of numCourses courses you have to take, labeled from 0 to numCourses-1.

Some courses may have prerequisites, for example to take course 0 you have to first take course 1, which is expressed as a pair: [0,1]

Given the total number of courses and a list of prerequisite pairs, is it possible for you to finish all courses?

 

Example 1:

Input: numCourses = 2, prerequisites = [[1,0]]
Output: true
Explanation: There are a total of 2 courses to take. 
             To take course 1 you should have finished course 0. So it is possible.
Example 2:

Input: numCourses = 2, prerequisites = [[1,0],[0,1]]
Output: false
Explanation: There are a total of 2 courses to take. 
             To take course 1 you should have finished course 0, and to take course 0 you should
             also have finished course 1. So it is impossible.
 

Constraints:

The input prerequisites is a graph represented by a list of edges, not adjacency matrices. Read more about how a graph is represented.
You may assume that there are no duplicate edges in the input prerequisites.
1 <= numCourses <= 10^5

*/

/**
Big O Annotation
Time complexity O(n) where n is the amount of elements from 0...numCourses.
Space complexity O(n) where n is the amount of elements from 0...numCourses.
*/
func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
        
    /**
    Create a graph of empty arrays for each course.
    The graph represents each courses goal.

    For example: I need this course to be able to do XY.
    I need to finish course 2 to be able to do courses [3,4]
    */
    var graph: [[Int]] = Array(repeating: [], count: numCourses)
    
    // Iterate through the prerequisites to fill the graph
    for element in prerequisites {

        // Set for each requirement the course you can do once done
        graph[element[1]].append(element[0])
    }
    
    /**
    Init a visiting and visited array.
    Both representing the total amount of courses and both
    implemented false to begin with.
    */
    var visiting: [Bool] =  Array(repeating: false, count: numCourses)
    var visited: [Bool] =  Array(repeating: false, count: numCourses)
    
    // Iterate through each course
    for course in 0..<numCourses {
        
        // And check if we can find a circle
        if foundCircle(in: graph, at: course, visiting: &visiting, visited: &visited) {
            return false
        }
    }
    
    return true
}

private func foundCircle(in graph: [[Int]], 
                        at course: Int, 
                        visiting: inout [Bool], 
                        visited: inout [Bool]) -> Bool {
    
    /**
    If we are currently visiting the neighbors of this course,
    it means that we have found a circle.
    Example: Course 0 requires course 1, and course 1 course 0.
    */
    if visiting[course] == true {
        return true 
    }
    
    /**
    If we have already visited this node, we know it's fine
    and we can return true. There can't be a circle
    otherwise we would have never successfully visited it.
    */
    if visited[course] == true {
        return false
    }
    
    /**
    Set the current node to visiting,
    to be able to catch it above on the recursion
    */
    visiting[course] = true
    
    // Iterate through the current node's neighbors
    for neighbor in graph[course] {
        
        // If we find a circle, return true
        if foundCircle(in: graph, at: neighbor, visiting: &visiting, visited: &visited) {
            return true 
        }
    }
    
    // Set the visiting back to false
    visiting[course] = false

    // And update the visitation
    visited[course] = true
    return false
}