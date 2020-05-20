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





https://leetcode.com/problems/frog-jump/


A frog is crossing a river. The river is divided into x units and at each unit there may or may not exist a stone. The frog can jump on a stone, but it must not jump into the water.

Given a list of stones' positions (in units) in sorted ascending order, determine if the frog is able to cross the river by landing on the last stone. Initially, the frog is on the first stone and assume the first jump must be 1 unit.

If the frog's last jump was k units, then its next jump must be either k - 1, k, or k + 1 units. Note that the frog can only jump in the forward direction.

Note:

The number of stones is ≥ 2 and is < 1,100.
Each stone's position will be a non-negative integer < 231.
The first stone's position is always 0.
Example 1:

[0,1,3,5,6,8,12,17]

There are a total of 8 stones.
The first stone at the 0th unit, second stone at the 1st unit,
third stone at the 3rd unit, and so on...
The last stone at the 17th unit.

Return true. The frog can jump to the last stone by jumping 
1 unit to the 2nd stone, then 2 units to the 3rd stone, then 
2 units to the 4th stone, then 3 units to the 6th stone, 
4 units to the 7th stone, and 5 units to the 8th stone.
Example 2:

[0,1,2,3,4,8,9,11]

Return false. There is no way to jump to the last stone as 
the gap between the 5th and 6th stone is too large.

*/

/**
Big O Annotation
Time complexity O(3^n) because of the 3 different choices we have,
where n is the amount of elements in stones.
Space complexity O(n) where n is the amount of elements in stones.
*/

typealias Jump = (stone: Int, distance: Int)

func canCross(_ stones: [Int]) -> Bool {
    
    // Reference to the goal, to make the code cleaner
    let goal: Int = stones[stones.count - 1]

    // Set of stones for O(1) .contains operation
    let stones: Set<Int> = Set(stones)
    
    // All variations of distance altering
    let variations: [Int] = [
        -1,
        0,
        1
    ]
    
    // Stones we have visited before to spead up the DFS
    var visited: [String: Bool] = [:]
    
    // Init a stack...
    var stack = Stack()

    // ... and add the first stone and distance
    stack.push((stone: 0, distance: 0))
    
    // While the stack is not empty...
    while !stack.isEmpty {
        
        // Pop the last one
        let jump = stack.pop()!

        // And mark it visited
        visited["\(jump)"] = true
        
        // For all 3 variations...
        for variation in variations {
            
            // Calculate the new distance
            let distance = (jump.distance + variation)
            
            // Skip if the distance is not forwards
            guard distance > 0 else {
                continue
            }
            
            // Get the new position
            let newPosition = jump.stone + distance
            
            // Check if it's our goal
            if newPosition == goal {
                return true
            }
            
            // Check if it's part of the array
            if stones.contains(newPosition) {
                
                // If so, get a new Jump
                let tuple: Jump = (stone: newPosition, distance: distance)
                
                // And if we haven't been there before, 
                if visited["\(tuple)"] == nil {

                    // ... add it.
                    stack.push(tuple)
                }
                
            }
        }
    }
    
    /**
    If we fall all the way through the while loop,
    then we know we can't reach the end and have to...
    */
    return false
}

/**
Simple Stack API.
All operations O(1) in time.
*/
struct Stack {
    private var stack: [Jump] = []
    
    public var isEmpty: Bool {
        return stack.isEmpty
    } 
    
    init() {}
    
    public mutating func push(_ element: Jump) {
        stack.append(element)
    }
    
    public mutating func pop() -> Jump? {
        return stack.popLast()
    }
}