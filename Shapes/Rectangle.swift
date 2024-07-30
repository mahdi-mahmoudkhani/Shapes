//
//  Rectangle.swift
//  Shapes
//
//  Created by Aref on 7/30/24.
//

import Foundation
// Define the Shape protocol with area and perimeter methods
protocol Shape {
    func area() -> Double
    func perimeter() -> Double
}
// Rectangle class conforming to the Shape protocol
class Rectangle: Shape {
    let width: Double
    let height: Double
    
    // Initialize with width and height
    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }
    
    // Calculate the area
    func area() -> Double {
        return width * height
    }
    
    // Calculate the perimeter
    func perimeter() -> Double {
        return 2 * (width + height)
    }
}
