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





https://leetcode.com/problems/flood-fill/


An image is represented by a 2-D array of integers, each integer representing the pixel value of the image (from 0 to 65535).

Given a coordinate (sr, sc) representing the starting pixel (row and column) of the flood fill, and a pixel value newColor, "flood fill" the image.

To perform a "flood fill", consider the starting pixel, plus any pixels connected 4-directionally to the starting pixel of the same color as the starting pixel, plus any pixels connected 4-directionally to those pixels (also with the same color as the starting pixel), and so on. Replace the color of all of the aforementioned pixels with the newColor.

At the end, return the modified image.

Example 1:
Input: 
image = [[1,1,1],[1,1,0],[1,0,1]]
sr = 1, sc = 1, newColor = 2
Output: [[2,2,2],[2,2,0],[2,0,1]]
Explanation: 
From the center of the image (with position (sr, sc) = (1, 1)), all pixels connected 
by a path of the same color as the starting pixel are colored with the new color.
Note the bottom corner is not colored 2, because it is not 4-directionally connected
to the starting pixel.
Note:

The length of image and image[0] will be in the range [1, 50].
The given starting pixel will satisfy 0 <= sr < image.length and 0 <= sc < image[0].length.
The value of each color in image[i][j] and newColor will be an integer in [0, 65535].

*/

/**
Big O Annotation
Time complexity O(n) where n is the amount of elements in nums.
Space complexity O(n) where n is the amount of elements in nums.
*/
func floodFill(_ image: [[Int]], _ sr: Int, _ sc: Int, _ newColor: Int) -> [[Int]] {
        
    // Check bounds
    guard pixel([sr, sc] ,isInBoundsOf: image) else {
        return image
    }
    
    // The directions the color can fill
    let directions: [[Int]] = [
        [0,1], // right
        [0,-1],// left
        [1,0], // down
        [-1,0] // up
    ]
    
    // Mutable instance of the image
    var image = image
    
    // Our goals:
    //
    //
    //         [1,1,1]        [2,2,2]
    // Before: [1,1,0] After: [2,2,0]
    //         [1,0,1]        [2,0,1]

    
    //
    // Before: [0,0,1] After: [0,0,1]
    //         [1,0,0]        [2,0,0]
    
    // Get the color at the target pixel
    let colorAtPixel = image[sr][sc] 
    image[sr][sc] = newColor
    
    // Get all pixels with that color in image
    var targetPixels: Set<String> = []
    
    // Cache for processed pixels
    var processedPixels: Set<String> = ["\(sr) \(sc)"]
    
    for (i, row) in image.enumerated() {
        
        for (j, pixel) in row.enumerated() {
            
            /**
            Add every possible target pixel 
            to our set.
            */
            if pixel == colorAtPixel {
                targetPixels.insert("\(i) \(j)")
            }
        }
    }
    
    /**
    The current spread of pixels.
    Initially, this will just be the 
    target pixel. From there on then
    all newly painted pixels.
    And then all pixels those have painted
    and so on.
    */
    var spread: Set<String> = ["\(sr) \(sc)"]
    
    // While we still have pixels to process...
    while !targetPixels.isEmpty {
        
        // Holder for the currently changed pixels...
        var changedPixels: Set<String> = []
                    
        // For every element in spread...
        for coordinate in spread {
            
            // Get the coordinates -> "1 0" to [1,0]
            let components = coordinate.components(separatedBy: " ")
            let row = Int(components[0])!
            let pixel = Int(components[1])!
            
            // Now for very direction...
            for direction in directions {
                
                // Get the new target direction
                let targetRow = row + direction[0]
                let targetPixel = pixel + direction[1]
                let targetCoordinate = "\(targetRow) \(targetPixel)"
                
                /**
                Check if we have a target pixel
                and if this pixel has not already been processed.

                This way we make sure, we stay in bounds.
                And we make sure to not process 
                surrounding pixels more than once.
                */
                if targetPixels.contains(targetCoordinate) && 
                    !processedPixels.contains(targetCoordinate) {
                        
                    // Add to newly changes
                    changedPixels.insert(targetCoordinate)

                    // And remove from targets
                    targetPixels.remove(targetCoordinate)
                }
                
                // Add to processed pixels
                processedPixels.insert(targetCoordinate)
            }
        }
        
        /**
        If we have not colored anything 
        new in this iteration, we know,
        that we're not every gonna color anything
        anymore and we can return now.
        */
        if changedPixels.isEmpty {
            return image
        }
        
        // Otherwise change the pixels in the image
        for pixel in changedPixels {
            
            let components = pixel.components(separatedBy: " ")
            let row = Int(components[0])!
            let pixel = Int(components[1])!
            image[row][pixel] = newColor
        }
        
        // And add the changes to the spread
        spread = spread.union(changedPixels)
    }
    
    /**
    Once we're here, every target pixel has changed
    and we can safely return the final image.
    */
    return image
}

private func pixel(_ pixel: [Int], 
                    isInBoundsOf image: [[Int]]) -> Bool {
    
    let row = pixel[0]
    let column = pixel[1]
    
    // Check outter bounds
    guard row >= 0 && row < image.count else {
        return false
    }  
    
    // Check inner bounds
    guard column >= 0 && column < image[row].count else {
        return false
    }
    
    return true
}