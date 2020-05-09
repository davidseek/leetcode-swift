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





https://leetcode.com/problems/reconstruct-itinerary/


Given a list of airline tickets represented by pairs of departure and arrival airports [from, to], reconstruct the itinerary in order. All of the tickets belong to a man who departs from JFK. Thus, the itinerary must begin with JFK.

Note:

If there are multiple valid itineraries, you should return the itinerary that has the smallest lexical order when read as a single string. For example, the itinerary ["JFK", "LGA"] has a smaller lexical order than ["JFK", "LGB"].
All airports are represented by three capital letters (IATA code).
You may assume all tickets form at least one valid itinerary.
Example 1:

Input: [["MUC", "LHR"], ["JFK", "MUC"], ["SFO", "SJC"], ["LHR", "SFO"]]
Output: ["JFK", "MUC", "LHR", "SFO", "SJC"]
Example 2:

Input: [["JFK","SFO"],["JFK","ATL"],["SFO","ATL"],["ATL","JFK"],["ATL","SFO"]]
Output: ["JFK","ATL","JFK","SFO","ATL","SFO"]
Explanation: Another possible reconstruction is ["JFK","SFO","ATL","JFK","ATL","SFO"].
             But it is larger in lexical order.

*/

/**
Big O Annotation
Time complexity O(n log m).

I would argue that we have n log m time complexity.
We iterate through the tickets and we need to sort
the destinations in our adjency list alphabetically.
"n" is the number of source airports, 
"m" is the total number of destinations per airports.

Afterwards we just DFS through the graph 
what has a time complexity of O(V+E) Vertex+Edge
but since n of above explanation already stands for all the verticies
and their m for all their edges and O(n log m) is the dominant
term over O(V+E), we drop "V+E"

Space complexity O(V+E) for all verticies and edges aka all
airports and their destinations in the adjency list.
*/
func findItinerary(_ tickets: [[String]]) -> [String] {
	
    /**
    Create an adjency list graph to 
    represent the tickets relations
    */
    var graph = getGraph(of: tickets)

    /**
    The stack that will be the 
    final result itinerary
    */
    var stack: [String] = []

    // DFS through the graph
    setItinerary(into: &stack, from: &graph)

    // Return the stack in reversed order
    return stack.reversed()
}

/**
- parameters:
    - stack: The itinerary final stack
    - graph: Adjacency list graph representation 
    - source: The current airport 
*/
func setItinerary(into stack: inout [String], from graph: inout [String:[String]], for source: String = "JFK") {

    /**
    We need to make sure NOT to create a reference
    variable as we want to manipulate the graph itself.

    Otherwise we might get stackoverflow 
    ATL-SFO SFO-ATL ATL-SFO...
    */
    if graph[source] != nil {

        // While we still have airports to visit
        while !graph[source]!.isEmpty {

            // ...do so...
            setItinerary(into: &stack, from: &graph, for: graph[source]!.removeFirst()) 
        }
    }

    // And add the current source to the stack
    stack.append(source)
}

func getGraph(of tickets: [[String]]) -> [String:[String]] {

    // Adjancency list graph
    var adjancencyList: [ String : [String] ] = [:]

    // Iterate through the tickets
    for ticket in tickets {

        // Get the source and destination
        let source = ticket[0]
        let destination = ticket[1]

        // Check if we have already mapped the source
        if let mapped = adjancencyList[source] {

            /**
            If so add the airports in alphabetically 
            sorted order to the array.
            */
            let destinations = mapped + [destination]
            adjancencyList[source] = destinations.sorted()

        } else {

            // Otherwise create the array
            adjancencyList[source] = [destination]
        } 
    }

    return adjancencyList
}