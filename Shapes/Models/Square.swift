//
//  Square.swift
//  Shapes
//
//  Created by Mahdi on 5/9/1403 AP.
//

import Foundation

protocol Shape {
    var side: Double { get }
    func perimeter() -> Double
    func area() -> Double
}

class SquareModel: Shape {
    
    private (set) var side: Double
    
    init(withSide side: Double = 0) {
        self.side = side
    }
    
    func perimeter() -> Double {
        return side * 4
        }
    
    func area() -> Double {
        return pow(self.side, 2)
    }
    
}

