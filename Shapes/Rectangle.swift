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

// Extend the Shape protocol to provide default implementation
extension Shape {
    func description() -> String {
        return "Area: \(area()), Perimeter: \(perimeter())"
    }
}

// Rectangle class conforming to the Shape protocol
class Rectangle: Shape {
    var width: Double
    var height: Double
    
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
